Streams:
================
Streams will be used for audit trail purpose Techinically CDC(Change data capture) .
once creates stream   whenever  DML statements is committed to the table internally table version will be created
Using 3 columns like METADATA$ACTION,METADATA$ISUPDATE,METADATA$ROW_ID
Having different types of streams like Standard,Append-only,Insert-only
 
CREATE STREAM my_stream ON TABLE my_table;
 
 
Tasks:
=====================
Tasks Mainly for the scheding the jobs using cron time scheduling,with freaquency or depandancy jobs.
 
CREATE TASK task_name
  WAREHOUSE = MY_WH
  SCHEDULE = '60 minute'   /SCHEDULE = 'USING CRON * 11 * * MON UTC' (minut hour day month week)
  AS
   INSERT INTO my_table VALUES (1, ‘Hello World’)/call procedure_name;
 
Cloning:
=======================
Cloning means create the new object with utilizing the new memory.
if creates the new cloned table wont create the new micro partitions just refer the  old micropartitions of source table .
Once DML operation performed on the source table new micro partitions will be created for old table.For derived table still old micropartitions will be referred.
Or If DML operations performed on Derived table new micropartitions will be created for new table for source table will refer the old micropartitions.
 
Time travel:
==========================
Mainly using for the debugging purpose and re-run jobs with old data.
Its depands on retention time(DATA_RETENTION_TIME_IN_DAYS)
This we can use in 3 ways
1)using correct timestamp value
    SELECT * FROM my_table AT(TIMESTAMP => 'Wed, 26 Jun 2024 09:20:00 -0700'::timestamp_tz);
2)using offset (How many number of sec before)
    SELECT * FROM my_table AT(OFFSET => -60*5);
3)Using Query_id:
             SELECT * FROM my_table BEFORE(STATEMENT => '8e5d0ca9-005e-44e6-b858-a8f5b37c5726');
 
Types of tables:
=======================
Permanent Tables:   Stores data permanently .These will allow max 90 days of retention period and also consists of fail safe option
Transient Tables:   Stores data permanently but These will allow max 7 days of retention period default 1 day. And no Fail safe option.
Temporary Tables :  wont store data permanently Only store data 1day.wont have any time travel and fail safe optionality using for work tables

hybrid table:
===================
A hybrid table supports unique and referential integrity constraint enforcement that is critical for transactional workloads. You can use a hybrid table along with other Snowflake tables and features to power Unistore workloads that bring transactional and analytical data together in a single platform.

Apache Iceberg™ tables
==========================
open table format specification, which provides an abstraction layer on data files stored in open formats and supports features such as:
ACID (atomicity, consistency, isolation, durability) transactions
Schema evolution
Hidden partitioning
Table snapshots

Dynamic tables:
==================================
Dynamic tables  automated way to transform data. 
Instead of managing transformation steps with tasks and scheduling, you define the end state using dynamic tables and let Snowflake handle the pipeline management.

Declarative programming: Define your pipeline outcomes using declarative SQL without worrying about the steps to achieve them, reducing complexity.

Transparent orchestration: Easily create pipelines of various shapes, from linear chains to directed graphs, by chaining dynamic tables together. Snowflake manages the orchestration and scheduling of pipeline refresh based on your data freshness target.

Performance boost with incremental processing: For favorable workloads that are suited for incremental processing, dynamic tables can provide a significant performance improvement over full refreshes.

Easy switching: Transition seamlessly from batch to streaming with a single ALTER DYNAMIC TABLE command. You control how often data is refreshed in your pipeline, which helps balance cost and data freshness.

Operationalization: Dynamic tables are fully observable and manageable through Snowsight, and also offer programmatic access to build your own observability apps.


Data lineage
==================
Data lineage is the process of tracking data as it moves through a system, from its origin to its final destination and use.
It documents the data's journey, including how it was generated, transformed, and used. Data lineage can help you understand the data you're using, and ensure that it's reliable and meets quality standards.