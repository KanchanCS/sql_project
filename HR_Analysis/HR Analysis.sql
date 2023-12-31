create database HR_Analysis;
use  HR_Analysis;
select * from `human resources`;

-- data cleaning and reproccesing

-- change the column name(ï»¿id)
alter table `human resources` 
change column ï»¿id emp_id varchar(20) null;

-- show all column name
describe `human resources`;

set sql_safe_updates = 0;

UPDATE `human resources`
SET birthdate = CASE
		WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
        WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
        ELSE NULL
		END;

--  -- change the datatype of birthdate coloum
 alter table `human resources`  
 modify column birthdate date;
 
 -- change the date format and datatype of hire_date coloum
 UPDATE `human resources`
 SET hire_date = CASE
		WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
        WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
        ELSE NULL
		END;
        
alter table `human resources`  
 modify column hire_date date;
 
 
  -- change the date format and datatype of termdate coloum
 UPDATE `human resources`
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !=''; 
 
  UPDATE `human resources`
SET termdate = NULL
WHERE termdate = '';

-- create age column
ALTER TABLE `human resources`
ADD column age INT;


UPDATE `human resources`
SET age = timestampdiff(YEAR,birthdate,curdate());

SELECT min(age), max(age) FROM `human resources`;
select * from `human resources`;

# 1 Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name" 
select first_name as "First Name" , last_name as "Last Name" from  `human resources`;

# 2 Write a query to get unique emp_id from employee table 
select distinct emp_id from `human resources`;

# 3 Write a query to get all employee details from the employee table order by first name, descending 
select first_name from `human resources` order by first_name desc ;

# 4 Write a query to get the number of employees working with the company 
select count(*) from `human resources`;

# 5 Write a query to get the number of jobs available in the employees table 
select count(distinct emp_id) from `human resources`;

# 6 Write a query get all first name from employees table in upper case
select upper(first_name) from `human resources`;

# 7 Write a query to get the first 3 characters of first name from employees table 
select left(first_name,3) from `human resources`;
select substring(first_name,1,3) from `human resources`;
select mid(first_name,1,3) from `human resources`;

# 8 Write a query to get first name from employees table after removing white spaces from both side 
select trim(first_name) from `human resources`;

# 9 Write a query to get the length of the employee names (first_name, last_name) from employees table 
select first_name, last_name, length(first_name)+length(last_name) from `human resources`;

# 10 Write a query to check if the first_name fields of the employees table contains numbers 
select first_name from `human resources` where first_name regexp '[0-7]';

-- 11. What is the gender breakdown of employees in the company

SELECT * FROM `human resources`;

SELECT gender, COUNT(*) AS count 
FROM `human resources`
WHERE termdate IS NULL
GROUP BY gender;

-- 12. What is the race breakdown of employees in the company

SELECT race , COUNT(*) AS count
FROm `human resources`
WHERE termdate IS NULL
GROUP BY race;

-- 3. What is the age distribution of employees in the company 
SELECT 
	CASE
		WHEN age>=18 AND age<=24 THEN '18-24'
        WHEN age>=25 AND age<=34 THEN '25-34'
        WHEN age>=35 AND age<=44 THEN '35-44'
        WHEN age>=45 AND age<=54 THEN '45-54'
        WHEN age>=55 AND age<=64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    COUNT(*) AS count
    FROM `human resources`
    WHERE termdate IS NULL
    GROUP BY age_group
    ORDER BY age_group;
  
 -- 4. How many employees work at HQ vs remote
 
SELECT location,COUNT(*) AS count
FROm `human resources`
WHERE termdate IS NULL
GROUP BY location; 

-- 5. What is the average length of employement who have been teminated.

SELECT ROUND(AVG(year(termdate) - year(hire_date)),0) AS length_of_emp
FROM `human resources`
WHERE termdate IS NOT NULL AND termdate <= curdate();

-- 6. How does the gender distribution vary acorss dept. and job titles
SELECT *  FROM `human resources`;

SELECT department,jobtitle,gender,COUNT(*) AS count
FROM `human resources`
WHERE termdate IS NOT NULL
GROUP BY department, jobtitle,gender
ORDER BY department, jobtitle,gender;

SELECT department,gender,COUNT(*) AS count
FROM `human resources`
WHERE termdate IS NOT NULL
GROUP BY department,gender
ORDER BY department,gender;

-- 7. What is the distribution of jobtitles acorss the company

SELECT jobtitle, COUNT(*) AS count
FROm `human resources`
WHERE termdate IS NULL
GROUP BY jobtitle;

-- 8. Which dept has the higher turnover/termination rate

SELECT * FROM hr

SELECT department,
		COUNT(*) AS total_count,
        COUNT(CASE
				WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 
				END) AS terminated_count,
		ROUND((COUNT(CASE
					WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 
                    END)/COUNT(*))*100,2) AS termination_rate
		FROM hr
        GROUP BY department
        ORDER BY termination_rate DESC
        
        
-- 9. What is the distribution of employees across location_state
SELECT location_state, COUNT(*) AS count
FROm `human resources`
WHERE termdate IS NULL
GROUP BY location_state;

SELECT location_city, COUNT(*) AS count
FROm `human resources`
WHERE termdate IS NULL
GROUP BY location_city;

-- 10. How has the companys employee count changed over time based on hire and termination date.
SELECT * FROM `human resources`;

SELECT year,
		hires,
        terminations,
        hires-terminations AS net_change,
        (terminations/hires)*100 AS change_percent
	FROM(
			SELECT YEAR(hire_date) AS year,
            COUNT(*) AS hires,
            SUM(CASE 
					WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 
				END) AS terminations
			FROM `human resources`
            GROUP BY YEAR(hire_date)) AS subquery
GROUP BY year
ORDER BY year;

-- 11. What is the tenure distribution for each dept.
SELECT department, round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM `human resources`
WHERE termdate IS NOT NULL AND termdate<= curdate()
GROUP BY department
