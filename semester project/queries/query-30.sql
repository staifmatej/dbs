
/*
Query: Display a list of all prisoners including their first and last names. If they have any allergies, also display the ID of these allergens. 
If a prisoner has no allergies, display NULL instead.
*/

SELECT v.id_vezen, v.jmeno, v.prijmeni, va.id_alergeny
FROM vezen v
LEFT JOIN vezen_alergeny va ON v.id_vezen = va.id_vezen;
