## Top 10 SQL function used in data analyst
1. **AVG():** Calculate the average value of a column.
  ```diff
+ SELECT AVG(column_name) FROM table_name;
```
2. **SUM():** Get the sum of values in a column.
```diff
- SELECT SUM(column_name) FROM table_name;
```
3. **COUNT():** Count the number of rows or non-null values in a column.
```diff
+ SELECT COUNT(column_name) FROM table_name;
```
4. **MAX():** Finf the maximum value in a column.
```diff
- SELECT MAX(column_name) FROM table_name;
```
5. **MIN():** Discover the minimum value in a column.
```diff
+ SELECT MIN(column_name) FROM table_name;
```
6. **GROUP BY:** Group rows based on a specified column.
```diff
- SELECT column_name, aggregate_function(column_name) FROM table_name GROUP BY column_name;
```
7. **HAVING:** Filter grouped rows based on condition.
```diff
+ SELECT column_name, aggregate_function(column_name) FROM table_name GROUP BY column_name HAVING condition;
``` 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
