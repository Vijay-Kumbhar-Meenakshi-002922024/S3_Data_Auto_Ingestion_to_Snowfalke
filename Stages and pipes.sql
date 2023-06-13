--when you load the data from sql (insert) no copy history is created where as webui will create it.

use schema landing_zone;

--stages

create or replace stage delta_orders_s3
url = "s3://snowflake-data-mvk/delta/orders/"
comment = 'feed delta order files';

create or replace stage delta_items_s3
url = "s3://snowflake-data-mvk/delta/items/"
comment = 'feed delta items files';

create or replace stage delta_customer_s3
url = "s3://snowflake-data-mvk/delta/customer/"
comment = 'feed delta customer files';

show stages;

--pipes

create or replace pipe order_pipe
    auto_ingest = true
as
    copy into landing_order from @delta_orders_s3
    file_format = (type = csv COMPRESSION = none)
    pattern = '.*order.*[.]csv'
    ON_ERROR = 'continue';

create or replace pipe item_pipe
    auto_ingest = true
as
    copy into landing_order from @delta_items_s3
    file_format = (type = csv COMPRESSION = none)
    pattern = '.*item.*[.]csv'
    ON_ERROR = 'continue';

create or replace pipe customer_pipe
    auto_ingest = true
as
    copy into landing_order from @delta_customer_s3
    file_format = (type = csv COMPRESSION = none)
    pattern = '.*customer.*[.]csv'
    ON_ERROR = 'continue';
    
--Notification channel is generate when you create a pipe to link to your aws sqs
show pipes;


