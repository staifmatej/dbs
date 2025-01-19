/*
Query: Select employees who are guards and have inspected at least one meal.
*/

SELECT DISTINCT id_zamestnanec
FROM bachar b
JOIN hotove_jidlo hj ON b.id_zamestnanec=hj.bachar_id_zamestnanec;
