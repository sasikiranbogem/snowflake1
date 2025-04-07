CREATE PIPE mypipe_s3
  AUTO_INGEST = TRUE
   INTEGRATION = 'MYINT'
  AWS_SNS_TOPIC = 'arn:aws:sns:us-west-2:001234567890:s3_mybucket'
  AS
  COPY INTO snowpipe_db.public.mytable
  FROM @snowpipe_db.public.mystage
  FILE_FORMAT = (TYPE = 'JSON');
  
  create storage integration azure_int
  type = external_stage
  storage_provider = azure
  enabled = true
  azure_tenant_id = '<tenant_id>'
  storage_allowed_locations = ('azure://myaccount.blob.core.windows.net/mycontainer/path1/', 'azure://myaccount.blob.core.windows.net/mycontainer/path2/')
storage_blocked_locations = ('azure://myaccount.blob.core.windows.net/mycontainer/path2/');

CREATE STORAGE INTEGRATION <integration_name>
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = '<iam_role>'
  STORAGE_ALLOWED_LOCATIONS = ('<protocol>://<bucket>/<path>/', '<protocol>://<bucket>/<path>/')
  [ STORAGE_BLOCKED_LOCATIONS = ('<protocol>://<bucket>/<path>/', '<protocol>://<bucket>/<path>/') ]
  
  CREATE OR REPLACE FILE format my_csv_format
TYPE = CSV
FIELD_DELIMITER = '|'
SKIP_HEADER = 1
NULL_IF = ('NULL', 'null')
EMPTY_FIELD_AS_NULL = TRUE
COMPRESSION = gzip;

CREATE STAGE azure_blob_int
STORAGE_INTEGRATION = <Integration name>
URL = <BLOB Storage URL>
FILE_FORMAT = <File format name>;