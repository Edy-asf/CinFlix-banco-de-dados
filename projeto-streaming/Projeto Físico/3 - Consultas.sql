-- =====================================================================
-- CINFLIX - PLATAFORMA DE STREAMING DE FILMES E SÉRIES
-- Projeto físico: consultas (SELECT) - Oracle
--
-- Há pelo menos duas consultas de cada tipo exigido na checklist.
-- O resultado indicado em cada uma vale para os dados do script de povoamento.
-- =====================================================================


-----------------------------------------------------------------------
-- 1. GROUP BY / HAVING
-----------------------------------------------------------------------

-- 1.1 Gêneros que têm pelo menos 3 conteúdos no catálogo
-- Resultado: Suspense (5), Drama (4), Aventura (3)

SELECT g.genero,
       COUNT(*) AS qtd_conteudos
FROM conteudo_genero g
GROUP BY g.genero
HAVING COUNT(*) >= 3
ORDER BY qtd_conteudos DESC;


-- 1.2 Conteúdos com mais de 250 minutos assistidos no total,
--     com a quantidade de sessões e a soma dos minutos
-- Resultado: Robôs do Sertão (405), Capibaribe Noir (381), O Farol de Olinda (354),
--            Sextou no Recife (276) e Frevo em Chamas (268)

SELECT c.titulo,
       COUNT(*) AS qtd_sessoes,
       SUM(a.minutos) AS total_minutos
FROM conteudo c
INNER JOIN assiste a ON a.cod_conteudo = c.cod_conteudo
GROUP BY c.cod_conteudo, c.titulo
HAVING SUM(a.minutos) > 250
ORDER BY total_minutos DESC;


-----------------------------------------------------------------------
-- 2. JUNÇÃO INTERNA
-----------------------------------------------------------------------

-- 2.1 Elenco do catálogo: artista, conteúdo em que atuou e personagem
-- Resultado: 19 linhas (uma por atuação)

SELECT ar.nome AS artista,
       c.titulo,
       atu.personagem
FROM atua atu
INNER JOIN artista ar ON ar.cod_artista = atu.cod_artista
INNER JOIN conteudo c ON c.cod_conteudo = atu.cod_conteudo
ORDER BY ar.nome, c.titulo;


-- 2.2 Assinantes de Pernambuco, com o nome e o preço do plano que assinam
-- Resultado: 6 assinantes (Ana, Bruno, Camila, Diego, Gabriela e Isabela)

SELECT a.nome AS assinante,
       a.end_cidade,
       p.nome AS plano,
       p.preco
FROM assinante a
INNER JOIN plano p ON p.cod_plano = a.cod_plano
WHERE a.end_uf = 'PE'
ORDER BY a.nome;


-----------------------------------------------------------------------
-- 3. JUNÇÃO EXTERNA
-----------------------------------------------------------------------

-- 3.1 Todos os planos e a quantidade de assinantes de cada um,
--     inclusive os planos que ninguém assina (LEFT OUTER JOIN)
-- Resultado: Padrão 3, Premium 3, Básico 2, Família 1, Universitário 0

SELECT p.nome AS plano,
       COUNT(a.cpf) AS qtd_assinantes
FROM plano p
LEFT OUTER JOIN assinante a ON a.cod_plano = p.cod_plano
GROUP BY p.cod_plano, p.nome
ORDER BY qtd_assinantes DESC, p.nome;


-- 3.2 Assinantes e cupons lado a lado: mostra quem resgatou qual cupom,
--     os assinantes sem cupom e os cupons ainda não resgatados (FULL OUTER JOIN)
-- Resultado: 12 linhas (4 resgates, 5 assinantes sem cupom, 3 cupons livres)

SELECT a.nome AS assinante,
       c.cod_cupom,
       c.desconto
FROM assinante a
FULL OUTER JOIN cupom c ON c.cpf_assinante = a.cpf
ORDER BY a.nome, c.cod_cupom;


-----------------------------------------------------------------------
-- 4. SEMI-JUNÇÃO
-----------------------------------------------------------------------

-- 4.1 Artistas que já receberam pelo menos um prêmio (EXISTS)
-- Resultado: Caio Monteiro, Dandara Reis, Helena Vasconcelos, Lia Nascimento, Rafael Pessoa

SELECT ar.nome
FROM artista ar
WHERE EXISTS (SELECT *
              FROM recebe r
              WHERE r.cod_artista = ar.cod_artista)
ORDER BY ar.nome;


-- 4.2 Conteúdos que já foram assistidos em algum dispositivo do tipo TV (IN)
-- Resultado: 8 títulos

SELECT c.titulo
FROM conteudo c
WHERE c.cod_conteudo IN (SELECT a.cod_conteudo
                         FROM assiste a
                         INNER JOIN dispositivo d ON d.cod_dispositivo = a.cod_dispositivo
                         WHERE d.tipo = 'TV')
ORDER BY c.titulo;


-----------------------------------------------------------------------
-- 5. ANTI-JUNÇÃO
-----------------------------------------------------------------------

-- 5.1 Conteúdos que nunca foram assistidos por nenhum perfil (NOT EXISTS)
-- Resultado: Sombra do Baobá

SELECT c.titulo
FROM conteudo c
WHERE NOT EXISTS (SELECT *
                  FROM assiste a
                  WHERE a.cod_conteudo = c.cod_conteudo);


-- 5.2 Assinantes que nunca indicaram ninguém (NOT IN)
--     O filtro IS NOT NULL é necessário: se a subconsulta devolver um NULL,
--     o NOT IN não retorna nenhuma linha.
-- Resultado: Elisa, Felipe, Gabriela, Heitor e Isabela

SELECT a.nome
FROM assinante a
WHERE a.cpf NOT IN (SELECT i.cpf_indicador
                    FROM assinante i
                    WHERE i.cpf_indicador IS NOT NULL)
ORDER BY a.nome;


-----------------------------------------------------------------------
-- 6. SUBCONSULTA DO TIPO ESCALAR (devolve um único valor)
-----------------------------------------------------------------------

-- 6.1 Filmes com duração maior que a média de duração dos filmes
-- Resultado: Robôs do Sertão (135), Capibaribe Noir (127), O Farol de Olinda (118)
--            e Sombra do Baobá (109); a média é 108,1 minutos

SELECT c.titulo,
       f.duracao_min
FROM filme f
INNER JOIN conteudo c ON c.cod_conteudo = f.cod_conteudo
WHERE f.duracao_min > (SELECT AVG(f2.duracao_min)
                       FROM filme f2)
ORDER BY f.duracao_min DESC;


-- 6.2 Cada artista com a quantidade de prêmios que recebeu
--     (subconsulta escalar correlacionada na lista do SELECT)
-- Resultado: Helena e Lia com 2; Caio, Dandara e Rafael com 1; os demais com 0

SELECT ar.nome,
       (SELECT COUNT(*)
        FROM recebe r
        WHERE r.cod_artista = ar.cod_artista) AS qtd_premios
FROM artista ar
ORDER BY qtd_premios DESC, ar.nome;


-----------------------------------------------------------------------
-- 7. SUBCONSULTA DO TIPO LINHA (devolve uma única linha com várias colunas)
-----------------------------------------------------------------------

-- 7.1 Assinantes que moram na mesma cidade e UF da assinante Camila Souza
-- Resultado: Isabela Moura

SELECT a.nome
FROM assinante a
WHERE (a.end_cidade, a.end_uf) = (SELECT b.end_cidade, b.end_uf
                                  FROM assinante b
                                  WHERE b.cpf = '33333333333')
  AND a.cpf <> '33333333333';


-- 7.2 Conteúdos com a mesma classificação indicativa e lançados no mesmo ano
--     do filme Capibaribe Noir (C003)
-- Resultado: Marco Zero

SELECT c.titulo
FROM conteudo c
WHERE (c.classificacao, EXTRACT(YEAR FROM c.dt_lancamento)) =
      (SELECT x.classificacao, EXTRACT(YEAR FROM x.dt_lancamento)
       FROM conteudo x
       WHERE x.cod_conteudo = 'C003')
  AND c.cod_conteudo <> 'C003';


-----------------------------------------------------------------------
-- 8. SUBCONSULTA DO TIPO TABELA (devolve várias linhas e várias colunas)
-----------------------------------------------------------------------

-- 8.1 Total de minutos e de sessões de cada assinante, somando todos os seus perfis
--     (subconsulta no FROM)
-- Resultado: 9 assinantes, de Ana Beatriz Lima (649 minutos) a Isabela Moura (97 minutos)

SELECT a.nome,
       t.qtd_sessoes,
       t.total_minutos
FROM assinante a
INNER JOIN (SELECT s.cpf,
                   COUNT(*) AS qtd_sessoes,
                   SUM(s.minutos) AS total_minutos
            FROM assiste s
            GROUP BY s.cpf) t ON t.cpf = a.cpf
ORDER BY t.total_minutos DESC;


-- 8.2 Atuações premiadas: artista, conteúdo e personagem
--     (subconsulta com duas colunas no IN)
-- Resultado: 7 atuações

SELECT ar.nome AS artista,
       c.titulo,
       atu.personagem
FROM atua atu
INNER JOIN artista ar ON ar.cod_artista = atu.cod_artista
INNER JOIN conteudo c ON c.cod_conteudo = atu.cod_conteudo
WHERE (atu.cod_artista, atu.cod_conteudo) IN (SELECT r.cod_artista, r.cod_conteudo
                                            FROM recebe r)
ORDER BY ar.nome, c.titulo;


-----------------------------------------------------------------------
-- 9. OPERAÇÃO DE CONJUNTO
-----------------------------------------------------------------------

-- 9.1 Todas as pessoas cadastradas na plataforma, assinantes e artistas (UNION)
-- Resultado: 17 linhas (9 assinantes e 8 artistas)

SELECT a.nome, 'Assinante' AS tipo
FROM assinante a
UNION
SELECT ar.nome, 'Artista' AS tipo
FROM artista ar
ORDER BY 1;


-- 9.2 Conteúdos que são ao mesmo tempo de Drama e de Suspense (INTERSECT)
-- Resultado: O Farol de Olinda

SELECT c.titulo
FROM conteudo c
INNER JOIN conteudo_genero g ON g.cod_conteudo = c.cod_conteudo
WHERE g.genero = 'Drama'
INTERSECT
SELECT c.titulo
FROM conteudo c
INNER JOIN conteudo_genero g ON g.cod_conteudo = c.cod_conteudo
WHERE g.genero = 'Suspense';


-- 9.3 Artistas que atuaram em filmes, mas nunca em séries (MINUS)
-- Resultado: Tomás Ferraz

SELECT ar.nome
FROM artista ar
INNER JOIN atua atu ON atu.cod_artista = ar.cod_artista
INNER JOIN filme f ON f.cod_conteudo = atu.cod_conteudo
MINUS
SELECT ar.nome
FROM artista ar
INNER JOIN atua atu ON atu.cod_artista = ar.cod_artista
INNER JOIN serie s ON s.cod_conteudo = atu.cod_conteudo;
