-- Загрузка уникальных покупателей
INSERT INTO dim_customer (
    cust_fname, cust_lname, cust_age, cust_email,
    cust_country, cust_zip, pet_type, pet_name, pet_breed, pet_group
)
SELECT DISTINCT
    buyer_fname, buyer_lname, buyer_age, buyer_email,
    buyer_country, buyer_zip, animal_type, animal_name,
    animal_breed, pet_group
FROM pet_sales_raw;

-- Загрузка уникальных продавцов
INSERT INTO dim_seller (
    agent_fname, agent_lname, agent_email, agent_country, agent_zip
)
SELECT DISTINCT
    seller_fname, seller_lname, seller_email,
    seller_country, seller_zip
FROM pet_sales_raw;

-- Загрузка уникальных магазинов
INSERT INTO dim_store (
    shop_name, shop_address, shop_city, shop_region,
    shop_country, shop_phone, shop_email
)
SELECT DISTINCT
    store_title, store_addr, store_city, store_region,
    store_country, store_tel, store_mail
FROM pet_sales_raw;

-- Загрузка уникальных продуктов
INSERT INTO dim_product (
    item_name, item_category, item_weight, item_color,
    item_size, item_brand, item_material, item_description,
    item_rating, item_reviews, item_launch_date,
    item_expiry_date, item_price
)
SELECT DISTINCT
    product_title, product_type, product_mass, product_shade,
    product_dim, product_maker, product_fabric, product_info,
    product_score, product_comments, product_launch,
    product_expire, product_cost
FROM pet_sales_raw;

-- Загрузка уникальных поставщиков
INSERT INTO dim_supplier (
    vendor_name, vendor_contact, vendor_email,
    vendor_phone, vendor_address, vendor_city, vendor_country
)
SELECT DISTINCT
    supplier_title, supplier_contact_person, supplier_mail,
    supplier_tel, supplier_addr, supplier_town, supplier_nation
FROM pet_sales_raw;

-- Загрузка фактов продаж
INSERT INTO sales_fact (
    customer_id,
    seller_id,
    store_id,
    product_id,
    supplier_id,
    transaction_date,
    items_sold,
    transaction_total
)
SELECT
    dc.customer_id,
    ds.seller_id,
    dst.store_id,
    dp.product_id,
    dsu.supplier_id,
    raw.sale_dt,
    raw.items_amount,
    raw.total_cost
FROM pet_sales_raw raw
JOIN dim_customer dc ON
    TRIM(raw.buyer_fname) = TRIM(dc.cust_fname) AND
    TRIM(raw.buyer_lname) = TRIM(dc.cust_lname) AND
    TRIM(raw.buyer_email) = TRIM(dc.cust_email)
JOIN dim_seller ds ON
    TRIM(raw.seller_fname) = TRIM(ds.agent_fname) AND
    TRIM(raw.seller_lname) = TRIM(ds.agent_lname) AND
    TRIM(raw.seller_email) = TRIM(ds.agent_email)
JOIN dim_store dst ON
    TRIM(raw.store_title) = TRIM(dst.shop_name) AND
    TRIM(raw.store_mail) = TRIM(dst.shop_email)
JOIN dim_product dp ON
    TRIM(raw.product_title) = TRIM(dp.item_name) AND
    ROUND(raw.product_cost::NUMERIC, 2) = ROUND(dp.item_price::NUMERIC, 2)
JOIN dim_supplier dsu ON
    TRIM(raw.supplier_title) = TRIM(dsu.vendor_name) AND
    TRIM(raw.supplier_mail) = TRIM(dsu.vendor_email);
