Hi 
Myself Ashok
I have 5+ experience in IT field on Migration and Implementation projects 
Currently working for COGNIZANT Prior to that worked for Accenture.
I have skill set of Snowflake,Oracle SQL,PLSQL,Python,Matillion.
Currently working for Melbourne Water project. 

--------project description----------

Melbourne Water  is Australia based Company.Storing the data about rivers,sub rivers , Dams details,Water management details,Incoming and Outgoing Water flow details of the each river and subriver.
For this Melbourne water is using many environments for storing and analysis of the data.Now everything needs to replicate in Snowflake.I am from mainly hadoop team.

------------------roles and responsiblities---------------------------------------------
Coming to my roles in this project mainly
 objects creation like tables,views,Mviews,data ingetion, validation,scheduling the jobs

--DDL Creation:
================
First migrated the DDLS.For this we have extracted DDLs and converted using some python utility .
In this python utility we have incoporated datatype Mapping,schema name changes ,database name changes,  tablename changes properties removal 
Normally hive DDLs have specific properties like file formats ,partion clauses we have removed by python utility
added new columns like datalake_entrytime,Location details

--Coming to data migration
================================
first we did history migrtaion--copy
-------------------------------
as part of history migrtaion we have extracted all the data from hdfs locations and made unique file format called parquet file format 
this we copied to AWS S3 storage using AWS CLI copy command.
This AWS we are using as storage integeration for snowflake external stage.
on top of this created the external stage
by using snowflake copy command data injected to the snowflake tables for existing target table data


for delta data migration-- snowpipe
-------------------------------
as of now we are getting the data to hdfs locations directly now we mapped everything to AWS s3 buckets directly instead of hdfs location.
we have created the folders for each base table in S3 data will be coming to respective locations
We have created the snowpipes to inject the data automatically into snowflake(with auto ingest=true) 

Coming script conversion
-------------------------
as of now Melbourne water is using .hql files for processing ,we converted all .hql statements to snowsql statements
in that we have created equivalent udfs for unsupported hive functions
And SCD type1,type2,type3 implementations.
Streams for CDC changes

and we have incoporated additional functionalities like adding location details, implemented functions for additional fields like surrogate key natural key implementations.
Also created new procedures for new requirements.

we have also created the shares ,created secure views, for reporting purpose 

coming script validation
-------------------------
we will take 2 days of snapshots data into base tables in hive and snowflake we will run the hql scripts in source side and converted scripts in snowflake side.

the output data will be injested to the snowflake again from hive
by using "Minus" query we will identify the conversion issues 
if we not got any record which means conversion is succesful
we have some exceptions   which will get taken approval from client like random value issues,day-light issues..

coming to job scheduling
-----------------------------
we are using "Auto-Sys" third party job scheduler for scheduling the jobs .
With the same freaquency and same dependancies jobs mapped for snowflake converted scripts.
once it is tested in QA we will deploy in prod environment

Prior to this project worked for couple of Implementation projects like AT&T (American Telephone and Telegraph) using SNowflake,vertica,Oracle
 Worked as Oracle developer for WWE(Accenture)