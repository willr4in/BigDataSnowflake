-- Удаление временной таблицы, если существует
DROP TABLE IF EXISTS pet_sales;

-- ===============================
-- Создание таблицы для загрузки сырых данных
-- ===============================
CREATE TABLE pet_sales (
    record_id INT,
    cust_fname TEXT,
    cust_lname TEXT,
    cust_age INT,
    cust_email TEXT,
    cust_country TEXT,
    cust_zip TEXT,
    pet_type TEXT,
    pet_name TEXT,
    pet_breed TEXT,
    agent_fname TEXT,
    agent_lname TEXT,
    agent_email TEXT,
    agent_country TEXT,
    agent_zip TEXT,
    item_name TEXT,
    item_category TEXT,
    item_price NUMERIC,
    item_stock INT,
    transaction_date DATE,
    customer_ref INT,
    seller_ref INT,
    item_ref INT,
    items_sold INT,
    transaction_total NUMERIC,
    shop_name TEXT,
    shop_address TEXT,
    shop_city TEXT,
    shop_region TEXT,
    shop_country TEXT,
    shop_phone TEXT,
    shop_email TEXT,
    pet_group TEXT,
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
    vendor_name TEXT,
    vendor_contact TEXT,
    vendor_email TEXT,
    vendor_phone TEXT,
    vendor_address TEXT,
    vendor_city TEXT,
    vendor_country TEXT
);

-- ==========================================
-- Импорт данных из CSV-файлов
-- ==========================================
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

-- Выполнение DDL и DML скриптов 
\i /snowflake/ddl.sql;
\i /snowflake/dml.sql;
