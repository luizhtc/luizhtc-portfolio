DATABASE casesql_db;


WITH cte AS ( -- Início do WITH
	SEL * FROM TD_UNPIVOT( -- Início do UNPIVOT
	ON (SELECT 	imdb_title_id, 
				males_0age_avg_vote, 
				males_18age_avg_vote, 
				males_30age_avg_vote,
				males_45age_avg_vote,
				females_0age_avg_vote,
				females_18age_avg_vote,
				females_30age_avg_vote,
				females_45age_avg_vote
		FROM ratings)
	USING
	VALUE_COLUMNS('nota') -- Nome da coluna de valores
	
	UNPIVOT_COLUMN('idade/gen') -- Nome da coluna que receberá as colunas pivotadas
	
	COLUMN_LIST('males_0age_avg_vote', 'males_18age_avg_vote', 'males_30age_avg_vote', 'males_45age_avg_vote',
				'females_0age_avg_vote', 'females_18age_avg_vote', 'females_30age_avg_vote', 'females_45age_avg_vote')
				-- Lista de colunas a serem pivotadas acima
				
	COLUMN_ALIAS_LIST(	'homens_0', 'homens_18', 'homens_30', 'homens_45',
						'mulheres_0', 'mulheres_18', 'mulheres_30', 'mulheres_45')
						-- ALIAS das colunas que foram pivotadas
						
	) nome_tabela_unpivot -- Final UNPIVOT
) -- Final do WITH

SEL INITCAP(mov.original_title) AS original_title,
	TO_CHAR(  mov.worlwide_gross_income
			- mov.budget, '$999,999,999,999.99') as profit,
	notas."idade/gen"
FROM cte notas
INNER JOIN ref_movies mov ON notas.imdb_title_id = mov.imdb_title_id
WHERE (mov.budget LIKE '$%' 
AND mov.worlwide_gross_income LIKE '$%') -- WHERE filtrando valores que não são dólar

ORDER BY profit + 0 DESC -- Ordenação implícita

QUALIFY (RANK() OVER (PARTITION BY mov.imdb_title_id ORDER BY nota DESC) = 1) 
AND (ROW_NUMBER() OVER (ORDER BY profit DESC) <= 80); -- QUALIFY trazendo os maiores e os 10 primeiros.

