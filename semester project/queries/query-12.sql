
/*
Query: Output the average age of inmates.
*/

SELECT ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, datum_narozeni))), 0)
AS "průměrný věk vězňů"
FROM vezen;
-- The 'EXTRACT' function allows extracting specific parts from date and time values,
-- which makes it easier to manipulate and analyze temporal data.
