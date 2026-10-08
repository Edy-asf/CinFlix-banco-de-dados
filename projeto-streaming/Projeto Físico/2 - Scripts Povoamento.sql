-- =====================================================================
-- CINFLIX - PLATAFORMA DE STREAMING DE FILMES E SÉRIES
-- Projeto físico: povoamento das tabelas (DML) - Oracle
--
-- Todos os dados são fictícios. A ordem dos INSERTs respeita as chaves
-- estrangeiras. No final há exemplos de UPDATE e DELETE.
-- =====================================================================


-- PLANOS (o plano Universitário fica sem assinantes de propósito)

INSERT INTO plano (cod_plano, nome, preco, max_telas) VALUES ('P01', 'Básico', 19.90, 1);
INSERT INTO plano (cod_plano, nome, preco, max_telas) VALUES ('P02', 'Padrão', 34.90, 2);
INSERT INTO plano (cod_plano, nome, preco, max_telas) VALUES ('P03', 'Premium', 49.90, 4);
INSERT INTO plano (cod_plano, nome, preco, max_telas) VALUES ('P04', 'Família', 59.90, 6);
INSERT INTO plano (cod_plano, nome, preco, max_telas) VALUES ('P05', 'Universitário', 14.90, 1);


-- ASSINANTES (quem indica precisa ser inserido antes de quem foi indicado)

INSERT INTO assinante (cpf, nome, dt_nascimento, end_cidade, end_uf, cod_plano, dt_adesao, cpf_indicador)
VALUES ('11111111111', 'Ana Beatriz Lima', TO_DATE('12/03/1995', 'DD/MM/YYYY'), 'Recife', 'PE', 'P03', TO_DATE('10/01/2023', 'DD/MM/YYYY'), NULL);
INSERT INTO assinante (cpf, nome, dt_nascimento, end_cidade, end_uf, cod_plano, dt_adesao, cpf_indicador)
VALUES ('22222222222', 'Bruno Carvalho', TO_DATE('25/07/1988', 'DD/MM/YYYY'), 'Recife', 'PE', 'P02', TO_DATE('15/02/2023', 'DD/MM/YYYY'), '11111111111');
INSERT INTO assinante (cpf, nome, dt_nascimento, end_cidade, end_uf, cod_plano, dt_adesao, cpf_indicador)
VALUES ('33333333333', 'Camila Souza', TO_DATE('02/11/2001', 'DD/MM/YYYY'), 'Olinda', 'PE', 'P01', TO_DATE('20/05/2023', 'DD/MM/YYYY'), '11111111111');
INSERT INTO assinante (cpf, nome, dt_nascimento, end_cidade, end_uf, cod_plano, dt_adesao, cpf_indicador)
VALUES ('44444444444', 'Diego Albuquerque', TO_DATE('30/01/1979', 'DD/MM/YYYY'), 'Caruaru', 'PE', 'P04', TO_DATE('01/08/2023', 'DD/MM/YYYY'), NULL);
INSERT INTO assinante (cpf, nome, dt_nascimento, end_cidade, end_uf, cod_plano, dt_adesao, cpf_indicador)
VALUES ('55555555555', 'Elisa Fernandes', TO_DATE('18/09/1999', 'DD/MM/YYYY'), 'João Pessoa', 'PB', 'P02', TO_DATE('05/01/2024', 'DD/MM/YYYY'), '22222222222');
INSERT INTO assinante (cpf, nome, dt_nascimento, end_cidade, end_uf, cod_plano, dt_adesao, cpf_indicador)
VALUES ('66666666666', 'Felipe Nogueira', TO_DATE('07/04/1992', 'DD/MM/YYYY'), 'Natal', 'RN', 'P03', TO_DATE('22/03/2024', 'DD/MM/YYYY'), '44444444444');
INSERT INTO assinante (cpf, nome, dt_nascimento, end_cidade, end_uf, cod_plano, dt_adesao, cpf_indicador)
VALUES ('77777777777', 'Gabriela Rocha', TO_DATE('15/12/2003', 'DD/MM/YYYY'), 'Recife', 'PE', 'P01', TO_DATE('30/06/2024', 'DD/MM/YYYY'), '33333333333');
INSERT INTO assinante (cpf, nome, dt_nascimento, end_cidade, end_uf, cod_plano, dt_adesao, cpf_indicador)
VALUES ('88888888888', 'Heitor Barbosa', TO_DATE('09/06/1985', 'DD/MM/YYYY'), 'Salvador', 'BA', 'P02', TO_DATE('12/09/2024', 'DD/MM/YYYY'), NULL);
INSERT INTO assinante (cpf, nome, dt_nascimento, end_cidade, end_uf, cod_plano, dt_adesao, cpf_indicador)
VALUES ('99999999999', 'Isabela Moura', TO_DATE('21/02/1997', 'DD/MM/YYYY'), 'Olinda', 'PE', 'P03', TO_DATE('01/02/2025', 'DD/MM/YYYY'), '11111111111');


-- PERFIS (o nome "Kids" se repete em contas diferentes: só identifica dentro do assinante)

INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('11111111111', 'Ana', TO_DATE('10/01/2023', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('11111111111', 'Kids', TO_DATE('12/01/2023', 'DD/MM/YYYY'), 'S');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('11111111111', 'Visitas', TO_DATE('01/06/2023', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('22222222222', 'Bruno', TO_DATE('15/02/2023', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('22222222222', 'Lari', TO_DATE('16/02/2023', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('33333333333', 'Camila', TO_DATE('20/05/2023', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('44444444444', 'Diego', TO_DATE('01/08/2023', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('44444444444', 'Kids', TO_DATE('01/08/2023', 'DD/MM/YYYY'), 'S');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('44444444444', 'Marta', TO_DATE('02/08/2023', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('44444444444', 'Vovó', TO_DATE('03/08/2023', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('55555555555', 'Elisa', TO_DATE('05/01/2024', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('66666666666', 'Felipe', TO_DATE('22/03/2024', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('66666666666', 'Kids', TO_DATE('01/04/2024', 'DD/MM/YYYY'), 'S');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('77777777777', 'Gabi', TO_DATE('30/06/2024', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('88888888888', 'Heitor', TO_DATE('12/09/2024', 'DD/MM/YYYY'), 'N');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('88888888888', 'Kids', TO_DATE('13/09/2024', 'DD/MM/YYYY'), 'S');
INSERT INTO perfil (cpf, nome_perfil, dt_criacao, infantil) VALUES ('99999999999', 'Isa', TO_DATE('01/02/2025', 'DD/MM/YYYY'), 'N');


-- CUPONS (cpf_assinante nulo = cupom ainda não resgatado)

INSERT INTO cupom (cod_cupom, desconto, dt_validade, cpf_assinante) VALUES ('BEMVINDO10', 10, TO_DATE('31/12/2030', 'DD/MM/YYYY'), '33333333333');
INSERT INTO cupom (cod_cupom, desconto, dt_validade, cpf_assinante) VALUES ('VOLTA20', 20, TO_DATE('31/12/2030', 'DD/MM/YYYY'), '55555555555');
INSERT INTO cupom (cod_cupom, desconto, dt_validade, cpf_assinante) VALUES ('CINFLIX50', 50, TO_DATE('30/06/2030', 'DD/MM/YYYY'), '77777777777');
INSERT INTO cupom (cod_cupom, desconto, dt_validade, cpf_assinante) VALUES ('NATAL15', 15, TO_DATE('25/12/2025', 'DD/MM/YYYY'), '88888888888');
INSERT INTO cupom (cod_cupom, desconto, dt_validade, cpf_assinante) VALUES ('FERIAS25', 25, TO_DATE('31/12/2030', 'DD/MM/YYYY'), NULL);
INSERT INTO cupom (cod_cupom, desconto, dt_validade, cpf_assinante) VALUES ('PRIMEIRA5', 5, TO_DATE('31/12/2030', 'DD/MM/YYYY'), NULL);
INSERT INTO cupom (cod_cupom, desconto, dt_validade, cpf_assinante) VALUES ('JUNINO20', 20, TO_DATE('30/06/2025', 'DD/MM/YYYY'), NULL);
INSERT INTO cupom (cod_cupom, desconto, dt_validade, cpf_assinante) VALUES ('EXPIRADO30', 30, TO_DATE('31/12/2024', 'DD/MM/YYYY'), NULL);


-- CONTEÚDOS (superclasse): C001 a C008 são filmes, C009 a C013 são séries

INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C001', 'O Farol de Olinda', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 14);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C002', 'Frevo em Chamas', TO_DATE('12/02/2021', 'DD/MM/YYYY'), 12);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C003', 'Capibaribe Noir', TO_DATE('20/10/2022', 'DD/MM/YYYY'), 16);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C004', 'A Última Jangada', TO_DATE('07/06/2018', 'DD/MM/YYYY'), 10);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C005', 'Robôs do Sertão', TO_DATE('30/11/2023', 'DD/MM/YYYY'), 10);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C006', 'Sextou no Recife', TO_DATE('03/05/2024', 'DD/MM/YYYY'), 12);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C007', 'O Pequeno Caboclinho', TO_DATE('01/07/2022', 'DD/MM/YYYY'), 0);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C008', 'Sombra do Baobá', TO_DATE('18/07/2025', 'DD/MM/YYYY'), 16);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C009', 'Maré Alta', TO_DATE('27/03/2020', 'DD/MM/YYYY'), 14);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C010', 'Agreste Profundo', TO_DATE('10/09/2021', 'DD/MM/YYYY'), 16);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C011', 'Código Caranguejo', TO_DATE('14/04/2023', 'DD/MM/YYYY'), 12);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C012', 'Turma da Ciranda', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 0);
INSERT INTO conteudo (cod_conteudo, titulo, dt_lancamento, classificacao) VALUES ('C013', 'Marco Zero', TO_DATE('21/01/2022', 'DD/MM/YYYY'), 16);


-- GÊNEROS DOS CONTEÚDOS (atributo multivalorado)

INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C001', 'Drama');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C001', 'Suspense');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C002', 'Ação');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C002', 'Comédia');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C003', 'Suspense');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C003', 'Policial');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C004', 'Aventura');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C004', 'Drama');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C005', 'Ficção Científica');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C005', 'Aventura');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C006', 'Comédia');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C007', 'Infantil');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C007', 'Aventura');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C008', 'Terror');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C008', 'Suspense');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C009', 'Drama');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C009', 'Musical');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C010', 'Suspense');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C010', 'Terror');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C011', 'Ficção Científica');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C011', 'Suspense');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C012', 'Infantil');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C012', 'Animação');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C013', 'Policial');
INSERT INTO conteudo_genero (cod_conteudo, genero) VALUES ('C013', 'Drama');


-- FILMES (subclasse)

INSERT INTO filme (cod_conteudo, duracao_min) VALUES ('C001', 118);
INSERT INTO filme (cod_conteudo, duracao_min) VALUES ('C002', 104);
INSERT INTO filme (cod_conteudo, duracao_min) VALUES ('C003', 127);
INSERT INTO filme (cod_conteudo, duracao_min) VALUES ('C004', 96);
INSERT INTO filme (cod_conteudo, duracao_min) VALUES ('C005', 135);
INSERT INTO filme (cod_conteudo, duracao_min) VALUES ('C006', 92);
INSERT INTO filme (cod_conteudo, duracao_min) VALUES ('C007', 84);
INSERT INTO filme (cod_conteudo, duracao_min) VALUES ('C008', 109);


-- SÉRIES (subclasse)

INSERT INTO serie (cod_conteudo, qtd_temporadas) VALUES ('C009', 3);
INSERT INTO serie (cod_conteudo, qtd_temporadas) VALUES ('C010', 2);
INSERT INTO serie (cod_conteudo, qtd_temporadas) VALUES ('C011', 2);
INSERT INTO serie (cod_conteudo, qtd_temporadas) VALUES ('C012', 5);
INSERT INTO serie (cod_conteudo, qtd_temporadas) VALUES ('C013', 4);


-- ARTISTAS (Igor Brandão fica sem atuações de propósito)

INSERT INTO artista (cod_artista, nome, dt_nascimento, nacionalidade) VALUES ('A01', 'Helena Vasconcelos', TO_DATE('14/05/1984', 'DD/MM/YYYY'), 'Brasileira');
INSERT INTO artista (cod_artista, nome, dt_nascimento, nacionalidade) VALUES ('A02', 'Caio Monteiro', TO_DATE('03/10/1990', 'DD/MM/YYYY'), 'Brasileira');
INSERT INTO artista (cod_artista, nome, dt_nascimento, nacionalidade) VALUES ('A03', 'Lia Nascimento', TO_DATE('27/01/1996', 'DD/MM/YYYY'), 'Brasileira');
INSERT INTO artista (cod_artista, nome, dt_nascimento, nacionalidade) VALUES ('A04', 'Rafael Pessoa', TO_DATE('19/08/1975', 'DD/MM/YYYY'), 'Brasileira');
INSERT INTO artista (cod_artista, nome, dt_nascimento, nacionalidade) VALUES ('A05', 'Dandara Reis', TO_DATE('08/12/1989', 'DD/MM/YYYY'), 'Brasileira');
INSERT INTO artista (cod_artista, nome, dt_nascimento, nacionalidade) VALUES ('A06', 'Tomás Ferraz', TO_DATE('30/03/2000', 'DD/MM/YYYY'), 'Portuguesa');
INSERT INTO artista (cod_artista, nome, dt_nascimento, nacionalidade) VALUES ('A07', 'Sofía Méndez', TO_DATE('11/07/1987', 'DD/MM/YYYY'), 'Argentina');
INSERT INTO artista (cod_artista, nome, dt_nascimento, nacionalidade) VALUES ('A08', 'Igor Brandão', TO_DATE('22/11/1993', 'DD/MM/YYYY'), 'Brasileira');


-- ATUAÇÕES (relacionamento N:M / entidade associativa)

INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A01', 'C001', 'Clarice');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A01', 'C009', 'Dona Maré');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A01', 'C013', 'Delegada Rute');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A02', 'C002', 'Zé Faísca');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A02', 'C003', 'Detetive Nilo');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A02', 'C013', 'Investigador Paulo');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A03', 'C001', 'Júlia');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A03', 'C005', 'Engenheira Íris');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A03', 'C011', 'Hacker Tainá');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A04', 'C003', 'Coronel Batista');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A04', 'C004', 'Mestre Severino');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A04', 'C010', 'Padre Anselmo');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A05', 'C002', 'Rainha do Frevo');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A05', 'C006', 'Jéssica');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A05', 'C009', 'Marina');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A06', 'C005', 'Robô Xique');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A06', 'C006', 'Léo');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A07', 'C010', 'Forasteira');
INSERT INTO atua (cod_artista, cod_conteudo, personagem) VALUES ('A07', 'C011', 'Dra. Valentina');


-- PRÊMIOS (o Troféu Sanfona de Ouro nunca foi concedido)

INSERT INTO premio (cod_premio, nome) VALUES ('PR01', 'Troféu Coral de Melhor Atuação');
INSERT INTO premio (cod_premio, nome) VALUES ('PR02', 'Prêmio Aurora de Atuação Coadjuvante');
INSERT INTO premio (cod_premio, nome) VALUES ('PR03', 'Troféu Mangue de Revelação');
INSERT INTO premio (cod_premio, nome) VALUES ('PR04', 'Prêmio do Público');
INSERT INTO premio (cod_premio, nome) VALUES ('PR05', 'Troféu Sanfona de Ouro');


-- PREMIAÇÕES (cada linha aponta para uma atuação que existe em ATUA)

INSERT INTO recebe (cod_artista, cod_conteudo, cod_premio, ano) VALUES ('A01', 'C001', 'PR01', 2020);
INSERT INTO recebe (cod_artista, cod_conteudo, cod_premio, ano) VALUES ('A03', 'C001', 'PR03', 2020);
INSERT INTO recebe (cod_artista, cod_conteudo, cod_premio, ano) VALUES ('A05', 'C009', 'PR04', 2021);
INSERT INTO recebe (cod_artista, cod_conteudo, cod_premio, ano) VALUES ('A01', 'C013', 'PR01', 2022);
INSERT INTO recebe (cod_artista, cod_conteudo, cod_premio, ano) VALUES ('A02', 'C003', 'PR01', 2023);
INSERT INTO recebe (cod_artista, cod_conteudo, cod_premio, ano) VALUES ('A04', 'C003', 'PR02', 2023);
INSERT INTO recebe (cod_artista, cod_conteudo, cod_premio, ano) VALUES ('A03', 'C011', 'PR04', 2024);


-- DISPOSITIVOS (o Videogame nunca foi usado)

INSERT INTO dispositivo (cod_dispositivo, nome, tipo) VALUES ('D01', 'Smart TV', 'TV');
INSERT INTO dispositivo (cod_dispositivo, nome, tipo) VALUES ('D02', 'Celular Android', 'Celular');
INSERT INTO dispositivo (cod_dispositivo, nome, tipo) VALUES ('D03', 'Celular iOS', 'Celular');
INSERT INTO dispositivo (cod_dispositivo, nome, tipo) VALUES ('D04', 'Notebook', 'Computador');
INSERT INTO dispositivo (cod_dispositivo, nome, tipo) VALUES ('D05', 'Tablet', 'Tablet');
INSERT INTO dispositivo (cod_dispositivo, nome, tipo) VALUES ('D06', 'Videogame', 'Console');


-- SESSÕES (relacionamento ternário ASSISTE)
-- o mesmo perfil aparece mais de uma vez com o mesmo conteúdo, em datas diferentes

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('11111111111', 'Ana', 'C001', TO_DATE('05/01/2024', 'DD/MM/YYYY'), 'D01', 118);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('11111111111', 'Ana', 'C003', TO_DATE('12/01/2024', 'DD/MM/YYYY'), 'D01', 127);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('11111111111', 'Ana', 'C009', TO_DATE('01/02/2024', 'DD/MM/YYYY'), 'D02', 45);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('11111111111', 'Ana', 'C009', TO_DATE('02/02/2024', 'DD/MM/YYYY'), 'D02', 50);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('11111111111', 'Ana', 'C013', TO_DATE('10/03/2024', 'DD/MM/YYYY'), 'D01', 55);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('11111111111', 'Kids', 'C007', TO_DATE('06/01/2024', 'DD/MM/YYYY'), 'D05', 84);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('11111111111', 'Kids', 'C012', TO_DATE('07/01/2024', 'DD/MM/YYYY'), 'D05', 22);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('11111111111', 'Kids', 'C012', TO_DATE('08/01/2024', 'DD/MM/YYYY'), 'D05', 44);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('11111111111', 'Visitas', 'C002', TO_DATE('20/07/2024', 'DD/MM/YYYY'), 'D01', 104);

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('22222222222', 'Bruno', 'C003', TO_DATE('10/02/2024', 'DD/MM/YYYY'), 'D04', 127);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('22222222222', 'Bruno', 'C011', TO_DATE('11/02/2024', 'DD/MM/YYYY'), 'D04', 48);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('22222222222', 'Bruno', 'C011', TO_DATE('12/02/2024', 'DD/MM/YYYY'), 'D04', 52);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('22222222222', 'Bruno', 'C005', TO_DATE('15/04/2024', 'DD/MM/YYYY'), 'D01', 135);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('22222222222', 'Lari', 'C006', TO_DATE('10/05/2024', 'DD/MM/YYYY'), 'D03', 92);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('22222222222', 'Lari', 'C009', TO_DATE('12/05/2024', 'DD/MM/YYYY'), 'D03', 47);

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('33333333333', 'Camila', 'C002', TO_DATE('03/03/2024', 'DD/MM/YYYY'), 'D02', 60);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('33333333333', 'Camila', 'C006', TO_DATE('04/05/2024', 'DD/MM/YYYY'), 'D02', 92);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('33333333333', 'Camila', 'C010', TO_DATE('15/06/2024', 'DD/MM/YYYY'), 'D02', 51);

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('44444444444', 'Diego', 'C004', TO_DATE('20/01/2024', 'DD/MM/YYYY'), 'D01', 96);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('44444444444', 'Diego', 'C013', TO_DATE('25/02/2024', 'DD/MM/YYYY'), 'D01', 58);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('44444444444', 'Diego', 'C013', TO_DATE('26/02/2024', 'DD/MM/YYYY'), 'D01', 61);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('44444444444', 'Kids', 'C012', TO_DATE('01/03/2024', 'DD/MM/YYYY'), 'D01', 66);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('44444444444', 'Kids', 'C007', TO_DATE('02/03/2024', 'DD/MM/YYYY'), 'D05', 84);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('44444444444', 'Kids', 'C005', TO_DATE('09/03/2024', 'DD/MM/YYYY'), 'D01', 135);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('44444444444', 'Vovó', 'C004', TO_DATE('07/04/2024', 'DD/MM/YYYY'), 'D01', 96);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('44444444444', 'Vovó', 'C009', TO_DATE('08/04/2024', 'DD/MM/YYYY'), 'D01', 49);

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('55555555555', 'Elisa', 'C001', TO_DATE('14/02/2024', 'DD/MM/YYYY'), 'D04', 118);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('55555555555', 'Elisa', 'C010', TO_DATE('01/07/2024', 'DD/MM/YYYY'), 'D03', 49);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('55555555555', 'Elisa', 'C010', TO_DATE('02/07/2024', 'DD/MM/YYYY'), 'D03', 53);

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('66666666666', 'Felipe', 'C005', TO_DATE('01/04/2024', 'DD/MM/YYYY'), 'D01', 135);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('66666666666', 'Felipe', 'C011', TO_DATE('20/04/2024', 'DD/MM/YYYY'), 'D02', 50);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('66666666666', 'Felipe', 'C003', TO_DATE('09/08/2024', 'DD/MM/YYYY'), 'D01', 127);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('66666666666', 'Kids', 'C012', TO_DATE('05/05/2024', 'DD/MM/YYYY'), 'D05', 44);

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('77777777777', 'Gabi', 'C006', TO_DATE('07/07/2024', 'DD/MM/YYYY'), 'D02', 92);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('77777777777', 'Gabi', 'C002', TO_DATE('08/07/2024', 'DD/MM/YYYY'), 'D02', 104);

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('88888888888', 'Heitor', 'C013', TO_DATE('01/10/2024', 'DD/MM/YYYY'), 'D04', 57);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('88888888888', 'Heitor', 'C001', TO_DATE('05/10/2024', 'DD/MM/YYYY'), 'D01', 118);

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('99999999999', 'Isa', 'C011', TO_DATE('10/02/2025', 'DD/MM/YYYY'), 'D03', 51);
INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos) VALUES ('99999999999', 'Isa', 'C009', TO_DATE('15/02/2025', 'DD/MM/YYYY'), 'D03', 46);


-- ---------------------------------------------------------------------
-- EXEMPLOS DE UPDATE E DELETE
-- ---------------------------------------------------------------------

-- UPDATE: reajuste de 10% no preço do plano Universitário (14,90 -> 16,39)

UPDATE plano
SET preco = ROUND(preco * 1.10, 2)
WHERE cod_plano = 'P05';

-- DELETE: remove os cupons vencidos antes de 2025 que nunca foram resgatados
-- (apaga apenas o cupom EXPIRADO30)

DELETE FROM cupom
WHERE cpf_assinante IS NULL
  AND dt_validade < TO_DATE('01/01/2025', 'DD/MM/YYYY');

COMMIT;
