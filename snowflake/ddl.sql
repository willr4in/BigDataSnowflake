-- Таблица клиентов
CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    cust_fname TEXT,
    cust_lname TEXT,
    cust_age INT,
    cust_email TEXT,
    cust_country TEXT,
    cust_zip TEXT,
    pet_type TEXT,
    pet_name TEXT,
    pet_breed TEXT,
    pet_group TEXT
);

-- Таблица продавцов
CREATE TABLE dim_seller (
    seller_id SERIAL PRIMARY KEY,
    agent_fname TEXT,
    agent_lname TEXT,
    agent_email TEXT,
    agent_country TEXT,
    agent_zip TEXT
);

-- Таблица магазинов
CREATE TABLE dim_store (
    store_id SERIAL PRIMARY KEY,
    shop_name TEXT,
    shop_address TEXT,
    shop_city TEXT,
    shop_region TEXT,
    shop_country TEXT,
    shop_phone TEXT,
    shop_email TEXT
);

-- Таблица продуктов
CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    item_name TEXT,
    item_category TEXT,
    item_weight NUMERIC,
    item_color TEXT,
    item_size TEXT,
    item_brand TEXT,
    item_material TEXT,
    item_description TEXT,
    item_rating NUMERIC,
    item_reviews INT,
    item_launch_date DATE,
    item_expiry_date DATE,
    item_price NUMERIC
);

-- Таблица поставщиков
CREATE TABLE dim_supplier (
    supplier_id SERIAL PRIMARY KEY,
    vendor_name TEXT,
    vendor_contact TEXT,
    vendor_email TEXT,
    vendor_phone TEXT,
    vendor_address TEXT,
    vendor_city TEXT,
    vendor_country TEXT
);

-- Факт-продажи
CREATE TABLE sales_fact (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES dim_customer(customer_id),
    seller_id INT REFERENCES dim_seller(seller_id),
    store_id INT REFERENCES dim_store(store_id),
    product_id INT REFERENCES dim_product(product_id),
    supplier_id INT REFERENCES dim_supplier(supplier_id),
    transaction_date DATE,
    items_sold INT,
    transaction_total NUMERIC
);
