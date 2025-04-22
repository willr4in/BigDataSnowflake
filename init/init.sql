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

\i /snowflake/ddl.sql;
\i /snowflake/dml.sql;
