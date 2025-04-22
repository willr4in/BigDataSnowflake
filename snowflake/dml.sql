INSERT INTO dim_customer (
    first_name, last_name, age, email, country, postal_code,
    pet_type, pet_name, pet_breed, pet_category
)
SELECT DISTINCT
    customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type,
    customer_pet_name, customer_pet_breed, pet_category
FROM pet_sales;

INSERT INTO dim_seller (
    first_name, last_name, email, country, postal_code
)
SELECT DISTINCT
    seller_first_name, seller_last_name, seller_email,
    seller_country, seller_postal_code
FROM pet_sales;

INSERT INTO dim_store (
    name, location, city, state, country, phone, email
)
SELECT DISTINCT
    store_name, store_location, store_city, store_state,
    store_country, store_phone, store_email
FROM pet_sales;

INSERT INTO dim_product (
    name, category, weight, color, size, brand,
    material, description, rating, reviews,
    release_date, expiry_date, price
)
SELECT DISTINCT
    product_name, product_category, product_weight,
    product_color, product_size, product_brand,
    product_material, product_description,
    product_rating, product_reviews,
    product_release_date, product_expiry_date,
    product_price
FROM pet_sales;

INSERT INTO dim_supplier (
    name, contact, email, phone, address, city, country
)
SELECT DISTINCT
    supplier_name, supplier_contact, supplier_email,
    supplier_phone, supplier_address,
    supplier_city, supplier_country
FROM pet_sales;

INSERT INTO sales_fact (
    customer_id,
    seller_id,
    store_id,
    product_id,
    supplier_id,
    sale_date,
    quantity,
    total_price
)
SELECT
    dc.customer_id,
    ds.seller_id,
    dst.store_id,
    dp.product_id,
    dsu.supplier_id,
    ps.sale_date,
    ps.sale_quantity,
    ps.sale_total_price
FROM pet_sales ps
JOIN dim_customer dc ON
    TRIM(ps.customer_first_name) = TRIM(dc.first_name) AND
    TRIM(ps.customer_last_name) = TRIM(dc.last_name) AND
    TRIM(ps.customer_email) = TRIM(dc.email)
JOIN dim_seller ds ON
    TRIM(ps.seller_first_name) = TRIM(ds.first_name) AND
    TRIM(ps.seller_last_name) = TRIM(ds.last_name) AND
    TRIM(ps.seller_email) = TRIM(ds.email)
JOIN dim_store dst ON
    TRIM(ps.store_name) = TRIM(dst.name) AND
    TRIM(ps.store_email) = TRIM(dst.email)
JOIN dim_product dp ON
    TRIM(ps.product_name) = TRIM(dp.name) AND
    ROUND(ps.product_price::NUMERIC, 2) = ROUND(dp.price::NUMERIC, 2)
JOIN dim_supplier dsu ON
    TRIM(ps.supplier_name) = TRIM(dsu.name) AND
    TRIM(ps.supplier_email) = TRIM(dsu.email);
