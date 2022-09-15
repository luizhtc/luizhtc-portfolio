DATABASE casesql_db;

-- Tabela Refinada de movies
CREATE TABLE ref_movies AS (
SEL imdb_title_id,
	"title",
	original_title,
	TO_NUMBER(REGEXP_REPLACE("year", '[^0-9]', '')) AS "year",
	CASE	WHEN LENGTH(date_published) = 4 THEN TO_DATE(date_published || '-01-01')
			WHEN LENGTH(date_published) = 10 THEN TO_DATE(date_published)
			ELSE TO_DATE('2019-01-01')
	END AS date_published,
	genre,
	TO_NUMBER(duration) AS duration,
	country,
	"language",
	director,
	writer,
	production_company,
	actors,
	description,
	CAST (avg_vote AS DEC(2,1)) AS avg_vote,
	TO_NUMBER(votes) AS votes,
	budget,
	usa_gross_income,
	worlwide_gross_income,
	TO_NUMBER(metascore) AS metascore,
	TO_NUMBER(reviews_from_users) AS reviews_from_users,
	TO_NUMBER(reviews_from_critics) AS reviews_from_critics
FROM movies
) WITH DATA;

-- Tabela de categorias dos filmes
CREATE TABLE genres AS (
SEL DISTINCT
	STRTOK(genre, ',', 1) AS genre
FROM ref_movies

UNION

SEL DISTINCT
	TRIM(STRTOK(genre, ',', 2)) AS genre_2
FROM ref_movies
WHERE genre_2 IS NOT NULL

UNION

SEL DISTINCT
	TRIM(STRTOK(genre, ',', 3)) AS genre_3
FROM ref_movies
WHERE genre_3 IS NOT NULL
) WITH DATA;


