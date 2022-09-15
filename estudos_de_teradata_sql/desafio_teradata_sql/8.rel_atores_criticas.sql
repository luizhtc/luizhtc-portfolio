DATABASE casesql_db;

-- Lista dos últimos 5 filmes de cada ator e sua média
CREATE MACRO atores_medias (filme VARCHAR(505)) AS (
WITH cte AS (
SEL ROW_NUMBER() OVER (PARTITION BY ator."name" ORDER BY mov."year" DESC) AS RN,
	mov.metascore,
	ator."name"
FROM ref_movies mov
INNER JOIN title_principals papel ON mov.imdb_title_id = papel.imdb_title_id
INNER JOIN names ator ON papel.imdb_name_id = ator.imdb_name_id
WHERE metascore IS NOT NULL
AND ator."name" IN (SEL ator."name"
			  FROM names ator	-- Lista dos atores por filmes
			  INNER JOIN title_principals papel ON ator.imdb_name_id = papel.imdb_name_id
			  INNER JOIN ref_movies mov ON papel.imdb_title_id = mov.imdb_title_id
			  WHERE original_title LIKE '%' || :filme ||'%')
QUALIFY RN <= 5
) -- Fim do WITH

SEL "name" AS nome_do_ator,
	AVG(metascore) AS media_5filmes
FROM cte
GROUP BY "name"
ORDER BY 2 DESC;
); -- Fim do macro

EXEC atores_medias('Avengers: Age of Ultron');

