# SQL_Project_Music_Store_Analysis
SQL project to analyze online music store data

##  Store Procedure
* A stored procedure is a database object.
* A stored procedure is a sereis of declarative SQL statements.
* A stored procedure can be stored in the database and can be reused over and over again.
* Parameter can be passed to a stored procedure. show that the store procedure can act based on the parameter values.
### Types of store procedure
* user defined stored procedure
* System stored procedure
#### user defined stored procedure are created by database developer or database administractors. these contains one more more sql statement to select, update, delete records from database tables.

#### system stored procedure are created and executed by sql server for the server administrative activities.

### How to create stored procedure
```diff
- DELIMITER //
+ Create Procedure emplist()
+ begin 
+ select * from myemp where dep_id=110;
+ END// 
- DELIMITER ;
```
### How to execute
```diff
+ call emplist();
- DROP PROCEDURE IF EXISTS emplist;
```
### Dynamic procedure
```diff
- DELIMITER //
+ CREATE PROCEDURE emplist(
+ IN DEP_ID INT)
+ BEGIN
+ SET @sql = CONCAT('SELECT * FROM myemp WHERE dep_id = ', DEP_ID);
+ PREPARE stmt FROM @sql;
+ EXECUTE stmt;
+ DEALLOCATE PREPARE stmt;
+ END //
- DELIMITER ;
```
