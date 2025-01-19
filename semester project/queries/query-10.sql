
/*
Query: List all information about allergens to which some inmates have an intolerance.
*/

SELECT a.id_alergeny, a.nazev, a.cislo_alergenu_dle_eu, a.zdroj
FROM alergeny a
WHERE a.id_alergeny IN (
    SELECT DISTINCT id_alergeny
    FROM vezen v
    JOIN vezen_alergeny va USING(id_vezen)
);
