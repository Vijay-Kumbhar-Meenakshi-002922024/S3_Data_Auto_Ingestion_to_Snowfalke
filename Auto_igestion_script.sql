--Using admin role

use role accountadmin;

-- Create a integration storage to setup of a connection between Snowflake and an external cloud storage provider (AWS S3)
create or replace storage integration s3_int
type = external_stage
storage_provider = S3
enabled = TRUE
storage_aws_role_arn = 'arn:aws:iam::591034249457:role/snowflakerole'
storage_allowed_locations = ('s3://snowflake-s3-mvk/');

-- shows the integration properties and thier values
desc integration s3_int;

-- create a database to store the data from the external storage
create or replace database snowpipe;

-- creates an object named snowstage which regerences the storage loctaion where the data is present
create or replace stage snowpipe.public.snowstage
URL = 's3://snowflake-s3-mvk/'
storage_integration = s3_int;

-- All the stages in the database is listed
show stages;

-- create a table with json format
create or replace table snowpipe.public.snowtable(jsontext variant);

-- create a pipe with auto ingest enabled
create or replace pipe snowpipe.public.snowpipe auto_ingest = true as
    copy into snowpipe.public.snowtable
    from @snowpipe.public.snowstage
    file_format = (type = 'JSON');

show pipes;

--TEST.CURATED_ZONE

-- check if the data is loaded when you load the data on s3
select * from snowpipe.public.snowtable;

-- select *
-- from table(information_schema.copy_history(table_name => 'snowpipe.public.snowtable', start_time=> dateadd(hours, -1,current_timestamp())));