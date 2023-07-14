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

-- 1. What is the gender breakdown of employees in the company

SELECT * FROM `human resources`;

SELECT gender, COUNT(*) AS count 
FROM `human resources`
WHERE termdate IS NULL
GROUP BY gender;

-- 2. What is the race breakdown of employees in the company
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
                                                                                                                                                                                                                                              
