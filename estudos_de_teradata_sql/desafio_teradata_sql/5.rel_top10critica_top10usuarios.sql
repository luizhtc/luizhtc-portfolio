DATABASE casesql_db;

-- Tabela por avaliação de críticos
SEL RANK() OVER (ORDER BY metascore DESC) AS "TOP *",
	original_title,
	CAST (metascore AS DEC(4,1)) AS "metascore/userscore",
	budget,
	'Avaliação Crítica' AS tipo_avaliacao
FROM ref_movies
QUALIFY "TOP *" <= 10
WHERE budget IS NOT NULL -- Preciso do budget, então desconsidero filmes onde nada sei sobre budget

UNION

-- Tabela por avaliação de usuários
SEL RANK() OVER (ORDER BY user_avg DESC) AS "TOP *",
	mov.original_title,
	(rat.mv + rat.top1000 + rat.usv + rat.nusv) / 4 AS user_avg,
	mov.budget,
	'Avaliação Usuário'
FROM ref_movies mov
INNER JOIN (	SEL imdb_title_id,
					ZEROIFNULL(mean_vote) AS mv,
					ZEROIFNULL(top1000_voters_rating) AS top1000,
					ZEROIFNULL(us_voters_rating) AS usv,
					ZEROIFNULL(non_us_voters_rating) AS nusv
				FROM ratings) rat ON mov.imdb_title_id = rat.imdb_title_id
QUALIFY "TOP *" <= 10
WHERE budget IS NOT NULL -- Preciso do budget, então desconsidero filmes onde nada sei sobre budget
ORDER BY 5;
				
