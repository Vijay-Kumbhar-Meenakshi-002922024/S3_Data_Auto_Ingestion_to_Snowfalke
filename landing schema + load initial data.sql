--step 1
-- Three schemas for landing, curated and consumption zones

create or replace schema landing_zone;
create or replace schema curated_zone;
create or replace schema consumption_zone;

show schemas;

--step 2
-- creating orders, customers, items tables in landing zone
-- landing table will be transient tables
-- all the fields tables are varchar and not having any specific data type to make sure all the data is loaded

use schema landing_zone;
create or replace transient table landing_item (
        item_id varchar,
        item_desc varchar,
        start_date varchar,
        end_date varchar,
        price varchar,
        item_class varchar,
        item_CATEGORY varchar
) comment ='this is item table within landing schema';
            
create or replace transient table landing_customer (
    customer_id varchar,
    salutation varchar,
    first_name varchar,
    last_name varchar,
    birth_day varchar,
    birth_month varchar,
    birth_year varchar,
    birth_country varchar,
    email_address varchar
) comment ='this is customer table within landing schema';

create or replace transient table landing_order (
    order_date varchar,
    order_time varchar,
    item_id varchar,
    item_desc varchar,
    customer_id varchar,
    salutation varchar,
    first_name varchar,
    last_name varchar,
    store_id varchar,
    store_name varchar,
    order_quantity varchar,
    sale_price varchar,
    disount_amt varchar,
    coupon_amt varchar,
    net_paid varchar,
    net_paid_tax varchar,
    net_profit varchar
) comment ='this is order table within landing schema';


show tables;

--step 3
--create a file format and then load historical data or first load to this landing tables

-- create a file format
create or replace file format mycsv_webui
        type = 'csv'
        compression = 'auto'
        field_delimiter = ','
        record_delimiter = '\n'
        skip_header = 1
        field_optionally_enclosed_by = '\042'
        null_if = ('\\N');

-- load historical data or first load to this landing tables

-- custome - 22 , item - 21 , order - 19

-- part 2 - curated zone
-- load curated zones table using landing zone table using sql
show tables;
