-- OS ARQUIVOS .SQL CONTIDOS NESSA PASTA FAZEM PARTE DO DESAFIO DE SQL QUE CONCLUI DURANTE MEU PERÍODO DE TREINAMENTO NA JUMP LABEL SOLUTIONS --


/* -------------------------------
   ---- COMO RODAR AS QUERYS? ----
   ------------------------------- */

- 1º Passo: As tabelas iniciais são tabelas que representam os dados sobre os filmes do IMDB última vez atualizados em 2021, como não posso importar os dados para o github, precisará achá-los na internet
		(Também é possível interpretar os arquivos a partir da estrutura das tabelas que se encontra no arquivo .png também nessa pasta)
- 2º Passo: Criar um banco de dados no Teradata Studio Express que se chame "casesql_db"
- 3º Passo: Rodar o script novas_tabelas.sql para que as novas tabelas "ref_movies" e "genres" sejam inseridas no banco de dados
- 4º Passo: rodar por completo a query desejada e observar os resultados...

!!!!!!!! ATENÇÃO !!!!!!!!!
AS QUERYS CONTIDAS NA PASTA FORAM DESENVOLVIDAS UTILIZANDO O TERADATA STUDIO EXPRESS 17.10 E PORTANTO A LINGUAGEM CONSIDERADA DEVE SER SQL COM AS EXTENSÕES PREVISTAS NA DOCUMENTAÇÃO DO TERADATA SQL!

-- POR FIM, QUERO AGRADECER A MEU INSTRUTOR DE SQL FELIPE PALMERI QUE ME ACOMPANHOU E ME AUXILIOU DURANTE TODO O PROCESSO DE DESENVOLVIMENTO DOS RELATÓRIOS --

-- ENUNCIADOS DOS RELATÓRIOS ABAIXO --

- 1. Gerar um relatório contendo os 10 filmes mais lucrativos de todos os tempos, e identificar em qual faixa de idade/gênero eles foram mais bem avaliados.

- 2. Quais os gêneros que mais aparecem entre os Top 10 filmes mais bem avaliados de cada ano, nos últimos 10 anos.

- 3. Quais os 50 filmes com menor lucratividade ou que deram prejuízo, nos últimos 30 anos. Considerar apenas valores em dólar ($).

- 4. Selecionar os top 10 filmes baseados nas avaliações dos usuários, para cada ano, nos últimos 20 anos.

- 5. Gerar um relatório com os top 10 filmes mais bem avaliados pela crítica e os top 10 pela avaliação de usuário, contendo também o budget dos filmes.

- 6. Gerar um relatório contendo a duração média de 5 gêneros a sua escolha.

- 7. Gerar um relatório sobre os 5 filmes mais lucrativos de um ator/atriz(que podemos filtrar), trazendo o nome, ano de exibição, e Lucro obtido. Considerar apenas valores em dólar($).

- 8. Baseado em um filme que iremos selecionar, trazer um relatório contendo quais os atores/atrizes participantes, e pra cada ator trazer um campo com a média de avaliação da crítica dos últimos 
     5 filmes em que esse ator/atriz participou.

- 9. e 10. Gerar mais duas análises a sua escolha, baseado nessas tabelas (em uma delas deve incluir a análise exploratória de dois campos, um quantitativo e um qualitativo, respectivamente).



