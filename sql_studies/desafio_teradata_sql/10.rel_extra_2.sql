DATABASE casesql_db;

-- TOP 10 filmes mais bem avaliados nos EUA, seu lucro nos EUA e classificando o lucro em categorias e considerando
-- valores em dólar.

SEL MAX(usa_gross_income - budget) AS max_profit,
	MIN(usa_gross_income - budget) AS min_pŕofit -- Buscando a amplitude
FROM ref_movies
WHERE budget LIKE '$%'
AND usa_gross_income LIKE '$%';

-- 7 Classes de $100.000.000 cada, máximo $700.000.000
CREATE TABLE usa_profit_grades (
	grade VARCHAR(2),
	max_profit INTEGER,
	min_profit INTEGER
);

-- Dividindo as classes
INSERT INTO usa_profit_grades VALUES ('F', 99999999, 0);
INSERT INTO usa_profit_grades VALUES ('E', 199999999, 100000000);
INSERT INTO usa_profit_grades VALUES ('D', 299999999, 200000000);
INSERT INTO usa_profit_grades VALUES ('C', 399999999, 300000000);
INSERT INTO usa_profit_grades VALUES ('B', 499999999, 400000000);
INSERT INTO usa_profit_grades VALUES ('A', 599999999, 500000000);
INSERT INTO usa_profit_grades VALUES ('A+', 700000000, 600000000);

-- Todos os filmes, seus lucros em relação aos EUA e a nota de lucro, além da sua nota em relação ao público dos EUA,
-- ordenando pelo lucro obtido, excluindo os filmes com lucro abaixo de zero (prejuízo)
SEL mov.original_title,
	TO_CHAR(TO_NUMBER(OREPLACE(mov.usa_gross_income, '$ ', ''))
	 		- TO_NUMBER(OREPLACE(mov.budget, '$ ', '')), '$999,999,999.99') AS profit,
	grd.grade AS profit_grade,
	rat.us_voters_rating
FROM ref_movies mov
INNER JOIN usa_profit_grades grd ON profit BETWEEN grd.min_profit AND grd.max_profit
INNER JOIN ratings rat ON mov.imdb_title_id = rat.imdb_title_id
WHERE mov.usa_gross_income LIKE '$%'
AND mov.budget LIKE '$%'
AND profit_grade LIKE 'A'
ORDER BY 2 DESC;

-- Quantos filmes existem em cada categoria?
WITH cte AS (
SEL mov.original_title,
	TO_CHAR(TO_NUMBER(OREPLACE(mov.usa_gross_income, '$ ', ''))
	 		- TO_NUMBER(OREPLACE(mov.budget, '$ ', '')), '$999,999,999.99') AS profit,
	grd.grade AS profit_grade,
	rat.us_voters_rating
FROM ref_movies mov
INNER JOIN usa_profit_grades grd ON profit BETWEEN grd.min_profit AND grd.max_profit
INNER JOIN ratings rat ON mov.imdb_title_id = rat.imdb_title_id
WHERE mov.usa_gross_income LIKE '$%'
AND mov.budget LIKE '$%'
)

SEL profit_grade,
	COUNT(profit_grade) AS "* de filmes"
FROM cte
GROUP BY 1
ORDER BY 2;

		
		
		