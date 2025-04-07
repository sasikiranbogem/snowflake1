Architecture:
 
Snowflake architecture has three layers of architectures
Storage Layer,Compute Layer,Cloud services Layer
 
Coming Storage Layer:
==============
1)Its Centralized database  data will be stored in any of the cloud environments like AWS,Azure,GCP which ever is choosen for snowflake account creation.
2)Data will be stored in sorted manner and columner format in the form of Micro Partitions size around 5 to 500MB .And highly encrypted and highly compressed.
3)These micro partitions will be having header information like aggreagated values like min,max ,counts for each column in Metadata storage in cloud serves layer.
4)  Snowflake billing will apply for the storage based on cloud,region
 
Coming to Compute Layer:
================
1)In these We will be consists the Warehouses with different sizes like small,medium,large .We can enable auto scaling enablement if required.
2)These warehouse will take the metadata information of micropartitions from metadata layer,and corrresponding Micro partitions will loads into warehouse    based on Query plan and process the data parallelly.
3) Snowflake billing will apply for the Processing based on Cluster size and execution time

Coming to Cloud services Layer:
=======================
This is maintained by completely snowflake company.
Having services like Metadata,Authentication control,Security management,Query Optimizer,Infrastructure manager
    Metadata : It consists Metadata information of micro partitions header information and Objects definitions like tables,databases,views, like all Objects.
                and result cache .Stores the results for  last 24 hours running queries.
                and  Information schema objects like query_history ,Load_history kind of things.
    Authentication&Access Control: Stores the information like user and authentication details like usernames,password,policies
    Security Management: stores the roles and grants of objects information and  users information
    Query Optimizer: It creates the best execution plan for user input queries.
    Infrastructure Manager: It consists warehouse information .             