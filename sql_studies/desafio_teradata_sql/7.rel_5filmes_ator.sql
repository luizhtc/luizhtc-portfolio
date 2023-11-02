DATABASE casesql_db;


REPLACE MACRO top5lucros_ator (nome_ator VARCHAR(54)) AS (
SEL TOP 5
	original_title,
	"year",
	actors,
	TO_CHAR((worlwide_gross_income - budget), '$999,999,999,999.99') AS profit
FROM ref_movies
WHERE actors LIKE '%' || :nome_ator || '%'
AND (budget LIKE '$%' AND worlwide_gross_income LIKE '$%')
ORDER BY profit + 0 DESC; -- Ordenação por conversão implícita
);

EXEC top5lucros_ator ('Vin Diesel');


