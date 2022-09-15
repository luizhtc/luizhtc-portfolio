DATABASE casesql_db;

----------------------- Validações nas novas tabelas --------------------------------------------------------------------------

-- Coluna year em movies tem apenas anos de 4 dígitos
SEL "year"
FROM movies
WHERE "year" NOT LIKE '____';
-- Ou dados que podem ser facilmente convertidos a números e mantém a mesma estrutura
SEL TO_NUMBER(REGEXP_REPLACE("year", '[^0-9]', ''))
FROM movies
WHERE "year" NOT LIKE '____';


-- Coluna date_published contém dados do tipo year, date e string
-- Seria possível converter com o formato padrão do Teradata?
SEL date_published
FROM movies
WHERE date_published LIKE '____'; -- Retorna 4.562 linhas

SEL date_published
FROM movies
WHERE date_published LIKE '____-__-__'; -- Retorna 81.287 linhas

SEL date_published
FROM movies
WHERE date_published NOT LIKE '____' 
AND date_published NOT LIKE '____-__-__'; -- Retorna 1 linha (TV Movie 2019)
-- Total: 85850 linhas, mesmo total da tabela original (SEL COUNT(*) FROM movies)


-- Extrai as substrings de duration que não sejam números de 0-9
-- Se não são encontradas substrings, retorna NULL
SEL REGEXP_SUBSTR(duration, '[^0-9]') as dur
FROM movies
WHERE dur IS NOT NULL;
-- Todas as colunas convertidas para números podem ser verificadas com o SELECT acima
-- Em colunas com separador decimal, será retornado o separador decimal

-- Garantindo que avg_vote seja sempre um número DEC(2,1)
SEL avg_vote
FROM movies
WHERE LENGTH(avg_vote) <> 3
OR avg_vote NOT LIKE '_._';


-- Máximo de 3 categorias por 'genre'
SEL REGEXP_REPLACE(genre, '[^,]') AS virgula
FROM ref_movies
WHERE LENGTH(virgula) > 2;

-- Validando que a tabela de gêneros se refere a TODOS os gêneros da tabela movies
SEL TRIM(STRTOK(genre, ',', 1)) AS genre_1,
	TRIM(STRTOK(genre, ',', 2)) AS genre_2,
	TRIM(STRTOK(genre, ',', 3)) AS genre_3
FROM ref_movies
-- Sem o WHERE, retornamos os gêneros divididos em 3 colunas
-- Adicionando o WHERE, não retornamos nada
WHERE genre_3 NOT IN (SEL genre FROM genres);

-----------------------------------------------------------------------------------------------------------------------------------

----------------------------------Validações relatórios----------------------------------------------------------------------------
-- Relatório 1
-- Encontrar o ID e os valores do filme, podemos fazer as contas pela calculadora e assim validar cada resultado
SEL imdb_title_id,
	original_title,
	budget,
	worlwide_gross_income
FROM ref_movies
WHERE original_title LIKE 'Avatar';

-- Aplicar o ID em ratings para validar nosso INNER JOIN
-- Podemos encontrar manualmente qual dos valores são maiores entre gêneros e idades
SEL allgenders_0age_avg_vote,
	allgenders_18age_avg_vote,
	allgenders_30age_avg_vote,
	allgenders_45age_avg_vote,
	'||||' AS div,
	males_allages_avg_vote,
	females_allages_avg_vote
FROM ratings
WHERE imdb_title_id LIKE 'tt0499549';


-- Relatório 2
-- Trazendo a lista reduzida, por exemplo dos últimos 2 anos
-- Dessa forma podemos contar todos os valores manualmente e comparar com a tabela final


-- Relatório 3
-- Trazendo o orçamento e o ganho bruto de cada filme separadamente, podemos verificar os valores
SEL budget,
	worlwide_gross_income
FROM ref_movies
WHERE original_title LIKE 'The Irishman';

-- Garantindo que os filmes estão dentro dos últimos 30 anos
-- A query a seguir não deve retornar nenhum valor
WITH cte AS (
SEL TOP 50
	original_title,
	"year",
	TO_CHAR((worlwide_gross_income - budget), '$999,999,999,999.99') AS profit
FROM ref_movies
WHERE budget LIKE '$%' 
AND worlwide_gross_income LIKE '$%'
AND "year" > (EXTRACT(YEAR FROM CURRENT_DATE) - 30)
ORDER BY profit + 0
) -- Fim do WITH

SEL "year"
FROM cte
WHERE "year" < 1992 OR "year" > 2022;


-- Relatório 4
-- Ao olhar para a própria tabela resultado, podemos confirmar que as médias de votos sempre são maiores

-- Relatório 5
-- Podemos olhar a lista de metascores = 100 na internet e condiz com os 13 nomes trazidos pela query

-- Relatório 6
-- A partir da lista de durações dos documentários, gênero que menos aparece, podemos somar manualmente e trazer a média,
-- Que é igual ao número que trazemos na query principal, 88 minutos.
SEL duration
FROM ref_movies
WHERE genre LIKE '%Documentary%';

-- Relatório 7
-- Garantindo que os 5 filmes trazidos pela query estão na lista de filmes do ator
SEL original_title
FROM ref_movies
WHERE actors LIKE '%Vin Diesel%';

-- Relatório 8
-- Trazendo todos os filmes do ator, ordenando e selecionando manualmente os 5 últimos filmes, fazendo a média
-- é possível comparar cada valor obtido para cada ator e associar com seu valor na query principal
SEL original_title,
	metascore,
	actors,
	"year"
FROM ref_movies
WHERE actors LIKE '%Chris Evans%'
AND metascore IS NOT NULL
ORDER BY "year" DESC;

