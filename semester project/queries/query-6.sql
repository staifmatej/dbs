
/*
Query: List all inmates (first name, last name, and date of birth) who were born before the year 1950.
*/

SELECT v.jmeno, v.prijmeni, v.datum_narozeni
FROM vezen v
WHERE datum_narozeni < TO_DATE('1950-01-01', 'yyyy-mm-dd');
