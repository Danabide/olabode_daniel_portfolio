SELECT *
FROM druganalysis_table;

--Returns only Distinct Rowa and Also create another column where only the numbers in the Reviews
--column is extracted
CREATE TABLE drugcleaned_table AS
SELECT DISTINCT *,
	   SPLIT_PART("Reviews", ' ', 1) AS review
FROM druganalysis_table;

SELECT *
FROM drugcleaned_table;

--Beginning of Analysis 
--Determinining the Number of Conditions we have
SELECT DISTINCT "Condition"
FROM drugcleaned_table
ORDER BY "Condition";


--Aggregating the Data by the Total Reviews, Average effectiveness, Ease of Use and Satisfaction 
SELECT "Condition", 
	   "Drug",
	   "Indication", 
	   "Type", 
	   SUM(CAST(review AS NUMERIC)) AS total_reviews,
	   ROUND(AVG(CAST("Effective" AS NUMERIC)), 2) AS avg_effective,
	   ROUND(AVG(CAST("EaseOfUse" AS NUMERIC)), 2) AS avg_ease,
	   ROUND(AVG(CAST("Satisfaction" AS NUMERIC)), 2) AS avg_satisfied,
	   "Information"
FROM drugcleaned_table
GROUP BY "Condition",
		 "Drug",
		 "Indication",
		 "Type",
		 "Information"
ORDER BY "Condition",
		 total_reviews DESC,
		 avg_effective DESC,
		 avg_ease DESC,
		 avg_satisfied DESC;



--Aggregating the Data by the Weighted average effectiveness, Ease of Use and Satisfaction
SELECT 
	 "Condition",
	 "Drug",
	 "Indication",
	 "Type",
	 ROUND(SUM(CAST("Effective" AS NUMERIC) * CAST("review" AS NUMERIC))/
		 						SUM(CAST("review" AS NUMERIC)), 2)
		 															AS weightedavg_effective,
	 ROUND(SUM(CAST("EaseOfUse" AS NUMERIC) * CAST("review" AS NUMERIC))/
		 						SUM(CAST("review" AS NUMERIC)), 2)
		 															AS weightedavg_ease,
	 ROUND(SUM(CAST("Satisfaction" AS NUMERIC) * CAST("review" AS NUMERIC))/
		 						SUM(CAST("review" AS NUMERIC)), 2)
		 															AS weightedavg_satisfied,
	 "Information"
FROM drugcleaned_table	
GROUP BY "Condition",
	   	 "Drug",
	     "Indication",
	     "Type",
		 "Information"
ORDER BY "Condition",
		 weightedavg_effective DESC,
		 weightedavg_ease DESC,
		 weightedavg_satisfied DESC;


