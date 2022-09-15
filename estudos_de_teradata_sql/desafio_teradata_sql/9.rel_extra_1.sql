DATABASE casesql_db;

--Número de esposas e média de filhos por número de esposas
SEL TO_NUMBER(spouses) AS n_spouses,
	AVG(children)
FROM names
GROUP BY n_spouses
ORDER BY n_spouses;

-- Os 5 filmes que mais receberam notas 10 e seus respectivos lucros (considerando valores em dólar)
SEL TOP 5
	mov.original_title,
	rat.votes_10,
	worlwide_gross_income,
	budget,
	TO_CHAR(worlwide_gross_income - budget, '$999,999,999,999.99') AS profit
FROM ref_movies mov
LEFT JOIN ratings rat ON mov.imdb_title_id = rat.imdb_title_id
WHERE mov.budget LIKE '$%'
AND mov.worlwide_gross_income LIKE '$%'
ORDER BY 2 DESC;

