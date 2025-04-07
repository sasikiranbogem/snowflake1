Procedure Psudo Code
---------------------------
var my_sql_command1 = "Select max(history_date) from history_table"
var statement1 = snowflake.createStatement(my_sql_command1).execute;
var result_set = statement1.execute();
var my_sql_command1 = "delete from history_table where event_year < result_set.getColumnValue(1)";
var statement1 = snowflake.createStatement(my_sql_command1);
statement1.execute();
var my_sql_command2 = "delete from log_table where event_year < 2016";
var statement2 = snowflake.createStatement(my_sql_command2);
statement2.execute();

var rs = snowflake.execute( {sqlText: "SELECT 2 * " + PARAMETER_1} );

var result = snowflake.execute({sqlText: "Select count(1) from emp"})

var rs = snowflake.createStatement( {sqlText:"select * from table1" } ).execute();

snowflake.createStatement( { sqlText: `create temp table identifier ($log_table) if not exists (ts number, msg string)`} ).execute();

snowflake.createStatement( { sqlText: `insert into identifier ($log_table) values (:1, :2)`, binds:[Date.now(), MSG] } ).execute();


Exmaple Execute Query and Loop Through it
----------------------------------------- 
create or replace procedure read_result_set()
  returns float not null
  language javascript
  as     
  $$  
    var my_sql_command = "select * from emp";
    var statement1 = snowflake.createStatement( {sqlText: my_sql_command} );
    var result_set1 = statement1.execute();
	var result_set1 = snowflake.createStatement( {sqlText:"select * from table1" } ).execute();
	
    // Loop through the results, processing one row at a time... 
    while (result_set1.next())  {
       var column1 = result_set1.getColumnValue(1);
	   var insrt_stmt = snowflake.createStatement("insert into log_table values ('"+column1+"')").execute();
	   
       var column2 = result_set1.getColumnValue(2);
       // Do something with the retrieved values...
       }
  return 0.0; // Replace with something more useful.
  $$
  ;


Create or replace procedure get_empl_count()
returns float
language javascript as
$$
var sqlstmt = "Select * from emp";
var stmt = snowflake.createStatement({sqlText : sqlstmt})
var resultset = stmt.execute()
var empCount = 0
while (resultset.next()){
 empCount = empCount+1
 var empno = resultset.getColumnValue(1)
}
return empCount;
$$;


-- Above Example Corrected and working
First Step: Please execute the below do_log procedure for inserting the log
CREATE or replace PROCEDURE do_log(msg STRING)
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    EXECUTE AS CALLER
    AS $$
       try {
           snowflake.createStatement({ sqlText: 'create table  err_log if not exists (ts number, msg string)'}).execute();
           snowflake.createStatement({ sqlText: `insert into err_log values (:1, :2)`, binds:[Date.now(), MSG] } ).execute();
       } catch (ERROR){
           throw ERROR;
       }
 $$
;


Second Step :
create or replace procedure read_result_set(p_deptno float)
  returns float not null
  language javascript
  as     
  $$  
  
      function log(msg){
        snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
        }
  
    var my_sql_command = "select * from emp where deptno="+p_deptno
    var statement1 = snowflake.createStatement( {sqlText: my_sql_command} );
    var result_set1 = statement1.execute();
    log('SQL Text :'+statement1.getSqlText())
	var result_set1 = snowflake.createStatement( {sqlText:"select * from emp limit 10" } ).execute();
    log('Query ID :'+statement1.getQueryId())
	
    // Loop through the results, processing one row at a time... 
    while (result_set1.next())  {
       var column1 = result_set1.getColumnValue(1);
       var column2 = result_set1.getColumnValue(2);
       log('Column Value1 :'+column1)
       log('Column Value2 :'+column2)
       // Do something with the retrieved values...
       }
  return 0.0; // Replace with something more useful.
  $$
  ;

call read_result_set();

select * from err_log;

truncate table err_log;

***************************************************************************************************

Variable Example
---------------
SET Variable_1 = 49;
CREATE PROCEDURE sv_proc2(PARAMETER_1 FLOAT)
    RETURNS VARCHAR
    LANGUAGE JAVASCRIPT
    AS
    $$
        var rs = snowflake.execute( {sqlText: "SELECT 2 * " + PARAMETER_1} );
        rs.next();
        var MyString = rs.getColumnValue(1);
        return MyString;
    $$
    ;
  CALL sv_proc2($Variable_1);
  
Create or replace Procedure setVariables()  --------------You cannot set Session Variables inside Proc 
    RETURNS VARCHAR
    LANGUAGE JAVASCRIPT
    AS
    $$
        var rs = snowflake.execute( {sqlText: "SET SESSION_VAR_ZYXW = 50"} );

        var rs = snowflake.execute( {sqlText: "SELECT 2 * $SESSION_VAR_ZYXW"} );
        rs.next();
        var MyString = rs.getColumnValue(1);

        rs = snowflake.execute( {sqlText: "UNSET SESSION_VAR_ZYXW"} );

        return MyString;
    $$
    ;

CALL sv_proc1();
-- This fails because SESSION_VAR_ZYXW is no longer defined.
SELECT $SESSION_VAR_ZYXW;

Binds Example
-----------------------------
  
CREATE OR REPLACE PROCEDURE right_bind(TIMESTAMP_VALUE VARCHAR)
RETURNS BOOLEAN
LANGUAGE JAVASCRIPT
AS
$$
var cmd = "SELECT CURRENT_DATE() > TO_TIMESTAMP(:1, 'YYYY-MM-DD HH24:MI:SS')";
var stmt = snowflake.createStatement(
          {
          sqlText: "SELECT CURRENT_DATE() > TO_TIMESTAMP(:1, 'YYYY-MM-DD HH24:MI:SS')",
          binds: [TIMESTAMP_VALUE]
          }
          );
var result1 = stmt.execute();
result1.next();
return result1.getColumnValue(1);
$$
;

CALL right_bind('2019-09-16 01:02:03');  


CREATE TABLE table1 (v VARCHAR, 
                     ts1 TIMESTAMP_LTZ(9), 
                     int1 INTEGER,
                     float1 FLOAT,
                     numeric1 NUMERIC(10,9),
                     ts_ntz1 TIMESTAMP_NTZ,
                     date1 DATE,
                     time1 TIME
                     );

CREATE OR REPLACE PROCEDURE string_to_timestamp_ltz(TSV VARCHAR) 
RETURNS TIMESTAMP_LTZ 
LANGUAGE JAVASCRIPT 
AS 
$$ 
    // Convert the input varchar to a TIMESTAMP_LTZ.
    var sql_command = "SELECT '" + TSV + "'::TIMESTAMP_LTZ;"; 
    var stmt = snowflake.createStatement( {sqlText: sql_command} ); 
    var resultSet = stmt.execute(); 
    resultSet.next(); 
    // Retrieve the TIMESTAMP_LTZ and store it in an SfDate variable.
    var my_sfDate = resultSet.getColumnValue(1); 

    f = 3.1415926;

    // Specify that we'd like position-based binding.
    sql_command = `INSERT INTO table1 VALUES(:1, :2, :3, :4, :5, :6, :7, :8);` 
    // Bind a VARCHAR, a TIMESTAMP_LTZ, a numeric to our INSERT statement.
    result = snowflake.execute(
        { 
        sqlText: sql_command, 
        binds: [TSV, my_sfDate, f, f, f, my_sfDate, my_sfDate, '12:30:00.123' ] 
        }
        ); 

    return my_sfDate; 
$$ ; 

Call the procedure.

CALL string_to_timestamp_ltz('2008-11-18 16:00:00');


DYNAMIC SQL
---------------
create or replace procedure get_row_count(table_name VARCHAR)
  returns float not null
  language javascript
  as
  $$
  var row_count = 0;
  // Dynamically compose the SQL statement to execute.
  var sql_command = "select count(*) from " + TABLE_NAME;
  // Run the statement.
  var stmt = snowflake.createStatement(
         {
         sqlText: sql_command
         }
      );
  var res = stmt.execute();
  // Get back the row count. Specifically, ...
  // ... get the first (and in this case only) row from the result set ...
  res.next();
  // ... and then get the returned value, which in this case is the number of
  // rows in the table.
  row_count = res.getColumnValue(1);
  return row_count;
  $$
  ;
  
call get_row_count('EMP');


Recursive Stored Procedure
--------------------------
create or replace procedure recursive_stproc(counter FLOAT)  first time --3, second time 2
    returns varchar not null
    language javascript
    as
    -- "$$" is the delimiter that shows the beginning and end of the stored proc.
    $$
    var counter1 = COUNTER;
    var returned_value = "";
    var accumulator = "";
    var stmt = snowflake.createStatement(
        {
        sqlText: "INSERT INTO stproc_test_table2 (col1) VALUES (?);",
        binds:[counter1]
        }
        );
    var res = stmt.execute();
    if (COUNTER > 0)  
        {
        stmt = snowflake.createStatement(
            {
            sqlText: "call recursive_stproc (?);",
            binds:[counter1 - 1]  
            }
            );
        res = stmt.execute();
        res.next();
        returned_value = res.getColumnValue(1);
        }
    accumulator = accumulator + counter1 + ":" + returned_value;
    return accumulator;
    $$
    ;
	
call recursive_stproc(4.0::float);  


Try Catch Example
----------------------

create procedure broken()
      returns varchar not null
      language javascript
      as
      $$
      var result = "";
      try {
          snowflake.execute( {sqlText: "Invalid Command!;"} );
          result = "Succeeded";
          }
      catch (err)  {
          result =  "Failed: Code: " + err.code + "\n  State: " + err.state;
          result += "\n  Message: " + err.message;
          result += "\nStack Trace:\n" + err.stackTraceTxt; 
          }
      return result;
      $$
      ;
call broken();


Custom Exception
---------------------
CREATE OR REPLACE PROCEDURE validate_age (age float)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS $$
    try {
        if (AGE < 0) {
            throw "Age cannot be negative!";
        } else {
            return "Age validated.";
        }
    } catch (err) {
        return "Error: " + err;
    }
$$;

CALL validate_age(50);


Logging an Error
-------------------

CREATE OR REPLACE TABLE error_log (error_code number, error_state string, error_message string, stack_trace string);

CREATE OR REPLACE PROCEDURE broken() 
RETURNS varchar 
NOT NULL 
LANGUAGE javascript 
AS $$
var result;
try {
    snowflake.execute({ sqlText: "Invalid Command!;" });
    result = "Succeeded";
} catch (err) {
    result = "Failed";
    snowflake.execute({
      sqlText: `insert into error_log VALUES (?,?,?,?)`
      ,binds: [err.code, err.state, err.message, err.stackTraceTxt]
      });
}
return result;
$$;

Call broken();

Example -- 2
---------------------

CREATE or replace PROCEDURE do_log(MSG STRING)
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    EXECUTE AS CALLER
    AS $$
 
    // See if we should log - checks for session variable do_log = true.
    try {
       var stmt = snowflake.createStatement( { sqlText: `select $do_log` } ).execute();
    } catch (ERROR){
       return; //swallow the error, variable not set so don't log
    }
    stmt.next();
    if (stmt.getColumnValue(1)==true){ //if the value is anything other than true, don't log
       try {
           snowflake.createStatement( { sqlText: `create temp table identifier ($log_table) if not exists (ts number, msg string)`} ).execute();
           snowflake.createStatement( { sqlText: `insert into identifier ($log_table) values (:1, :2)`, binds:[Date.now(), MSG] } ).execute();
       } catch (ERROR){
           throw ERROR;
       }
    }
 $$
;

CREATE or replace PROCEDURE my_test()
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    EXECUTE AS CALLER
    AS $$

    // Define the SP call as a function - it's cleaner this way.
    // Add this function to your stored procs
    function log(msg){
        snowflake.createStatement( { sqlText: `call do_log(:1)`, binds:[msg] } ).execute();
        }

    // Now just call the log function anytime...
    try {
        var x = 10/10;
        log('log this message'); //call the log function
        //do some stuff here
        log('x = ' + x.toString()); //log the value of x 
        log('this is another log message'); //throw in another log message
    } catch(ERROR) {
        log(ERROR); //we can even catch/log the error messages
        return ERROR;
    }

    $$
;

set do_log = true; --true to enable logging, false (or undefined) to disable
set log_table = 'my_log_table';  -- The name of the temp table where log messages go.

CALL my_test();

select msg  from my_log_table order by 1;


Procedure Return Result in multiple rows
----------------------------------------

  CREATE TABLE western_provinces(ID INT, province VARCHAR);
  
  insert into western_provinces values 
  (1, 'Alberta' ),
  (2, 'British Columbia'),
  (3, 'Manitoba');


CREATE OR REPLACE PROCEDURE read_western_provinces()
  RETURNS VARCHAR NOT NULL
  LANGUAGE JAVASCRIPT
  AS
  $$
  var return_value = "";
  try {
      var command = "SELECT * FROM western_provinces ORDER BY province;"
      var stmt = snowflake.createStatement( {sqlText: command } );
      var rs = stmt.execute();
      if (rs.next())  {
          return_value += rs.getColumnValue(1);
          return_value += ", " + rs.getColumnValue(2);
          }
      while (rs.next())  {
          return_value += "\n";
          return_value += rs.getColumnValue(1);
          return_value += ", " + rs.getColumnValue(2);
          }
      }
  catch (err)  {
      result =  "Failed: Code: " + err.code + "\n  State: " + err.state;
      result += "\n  Message: " + err.message;
      result += "\nStack Trace:\n" + err.stackTraceTxt;
      }
  return return_value;
  $$
  ;
  
  CALL read_western_provinces();
  
  SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
  
  CREATE TRANSIENT TABLE one_string(string_col VARCHAR);

INSERT INTO one_string
    SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	
SELECT * FROM one_string, LATERAL SPLIT_TO_TABLE(one_string.string_col, '\n');

SELECT VALUE FROM one_string, LATERAL SPLIT_TO_TABLE(one_string.string_col, '\n');

List_Agg();

Returning Array Of Messages
----------------------------

CREATE OR REPLACE PROCEDURE sp_return_array()
      RETURNS VARIANT NOT NULL
      LANGUAGE JAVASCRIPT
      AS
      $$
      // This array will contain one error message (or an empty string) 
      // for each SQL command that we executed.
      var array_of_rows = [];

      // Artificially fake the error messages.
      array_of_rows.push("ERROR: The foo was barred.")
      array_of_rows.push("WARNING: A Carrington Event is predicted.")

      return array_of_rows;
      $$
      ;

CALL sp_return_array();

SELECT INDEX, VALUE 
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())) AS res, LATERAL FLATTEN(INPUT => res.$1)
    ORDER BY index
    ;

  
  CALL read_western_provinces();