DATABASE casesql_db;

WITH cte AS (
-- Lista dos TOP 10 filmes mais bem avaliados por ano e suas categorias separadas
SEL RANK() OVER (PARTITION BY "year" ORDER BY avg_vote DESC) AS "TOP *",
	"year",
	original_title,
	gen.genre_1,
	gen.genre_2,
	gen.genre_3
FROM ref_movies mov
INNER JOIN (	SEL imdb_title_id,
					STRTOK(genre, ',', 1) AS genre_1,
					TRIM(STRTOK(genre, ',', 2)) AS genre_2,
					TRIM(STRTOK(genre, ',', 3)) AS genre_3
				FROM ref_movies ) gen ON mov.imdb_title_id = gen.imdb_title_id
WHERE "year" >= (EXTRACT(YEAR FROM CURRENT_DATE) - 10)
QUALIFY "TOP *" <= 10
) -- Final WITH

-- Contando os gêneros separadamente com base na tabela de gêneros, referenciando a tabela temporária acima
SEL genre,
	COUNT(genre) AS total_genre
FROM genres gen
INNER JOIN cte ON gen.genre = cte.genre_1 OR gen.genre = cte.genre_2 OR gen.genre = cte.genre_3
GROUP BY genre
ORDER BY total_genre DESC;


