DATABASE casesql_db;


-- Manter a primeira query com 11 CHAR de tamanho!
SEL 'Action     ' AS genre,
	CAST (AVG(duration) AS INTEGER) || ' minutes' AS avg_dur_minutes
FROM ref_movies
WHERE genre LIKE '%Action%'

UNION

SEL 'Drama' AS genre,
	CAST (AVG(duration) AS INTEGER) || ' minutes'
FROM ref_movies
WHERE genre LIKE '%Drama%'

UNION

SEL 'Adventure' AS genre,
	CAST (AVG(duration) AS INTEGER) || ' minutes'
FROM ref_movies
WHERE genre LIKE '%Adventure%'

UNION

SEL 'Documentary' AS genre,
	CAST (AVG(duration) AS INTEGER) || ' minutes'
FROM ref_movies
WHERE genre LIKE '%Documentary%'

UNION

SEL 'Comedy' AS genre,
	CAST (AVG(duration) AS INTEGER) || ' minutes'
FROM ref_movies
WHERE genre LIKE '%Comedy%'
ORDER BY 2;



