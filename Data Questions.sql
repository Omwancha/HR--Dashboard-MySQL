-- Questions 
SELECT termdate FROM hr;
-- What is the gender breakdown of employees in the company?

SELECT gender, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate NOT BETWEEN '1000-01-01' AND '9999-12-31'
GROUP BY gender;

-- What is the race or ethnicity breakdown of employees in the company?

SELECT race, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate NOT BETWEEN '1000-01-01' AND '9999-12-31'
GROUP BY race
ORDER BY count DESC;


-- Age distribution

SELECT min(age) AS youngest,  
		max(age) AS oldesT 
FROM hr
WHERE age >= 18 AND termdate NOT BETWEEN '1000-01-01' AND '9999-12-31' ;


SELECT 
	CASE
		WHEN age >= 18 AND age <=24 THEN '18-24'
        WHEN age >= 25 AND age <=34 THEN '25-34'
        WHEN age >= 35 AND age <=44 THEN '35-44'
        WHEN age >= 45 AND age <=54 THEN '45-54'
        WHEN age >= 55 AND age <=64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate NOT BETWEEN '1000-01-01' AND '9999-12-31' 
GROUP BY age_group
ORDER BY age_group;


-- Gender distribution among age groups

SELECT 
	CASE
		WHEN age >= 18 AND age <=24 THEN '18-24'
        WHEN age >= 25 AND age <=34 THEN '25-34'
        WHEN age >= 35 AND age <=44 THEN '35-44'
        WHEN age >= 45 AND age <=54 THEN '45-54'
        WHEN age >= 55 AND age <=64 THEN '55-64'
        ELSE '65+'
	END AS age_group, gender,
COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate NOT BETWEEN '1000-01-01' AND '9999-12-31' 
GROUP BY age_group, gender
ORDER BY age_group, gender;


-- How many employes work at headquarters vs remote loctions?
 SELECT location, COUNT(*) AS count
 FROM hr
 WHERE age >=18 AND termdate NOT BETWEEN '1000-01-01' AND '9999-12-31'
 GROUP BY location;
 
 
 -- What is the average length of employment for employees who have been terminated?
 
 SELECT 
	round(AVG(datediff(termdate,hire_date))/365,0) AS avg_length_employment
FROM hr
WHERE 
	termdate <=curdate() 
	AND termdate  BETWEEN '1000-01-01' AND '9999-12-31'
	AND age >=18;
    

-- Gender distribution across job titles?

SELECT department, gender, Count(*) as count 
FROM hr
WHERE age >=18 AND termdate NOT BETWEEN '1000-01-01' AND '9999-12-31'
GROUP BY department, gender
ORDER BY department;


-- What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) AS Count
FROM hr
WHERE age >=18 AND termdate NOT BETWEEN '1000-01-01' AND '9999-12-31'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- Which department has the highest turnover rate
SELECT 
department, 
total_count,
terminated_count,
terminated_count/total_count As termination_rate
FROM(
SELECT  department,
count(*)As total_count,
SUM(CASE WHEN termdate BETWEEN '1000-01-01' AND '9999-12-31' AND termdate <=curdate() THEN 1 ELSE 0 END) AS terminated_count
FROM hr
WHERE age>=18
GROUP BY  department
)AS  subquery
ORDER BY termination_rate DESC;

-- Distribution of employees across locations by city and state?
SELECT location_state, COUNT(*)AS count
FROM hr
WHERE age >=18 AND termdate NOT BETWEEN '1000-01-01' AND '9999-12-31'
GROUP BY location_state
ORDER BY count DESC;

-- How has employee count changed over time based on hire and term dates?
SELECT 
	year,
    hires,
    terminations,
    hires-terminations AS net_change,
   round( (hires-terminations)/hires*100,2) AS net_change_percent
FROM(
	SELECT YEAR(hire_date) AS year,
    count(*) AS hires,
    SUM(CASE WHEN termdate BETWEEN '1000-01-01' AND '9999-12-31' AND termdate <=curdate() THEN 1 ELSE 0 END) AS terminations
    FROM hr 
    WHERE age >= 18
    GROUP BY YEAR(hire_date)) 
    AS subquery
    ORDER BY year ASC;

    
-- What tenure distribution for each department?

SELECT department, round(AVG(datediff(termdate,hire_date)/365),0) AS avg_tenure_department
FROM hr
WHERE termdate BETWEEN '1000-01-01' AND '9999-12-31' AND age >=18
GROUP BY department;






    

