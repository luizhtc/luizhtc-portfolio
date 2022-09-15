DATABASE casesql_db;


-- Query para encontrar os TOP lucros ordenados
SEL TOP 50
	original_title,
	"year",
	TO_CHAR((worlwide_gross_income - budget), '$999,999,999,999.99') AS profit
FROM ref_movies
WHERE budget LIKE '$%' 
AND worlwide_gross_income LIKE '$%'
AND "year" > (EXTRACT(YEAR FROM CURRENT_DATE) - 30)
ORDER BY profit + 0; -- Ordenação com conversão implícita