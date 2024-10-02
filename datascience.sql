--Viewing the Data
SELECT *
FROM data_science_jobs;

--Check for Nulls - No null
SELECT *
FROM data_science_jobs
WHERE work_year IS NULL OR employment IS NULL OR experience IS NULL OR job_title IS NULL OR salary IS NULL
	  OR salary_currency IS NULL OR salary_in_usd IS NULL OR employee_residence IS NULL OR remote_ratio IS NULL
	  OR company_location IS NULL OR company_size IS NULL;

--USIND CASE STATEMENT TO FILL SHORT FORMS(ABBREVIATIONS)
--For Experience column
UPDATE data_science_jobs
SET experience =
		CASE WHEN experience = 'EX' THEN 'Executive'
			 WHEN experience = 'SE' THEN 'Senior'
			 WHEN experience = 'MI' THEN 'Mid-level'
			 WHEN experience = 'EN' THEN 'Entry-Level'
			 ELSE experience END;
	   
--For Employment column
UPDATE data_science_jobs
SET employment =
		CASE WHEN employment = 'FT' THEN 'Full-time'
			 WHEN employment = 'CT' THEN 'Contract'
			 WHEN employment = 'FL' THEN 'Freelance'
			 WHEN employment = 'PT' THEN 'Part-Time'
			 ELSE employment END;

--For Company Size column
UPDATE data_science_jobs
SET company_size =
		CASE WHEN company_size = 'L' THEN 'Large'
			 WHEN company_size = 'M' THEN 'Medium'
			 WHEN company_size = 'S' THEN 'Small'
			 ELSE company_size END;

--For Remote Ratio column
UPDATE data_science_jobs
SET remote_ratio =
		CASE WHEN remote_ratio = '0' THEN 'On-site'
			 WHEN remote_ratio = '50' THEN 'Hybrid'
			 WHEN remote_ratio = '100' THEN 'Remote'
			 ELSE remote_ratio END;

--For Company Location column
UPDATE data_science_jobs
SET company_location  =
			CASE WHEN 		company_location   =  'AE' THEN 'United Arab Emirates' 
		 		 WHEN   	company_location   =  'AL' THEN 'Albania' 
		 		 WHEN       company_location   =  'AM' THEN 'Armenia'
		 		 WHEN		company_location   =  'AR' THEN 'Argentina' 
		 		 WHEN		company_location   =  'AS' THEN 'American Samoa'
		 		 WHEN		company_location   =  'AT' THEN 'Austria'
		 		 WHEN		company_location   =  'AU' THEN 'Australia' 
		 		 WHEN		company_location   =  'BA' THEN 'Bosnia and Herzegovina' 
		 		 WHEN		company_location   =  'BE' THEN 'Belgium'
		 		 WHEN		company_location   =  'BO' THEN 'Bolivia' 
		 		 WHEN		company_location   =  'BR' THEN 'Brazil' 
		 		 WHEN		company_location   =  'BS' THEN 'Bahamas' 
		 		 WHEN		company_location   =  'CA' THEN 'Canada'
		 		 WHEN		company_location   =  'CF' THEN 'Central African Republic'
		 		 WHEN		company_location   =  'CH' THEN 'Switzerland'
		 		 WHEN		company_location   =  'CL' THEN 'Chile' 
		 		 WHEN		company_location   =  'CN' THEN 'China'
		 		 WHEN		company_location   =  'CO' THEN 'Colombia' 
		 		 WHEN		company_location   =  'CR' THEN 'Costa Rica'
		 		 WHEN		company_location   =  'CZ' THEN 'Czech Republic'
		 		 WHEN		company_location   =  'DE' THEN 'Germany' 
		 		 WHEN		company_location   =  'DK' THEN 'Denmark'
		 		 WHEN		company_location   =  'DZ' THEN 'Algeria' 
		 		 WHEN		company_location   =  'EE' THEN 'Estonia' 
		 		 WHEN		company_location   =  'EG' THEN 'Egypt'
		 		 WHEN		company_location   =  'ES' THEN 'Spain'
		 		 WHEN		company_location   =  'FI' THEN 'Finland' 
		 		 WHEN		company_location   =  'FR' THEN 'France'
		 		 WHEN		company_location   =  'GB' THEN 'United Kingdom'
		 		 WHEN	 	company_location   =  'GH' THEN 'Ghana'
		 		 WHEN		company_location   =  'GR' THEN 'Greece'
		 		 WHEN		company_location   =  'HK' THEN 'Hong Kong'
				 WHEN		company_location   =  'HN' THEN 'Honduras'
				 WHEN		company_location   =  'HR' THEN 'Croatia'
				 WHEN		company_location   =  'HU' THEN 'Hungary' 
				 WHEN 		company_location   =  'ID' THEN 'Indonesia'
		 		 WHEN		company_location   =  'IE' THEN 'Ireland' 
		 		 WHEN		company_location   =  'IL' THEN 'Israel'
				 WHEN		company_location   =  'IN' THEN 'India'
				 WHEN		company_location   =  'IQ' THEN 'Iraq'
				 WHEN		company_location   =  'IR' THEN 'Iran'
				 WHEN		company_location   =  'IT' THEN 'Italy'
				 WHEN		company_location   =  'JP' THEN 'Japan'
				 WHEN		company_location   =  'KE' THEN 'Kenya'
				 WHEN		company_location   =  'LT' THEN 'Lithuania'
				 WHEN		company_location   =  'LU' THEN 'Luxembourg'
				 WHEN		company_location   =  'LV' THEN 'Latvia'
				 WHEN		company_location   =  'MA' THEN 'Morocco'
				 WHEN		company_location   =  'MD' THEN 'Moldova'
				 WHEN		company_location   =  'MK' THEN 'North Macedonia'
				 WHEN		company_location   =  'MT' THEN 'Malta'
				 WHEN		company_location   =  'MX' THEN 'Mexico'
				 WHEN		company_location   =  'MY' THEN 'Malaysia'
				 WHEN		company_location   =  'NG' THEN 'Nigeria' 
				 WHEN		company_location   =  'NL' THEN 'Netherlands'
				 WHEN		company_location   =  'NZ' THEN 'New Zealand'
				 WHEN		company_location   =  'PH' THEN 'Philippines' 
				 WHEN		company_location   =  'PK' THEN 'Pakistan'
				 WHEN		company_location   =  'PL' THEN 'Poland'
				 WHEN		company_location   =  'PR' THEN 'Puerto Rico'
				 WHEN		company_location   =  'PT' THEN 'Portugal'
				 WHEN		company_location   =  'RO' THEN 'Romania'
				 WHEN		company_location   =  'RU' THEN 'Russia'
				 WHEN		company_location   =  'SE' THEN 'Sweden'
				 WHEN		company_location   =  'SG' THEN 'Singapore'
				 WHEN		company_location   =  'SI' THEN 'Slovenia' 
				 WHEN		company_location   =  'SK' THEN 'Slovakia'
				 WHEN		company_location   =  'TH' THEN 'Thailand'
				 WHEN		company_location   =  'TR' THEN 'Turkey'
				 WHEN		company_location   =  'UA' THEN 'Ukraine'
				 WHEN		company_location   =  'US' THEN 'United States'
				 WHEN		company_location   =  'VN' THEN 'Vietnam'
				 ELSE 		company_location END;

--For Enployee Residence column
UPDATE data_science_jobs
SET employee_residence  =
	CASE WHEN 	employee_residence   =  'AE' THEN 'United Arab Emirates' 
		 WHEN 	employee_residence   =  'AM' THEN 'Armenia'
		 WHEN 	employee_residence   =  'AR' THEN 'Argentina' 
		 WHEN 	employee_residence   =  'AS' THEN 'American Samoa'
		 WHEN 	employee_residence   =  'AT' THEN 'Austria'
		 WHEN 	employee_residence   =  'AU' THEN 'Australia' 
		 WHEN 	employee_residence   =  'BA' THEN 'Bosnia and Herzegovina' 
		 WHEN 	employee_residence   =  'BE' THEN 'Belgium'
		 WHEN 	employee_residence   =  'BG' THEN 'Bulgaria'
		 WHEN 	employee_residence   =  'BO' THEN 'Bolivia' 
		 WHEN 	employee_residence   =  'BR' THEN 'Brazil' 
		 WHEN 	employee_residence   =  'CA' THEN 'Canada'
		 WHEN 	employee_residence   =  'CF' THEN 'Central African Republic'
		 WHEN 	employee_residence   =  'CH' THEN 'Switzerland'
		 WHEN 	employee_residence   =  'CL' THEN 'Chile' 
		 WHEN 	employee_residence   =  'CN' THEN 'China'
		 WHEN 	employee_residence   =  'CO' THEN 'Colombia' 
		 WHEN 	employee_residence   =  'CR' THEN 'Costa Rica'
		 WHEN 	employee_residence   =  'CY' THEN 'Cyprus'
		 WHEN 	employee_residence   =  'CZ' THEN 'Czech Republic'
		 WHEN 	employee_residence   =  'DE' THEN 'Germany' 
		 WHEN 	employee_residence   =  'DK' THEN 'Denmark'
		 WHEN 	employee_residence   =  'DO' THEN 'Dominican Republic'
		 WHEN 	employee_residence   =  'DZ' THEN 'Algeria' 
		 WHEN 	employee_residence   =  'EE' THEN 'Estonia' 
		 WHEN 	employee_residence   =  'EG' THEN 'Egypt'
		 WHEN 	employee_residence   =  'ES' THEN 'Spain'
		 WHEN 	employee_residence   =  'FI' THEN 'Finland' 
		 WHEN 	employee_residence   =  'FR' THEN 'France'
		 WHEN 	employee_residence   =  'GB' THEN 'United Kingdom'
		 WHEN 	employee_residence   =  'GH' THEN 'Ghana'
		 WHEN 	employee_residence   =  'GR' THEN 'Greece'
		 WHEN 	employee_residence   =  'HK' THEN 'Hong Kong'
		 WHEN 	employee_residence   =  'HN' THEN 'Honduras'
		 WHEN 	employee_residence   =  'HR' THEN 'Croatia'
		 WHEN 	employee_residence   =  'HU' THEN 'Hungary' 
		 WHEN 	employee_residence   =  'ID' THEN 'Indonesia'
		 WHEN 	employee_residence   =  'IE' THEN 'Ireland' 
		 WHEN 	employee_residence   =  'IL' THEN 'Israel'
		 WHEN 	employee_residence   =  'IN' THEN 'India'
		 WHEN 	employee_residence   =  'IQ' THEN 'Iraq'
		 WHEN 	employee_residence   =  'IR' THEN 'Iran'
		 WHEN 	employee_residence   =  'IT' THEN 'Italy'
		 WHEN 	employee_residence   =  'JE' THEN 'Jersey' 
		 WHEN 	employee_residence   =  'JP' THEN 'Japan'
		 WHEN 	employee_residence   =  'KE' THEN 'Kenya'
		 WHEN 	employee_residence   =  'KW' THEN 'Kuwait'
		 WHEN 	employee_residence   =  'LT' THEN 'Lithuania'
		 WHEN 	employee_residence   =  'LU' THEN 'Luxembourg'
		 WHEN 	employee_residence   =  'LV' THEN 'Latvia'
		 WHEN 	employee_residence   =  'MA' THEN 'Morocco'
		 WHEN 	employee_residence   =  'MD' THEN 'Moldova'
		 WHEN 	employee_residence   =  'MK' THEN 'North Macedonia'
		 WHEN 	employee_residence   =  'MT' THEN 'Malta'
		 WHEN 	employee_residence   =  'MX' THEN 'Mexico'
		 WHEN 	employee_residence   =  'MY' THEN 'Malaysia'
		 WHEN 	employee_residence   =  'NG' THEN 'Nigeria' 
		 WHEN 	employee_residence   =  'NL' THEN 'Netherlands'
		 WHEN 	employee_residence   =  'NZ' THEN 'New Zealand'
		 WHEN 	employee_residence   =  'PH' THEN 'Philippines' 
		 WHEN 	employee_residence   =  'PK' THEN 'Pakistan'
		 WHEN 	employee_residence   =  'PL' THEN 'Poland'
	 	 WHEN 	employee_residence   =  'PR' THEN 'Puerto Rico'
		 WHEN 	employee_residence   =  'PT' THEN 'Portugal'
		 WHEN 	employee_residence   =  'RO' THEN 'Romania'
		 WHEN 	employee_residence   =  'RS' THEN 'Serbia'
		 WHEN 	employee_residence   =  'RU' THEN 'Russia'
		 WHEN 	employee_residence   =  'SE' THEN 'Sweden'
		 WHEN 	employee_residence   =  'SG' THEN 'Singapore'
		 WHEN 	employee_residence   =  'SI' THEN 'Slovenia' 
		 WHEN 	employee_residence   =  'SK' THEN 'Slovakia'
		 WHEN 	employee_residence   =  'TH' THEN 'Thailand'
		 WHEN 	employee_residence   =  'TN' THEN 'Tunisia'
		 WHEN 	employee_residence   =  'TR' THEN 'Turkey'
		 WHEN 	employee_residence   =  'UA' THEN 'Ukraine'
		 WHEN 	employee_residence   =  'US' THEN 'United States'
		 WHEN 	employee_residence   =  'VN' THEN 'Vietnam'
		 ELSE 	employee_residence END;

--Let's see how much each job earns in their currencies
SELECT. job_title, ROUND(AVG(salary), 2) AS average_salary, salary_currency
FROM data_science_jobs
GROUP BY job_title, salary_currency
ORDER BY average_salary DESC;

----Let's see how much each job earns in usd
SELECT job_title, ROUND(AVG(salary_in_usd), 2) AS average_salary
FROM data_science_jobs
GROUP BY job_title
ORDER BY average_salary DESC;

--Let's check which country pay most on average across all jobs
SELECT company_location, ROUND(AVG(salary_in_usd), 2) AS avg_salary_paid
FROM data_science_jobs
GROUP BY company_location
ORDER BY avg_salary_paid DESC;

--Also check company locations in terms of job-title, and how much they pay
WITH SalaryRanked AS
	(SELECT company_location, 
		   job_title, 
		   ROUND(AVG(salary_in_usd), 2) AS avg_salary_paid,
	   ROW_NUMBER() OVER (PARTITION BY company_location ORDER BY AVG(salary_in_usd) DESC) AS salary_rank
	  FROM data_science_jobs
	  GROUP BY company_location, job_title)

SELECT company_location, 
	   job_title, 
	   avg_salary_paid
FROM SalaryRanked
WHERE salary_rank = 1
ORDER BY job_title, avg_salary_paid DESC;

--Let's see how much on average in usdt was paid to data sceintists per year 
SELECT work_year, ROUND(AVG(salary_in_usd), 2) AS avg_salary_paid
FROM data_science_jobs
GROUP BY work_year
ORDER BY avg_salary_paid;

--So. let's check salaries according to Employment, then break down into job_title
SELECT employment, ROUND(AVG(salary_in_usd), 2) AS avg_salary_paid
FROM data_science_jobs
GROUP BY employment
ORDER BY avg_salary_paid DESC;

WITH SalaryRanked AS
	(SELECT employment, 
		   job_title, 
		   ROUND(AVG(salary_in_usd), 2) AS avg_salary_paid,
	   ROW_NUMBER() OVER (PARTITION BY employment ORDER BY AVG(salary_in_usd) DESC) AS salary_rank
	  FROM data_science_jobs
	  GROUP BY employment, job_title)

SELECT employment, 
	   job_title, 
	   avg_salary_paid
FROM SalaryRanked
WHERE salary_rank = 1 OR  salary_rank = 2 OR  salary_rank = 3
ORDER BY employment, avg_salary_paid DESC;

--Let's now check salaries according to Experience on a general basis 
SELECT experience, ROUND(AVG(salary_in_usd), 2) AS avg_salary_paid
FROM data_science_jobs
GROUP BY experience
ORDER BY avg_salary_paid DESC;

--Then by job title
WITH SalaryRanked AS
	(SELECT experience, 
		   job_title, 
		   ROUND(AVG(salary_in_usd), 2) AS avg_salary_paid,
	   ROW_NUMBER() OVER (PARTITION BY experience ORDER BY AVG(salary_in_usd) DESC) AS salary_rank
	  FROM data_science_jobs
	  GROUP BY experience, job_title)

SELECT experience, 
	   job_title, 
	   avg_salary_paid
FROM SalaryRanked
WHERE salary_rank = 1 OR  salary_rank = 2 OR  salary_rank = 3
ORDER BY experience, avg_salary_paid DESC;

--Let's check for countries that have the most earning employees generally
SELECT employee_residence, ROUND(AVG(salary_in_usd), 2) AS avg_salary_earned
FROM data_science_jobs
GROUP BY employee_residence
ORDER BY avg_salary_earned DESC;

--and then by job title
WITH SalaryRanked AS
	(SELECT employee_residence, 
		   job_title, 
		   ROUND(AVG(salary_in_usd), 2) AS avg_salary_earned,
	   ROW_NUMBER() OVER (PARTITION BY employee_residence ORDER BY AVG(salary_in_usd) DESC) AS salary_rank
	  FROM data_science_jobs
	  GROUP BY employee_residence, job_title)

SELECT employee_residence, 
	   job_title, 
	   avg_salary_earned
FROM SalaryRanked
WHERE salary_rank = 1
ORDER BY job_title, avg_salary_earned DESC;

--Let's check for pay, according to company size
SELECT company_size, ROUND(AVG(salary_in_usd), 2) AS avg_salary_earned
FROM data_science_jobs
GROUP BY company_size
ORDER BY avg_salary_earned DESC;

--Let's check for salaries according to Remote ratio overall
SELECT remote_ratio, ROUND(AVG(salary_in_usd), 2) AS avg_salary_paid
FROM data_science_jobs
GROUP BY remote_ratio
ORDER BY avg_salary_paid DESC;

--...By Job title
WITH SalaryRanked AS
	(SELECT remote_ratio, 
		   job_title, 
		   ROUND(AVG(salary_in_usd), 2) AS avg_salary_paid,
	   ROW_NUMBER() OVER (PARTITION BY remote_ratio ORDER BY AVG(salary_in_usd) DESC) AS salary_rank
	  FROM data_science_jobs
	  GROUP BY remote_ratio, job_title)

SELECT remote_ratio, 
	   job_title, 
	   avg_salary_paid
FROM SalaryRanked
WHERE salary_rank = 1 OR  salary_rank = 2 OR  salary_rank = 3
ORDER BY remote_ratio, avg_salary_paid DESC;
