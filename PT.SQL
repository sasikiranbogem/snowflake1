Performance tuning Activities:
Will check in job monitering toll in control-M
 How many jobs are running parallelly
 How much data is utilizing the for the query execution
 ANy depandancy jobs failing or running
 ANy data depandancy  issus EXISTS
 Memory utilizations
 Once these checks everything is done will go for Query_history tables and identify the long running queries 
 For this will analyse with Query profiler.In this we can check 
    How many micro partitions are scanning
	how much data is utlizing 
	IO operations,
	Query plan will get with tree structure manner.In that which join is taking TIME
	need to check any spill Over issue means out of memory is going or NOT
	Based on these we need to check the query
Mainly need to do basic optimizations like in operator to exist operator,Master -chaild usage
1) breaking the copmplex queries into multiple temp tables based on query profiler analysis.
   these temp tables are using in subsequent queries.Finally try to complete the complex query with out any output changes
This will reduce spill over problems
2) By analysing the Query profiler information implement the Cluster-key at DDL table for very large and freaquently used tables
   this will  sort the data based on cluster-key column.SO that for join wont scan all micropartitions only scan specific micropartitions where the data is there.
   these cluster key is kind of partition key like periodical(timestamp) columns
3) Created the Materialized views where ever table with aggregated values are there.Specially for reports purpose .
   These Mviews refresh automatically if source tables gets DML operations
4)Query Accelarator will use to get the best query
5)if still not working  then go for auto scaling option



















Involved in performance activities as well whenever gets the performance issues
Mainly like
1)usage of DBMS_profiler like Start Profiling:,Execute the PL/SQL Block:Stop Profiling:
    we will Analyze Profiling Data:
		After stopping the profiler, query the profiling tables to analyze the performance data:

		SELECT * FROM DBMS_PROFILER.PROFILER_RUNS;
		SELECT * FROM DBMS_PROFILER.PROFILER_LINES;
		SELECT * FROM DBMS_PROFILER.PROFILER_DATA;
		SELECT * FROM DBMS_PROFILER.PROFILER_ERRORS;
 With this we need to identify the long running queries 
 For these we need to check 
  1)Explain plan for query
  2)We need to analyse the plan_table
  3) In that we need to check COst and and cardinality and IO operations need to CHECK
  4) need to identify the whether going for index_scan or full table scans ,or partition scan kind of things 
     If not considering then need to check Statastics of the source tables,
	  Need to use the index in filter classes
	  query plan changes if possible like 'in' operator to 'Exist' operator ,
	       Usage of 'With' clause means 'CTE'(common table expression)
  5)if indexes are not existed we will be create the indexes
  6) need to check unnecessary internal iterations kind of things
  7) Temp space utilization