CREATE DATABASE Projects;

USE Projects;

SELECT * FROM hr;

-- Cleaning the Data
-- Renaming the ID Column
ALTER TABLE hr 
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT termdate FROM hr;

UPDATE hr 
SET termdate = IF(termdate IS NOT NULL AND termdate !='', date(str_to_date(termdate,'%Y-%m-%d %H:%i:%S UTC')),'0000-00-00')
WHERE TRUE;


SET sql_mode = 'ALLOW_INVALID_DATES';



ALTER TABLE hr
MODIFY COLUMN termdate DATE;


ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR,birthdate, CURDATE());

SELECT birtHdate, age FROM hr;

SELECT 
	MIN(age)AS YOUNGEST,
    MAX(AGE)AS oldest
FROM hr;

SELECT COUNT(*) FROM hr WHERE age < 18;



