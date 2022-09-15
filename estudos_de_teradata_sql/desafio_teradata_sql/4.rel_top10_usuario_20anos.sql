DATABASE casesql_db;


SEL RANK() OVER (PARTITION BY "year" ORDER BY user_score DESC) AS top10_year,
	mov."year",
	mov.original_title,
	(rat.mv + rat.top1000 + rat.usv + rat.nusv) / 4 AS user_score -- Avaliação mais "justa"
FROM ref_movies mov
INNER JOIN (SEL imdb_title_id,
				ZEROIFNULL(mean_vote) AS mv,
				ZEROIFNULL(top1000_voters_rating) AS top1000,
				ZEROIFNULL(us_voters_rating) AS usv,
				ZEROIFNULL(non_us_voters_rating) AS nusv
			FROM ratings) rat ON mov.imdb_title_id = rat.imdb_title_id
WHERE "year" >= EXTRACT(YEAR FROM CURRENT_DATE) - 20
QUALIFY top10_year <= 10;