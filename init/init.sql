-- ===================================
-- Удаление всех старых таблиц
-- ===================================
DROP TABLE IF EXISTS sales_fact CASCADE;
DROP TABLE IF EXISTS dim_customer CASCADE;
DROP TABLE IF EXISTS dim_seller CASCADE;
DROP TABLE IF EXISTS dim_store CASCADE;
DROP TABLE IF EXISTS dim_product CASCADE;
DROP TABLE IF EXISTS dim_supplier CASCADE;
DROP TABLE IF EXISTS pet_sales;

-- ====================================
-- Создание временной таблицы
-- для загрузки "сырых" CSV-данных
-- ====================================
CREATE TABLE pet_sales (
    id INT,
    customer_first_name TEXT,
    customer_last_name TEXT,
    customer_age INT,
    customer_email TEXT,
    customer_country TEXT,
    customer_postal_code TEXT,
    customer_pet_type TEXT,
    customer_pet_name TEXT,
    customer_pet_breed TEXT,
    seller_first_name TEXT,
    seller_last_name TEXT,
    seller_email TEXT,
    seller_country TEXT,
    seller_postal_code TEXT,
    product_name TEXT,
    product_category TEXT,
    product_price NUMERIC,
    product_quantity INT,
    sale_date DATE,
    sale_customer_id INT,
    sale_seller_id INT,
    sale_product_id INT,
    sale_quantity INT,
    sale_total_price NUMERIC,
    store_name TEXT,
    store_location TEXT,
    store_city TEXT,
    store_state TEXT,
    store_country TEXT,
    store_phone TEXT,
    store_email TEXT,
    pet_category TEXT,
    product_weight NUMERIC,
    product_color TEXT,
    product_size TEXT,
    product_brand TEXT,
    product_material TEXT,
    product_description TEXT,
    product_rating NUMERIC,
    product_reviews INT,
    product_release_date DATE,
    product_expiry_date DATE,
    supplier_name TEXT,
    supplier_contact TEXT,
    supplier_email TEXT,
    supplier_phone TEXT,
    supplier_address TEXT,
    supplier_city TEXT,
    supplier_country TEXT
);

-- ========================================
-- Загрузка CSV-файлов в pet_sales
-- ========================================
COPY pet_sales FROM '/csvdata/MOCK_DATA (1).csv' WITH (FORMAT csv, HEADER true);
COPY pet_sales FROM '/csvdata/MOCK_DATA (2).csv' WITH (FORMAT csv, HEADER true);
COPY pet_sales FROM '/csvdata/MOCK_DATA (3).csv' WITH (FORMAT csv, HEADER true);
COPY pet_sales FROM '/csvdata/MOCK_DATA (4).csv' WITH (FORMAT csv, HEADER true);
COPY pet_sales FROM '/csvdata/MOCK_DATA (5).csv' WITH (FORMAT csv, HEADER true);
COPY pet_sales FROM '/csvdata/MOCK_DATA (6).csv' WITH (FORMAT csv, HEADER true);
COPY pet_sales FROM '/csvdata/MOCK_DATA (7).csv' WITH (FORMAT csv, HEADER true);
COPY pet_sales FROM '/csvdata/MOCK_DATA (8).csv' WITH (FORMAT csv, HEADER true);
COPY pet_sales FROM '/csvdata/MOCK_DATA (9).csv' WITH (FORMAT csv, HEADER true);
COPY pet_sales FROM '/csvdata/MOCK_DATA.csv'     WITH (FORMAT csv, HEADER true);

-- ======================================
-- Создание таблиц измерений
-- =========== DDL ======================

CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    age INT,
    email TEXT,
    country TEXT,
    postal_code TEXT,
    pet_type TEXT,
    pet_name TEXT,
    pet_breed TEXT,
    pet_category TEXT
);

CREATE TABLE dim_seller (
    seller_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    country TEXT,
    postal_code TEXT
);

CREATE TABLE dim_store (
    store_id SERIAL PRIMARY KEY,
    name TEXT,
    location TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    phone TEXT,
    email TEXT
);

CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    name TEXT,
    category TEXT,
    weight NUMERIC,
    color TEXT,
    size TEXT,
    brand TEXT,
    material TEXT,
    description TEXT,
    rating NUMERIC,
    reviews INT,
    release_date DATE,
    expiry_date DATE,
    price NUMERIC
);

CREATE TABLE dim_supplier (
    supplier_id SERIAL PRIMARY KEY,
    name TEXT,
    contact TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    city TEXT,
    country TEXT
);

-- =============================
-- Создание таблицы фактов
-- =============================

CREATE TABLE sales_fact (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES dim_customer(customer_id),
    seller_id INT REFERENCES dim_seller(seller_id),
    store_id INT REFERENCES dim_store(store_id),
    product_id INT REFERENCES dim_product(product_id),
    supplier_id INT REFERENCES dim_supplier(supplier_id),
    sale_date DATE,
    quantity INT,
    total_price NUMERIC
);

-- =============================
-- Заполнение измерений
-- ========== DML ==============

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

-- =============================
-- Заполнение таблицы фактов
-- =============================

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
