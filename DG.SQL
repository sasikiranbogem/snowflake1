Data Governance in Snowflake:
Maintain the data governance in  account , users, ,all the data and access in Snowflake.
----------------------------------------------------------------------------------------

Data Quality Monitoring and data metric functions
------------------------------------------------------------------
Allows the monitoring of the state and integrity of your data using system data metric functions and user-defined data metric functions.

Column-level Security
----------------------
Allows the application of a masking policy to a column within a table or view.

Row-level Security
----------------------
Allows the application of a row access policy to a table or view to determine which rows are visible in the query result.

Object Tagging
----------------------
Allows the tracking of sensitive data for compliance, discovery, protection, and resource usage.

Tag-based masking policies
Allows protecting column data by assigning a masking policy to a tag and then setting the tag on a database object or the Snowflake account.

Data Classification
Allows categorizing potentially personal and/or sensitive data to support compliance and privacy regulations.

Access History
----------------------
Allows the auditing of the user access history through the Account Usage ACCESS_HISTORY view.

Object Dependencies
----------------------
Allows the auditing of how one object references another object by its metadata (e.g. creating a view depends on a table name and column names) through the Account Usage OBJECT_DEPENDENCIES view.

Data Governance area in Snowsight
Allows using the Monitoring » Governance area to monitor and report on the usage of policies and tags with tables, views, and columns using two different interfaces: Dashboard and Tagged Objects. For details, see:

Create and assign tags

Monitor tags with Snowsight

