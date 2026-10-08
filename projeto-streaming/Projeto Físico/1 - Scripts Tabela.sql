-- =====================================================================
-- CINFLIX - PLATAFORMA DE STREAMING DE FILMES E SÉRIES
-- Projeto físico: criação das tabelas (DDL) - Oracle
--
-- A ordem de criação respeita as dependências de chave estrangeira.
-- Para recriar o banco do zero, rode antes "0 - Limpeza (opcional).sql".
-- =====================================================================


-- CRIA TABELA PLANO (entidade)

CREATE TABLE plano (

    cod_plano  VARCHAR2(5),
    nome       VARCHAR2(30) CONSTRAINT nn_plano_nome NOT NULL,
    preco      NUMBER(6,2)  CONSTRAINT nn_plano_preco NOT NULL,
    max_telas  NUMBER(2)    CONSTRAINT nn_plano_telas NOT NULL,
    CONSTRAINT pk_plano PRIMARY KEY (cod_plano),
    CONSTRAINT uq_plano_nome UNIQUE (nome),
    CONSTRAINT ck_plano_preco CHECK (preco > 0),
    CONSTRAINT ck_plano_telas CHECK (max_telas BETWEEN 1 AND 10)

);


-- CRIA TABELA ASSINANTE (entidade)
-- end_cidade e end_uf: atributo composto ENDERECO
-- cod_plano e dt_adesao: relacionamento ASSINA (1:N, assinante total)
-- cpf_indicador: auto-relacionamento INDICA (1:N, parcial dos dois lados)

CREATE TABLE assinante (

    cpf            VARCHAR2(11),
    nome           VARCHAR2(50) CONSTRAINT nn_assinante_nome NOT NULL,
    dt_nascimento  DATE         CONSTRAINT nn_assinante_nasc NOT NULL,
    end_cidade     VARCHAR2(30) CONSTRAINT nn_assinante_cidade NOT NULL,
    end_uf         VARCHAR2(2)  CONSTRAINT nn_assinante_uf NOT NULL,
    cod_plano      VARCHAR2(5)  CONSTRAINT nn_assinante_plano NOT NULL,
    dt_adesao      DATE         CONSTRAINT nn_assinante_adesao NOT NULL,
    cpf_indicador  VARCHAR2(11),
    CONSTRAINT pk_assinante PRIMARY KEY (cpf),
    CONSTRAINT fk_assinante_plano FOREIGN KEY (cod_plano) REFERENCES plano (cod_plano),
    CONSTRAINT fk_assinante_indicador FOREIGN KEY (cpf_indicador) REFERENCES assinante (cpf),
    CONSTRAINT ck_assinante_indicador CHECK (cpf_indicador <> cpf)

);


-- CRIA TABELA PERFIL (entidade fraca de ASSINANTE)
-- nome_perfil é o discriminador: só identifica o perfil dentro do assinante

CREATE TABLE perfil (

    cpf          VARCHAR2(11),
    nome_perfil  VARCHAR2(20),
    dt_criacao   DATE    CONSTRAINT nn_perfil_criacao NOT NULL,
    infantil     CHAR(1) CONSTRAINT nn_perfil_infantil NOT NULL,
    CONSTRAINT pk_perfil PRIMARY KEY (cpf, nome_perfil),
    CONSTRAINT fk_perfil_assinante FOREIGN KEY (cpf) REFERENCES assinante (cpf) ON DELETE CASCADE,
    CONSTRAINT ck_perfil_infantil CHECK (infantil IN ('S', 'N'))

);


-- CRIA TABELA CUPOM (entidade)
-- cpf_assinante: relacionamento RESGATA (1:1, parcial dos dois lados)
-- a FK é única (1:1) e aceita nulo (cupom ainda não resgatado)

CREATE TABLE cupom (

    cod_cupom      VARCHAR2(10),
    desconto       NUMBER(3) CONSTRAINT nn_cupom_desconto NOT NULL,
    dt_validade    DATE      CONSTRAINT nn_cupom_validade NOT NULL,
    cpf_assinante  VARCHAR2(11),
    CONSTRAINT pk_cupom PRIMARY KEY (cod_cupom),
    CONSTRAINT uq_cupom_assinante UNIQUE (cpf_assinante),
    CONSTRAINT fk_cupom_assinante FOREIGN KEY (cpf_assinante) REFERENCES assinante (cpf),
    CONSTRAINT ck_cupom_desconto CHECK (desconto BETWEEN 1 AND 100)

);


-- CRIA TABELA CONTEUDO (superclasse da herança)

CREATE TABLE conteudo (

    cod_conteudo   VARCHAR2(5),
    titulo         VARCHAR2(60) CONSTRAINT nn_conteudo_titulo NOT NULL,
    dt_lancamento  DATE         CONSTRAINT nn_conteudo_lancamento NOT NULL,
    classificacao  NUMBER(2)    CONSTRAINT nn_conteudo_classif NOT NULL,
    CONSTRAINT pk_conteudo PRIMARY KEY (cod_conteudo),
    CONSTRAINT ck_conteudo_classif CHECK (classificacao IN (0, 10, 12, 14, 16, 18))

);


-- CRIA TABELA CONTEUDO_GENERO (atributo multivalorado GENERO de CONTEUDO)

CREATE TABLE conteudo_genero (

    cod_conteudo  VARCHAR2(5),
    genero        VARCHAR2(20),
    CONSTRAINT pk_conteudo_genero PRIMARY KEY (cod_conteudo, genero),
    CONSTRAINT fk_genero_conteudo FOREIGN KEY (cod_conteudo) REFERENCES conteudo (cod_conteudo) ON DELETE CASCADE

);


-- CRIA TABELA FILME (subclasse de CONTEUDO)

CREATE TABLE filme (

    cod_conteudo  VARCHAR2(5),
    duracao_min   NUMBER(3) CONSTRAINT nn_filme_duracao NOT NULL,
    CONSTRAINT pk_filme PRIMARY KEY (cod_conteudo),
    CONSTRAINT fk_filme_conteudo FOREIGN KEY (cod_conteudo) REFERENCES conteudo (cod_conteudo),
    CONSTRAINT ck_filme_duracao CHECK (duracao_min > 0)

);


-- CRIA TABELA SERIE (subclasse de CONTEUDO)

CREATE TABLE serie (

    cod_conteudo    VARCHAR2(5),
    qtd_temporadas  NUMBER(2) CONSTRAINT nn_serie_temporadas NOT NULL,
    CONSTRAINT pk_serie PRIMARY KEY (cod_conteudo),
    CONSTRAINT fk_serie_conteudo FOREIGN KEY (cod_conteudo) REFERENCES conteudo (cod_conteudo),
    CONSTRAINT ck_serie_temporadas CHECK (qtd_temporadas > 0)

);


-- CRIA TABELA ARTISTA (entidade)

CREATE TABLE artista (

    cod_artista    VARCHAR2(5),
    nome           VARCHAR2(50) CONSTRAINT nn_artista_nome NOT NULL,
    dt_nascimento  DATE         CONSTRAINT nn_artista_nasc NOT NULL,
    nacionalidade  VARCHAR2(30) CONSTRAINT nn_artista_nacional NOT NULL,
    CONSTRAINT pk_artista PRIMARY KEY (cod_artista)

);


-- CRIA TABELA ATUA (relacionamento N:M entre ARTISTA e CONTEUDO)
-- é a ENTIDADE ASSOCIATIVA do modelo: o relacionamento RECEBE se liga a ela

CREATE TABLE atua (

    cod_artista   VARCHAR2(5),
    cod_conteudo  VARCHAR2(5),
    personagem    VARCHAR2(40) CONSTRAINT nn_atua_personagem NOT NULL,
    CONSTRAINT pk_atua PRIMARY KEY (cod_artista, cod_conteudo),
    CONSTRAINT fk_atua_artista FOREIGN KEY (cod_artista) REFERENCES artista (cod_artista),
    CONSTRAINT fk_atua_conteudo FOREIGN KEY (cod_conteudo) REFERENCES conteudo (cod_conteudo)

);


-- CRIA TABELA PREMIO (entidade)

CREATE TABLE premio (

    cod_premio  VARCHAR2(5),
    nome        VARCHAR2(60) CONSTRAINT nn_premio_nome NOT NULL,
    CONSTRAINT pk_premio PRIMARY KEY (cod_premio)

);


-- CRIA TABELA RECEBE (relacionamento N:M entre a entidade associativa ATUA e PREMIO)
-- a FK composta aponta para ATUA: só uma atuação que existe pode ser premiada

CREATE TABLE recebe (

    cod_artista   VARCHAR2(5),
    cod_conteudo  VARCHAR2(5),
    cod_premio    VARCHAR2(5),
    ano           NUMBER(4) CONSTRAINT nn_recebe_ano NOT NULL,
    CONSTRAINT pk_recebe PRIMARY KEY (cod_artista, cod_conteudo, cod_premio),
    CONSTRAINT fk_recebe_atua FOREIGN KEY (cod_artista, cod_conteudo) REFERENCES atua (cod_artista, cod_conteudo),
    CONSTRAINT fk_recebe_premio FOREIGN KEY (cod_premio) REFERENCES premio (cod_premio),
    CONSTRAINT ck_recebe_ano CHECK (ano >= 1900)

);


-- CRIA TABELA DISPOSITIVO (entidade)

CREATE TABLE dispositivo (

    cod_dispositivo  VARCHAR2(5),
    nome             VARCHAR2(30) CONSTRAINT nn_dispositivo_nome NOT NULL,
    tipo             VARCHAR2(20) CONSTRAINT nn_dispositivo_tipo NOT NULL,
    CONSTRAINT pk_dispositivo PRIMARY KEY (cod_dispositivo)

);


-- CRIA TABELA ASSISTE (relacionamento ternário PERFIL x CONTEUDO x DISPOSITIVO)
-- dt_sessao é o atributo discriminador: o mesmo perfil pode assistir ao mesmo
-- conteúdo em vários dias. Como cada sessão acontece em um único dispositivo
-- (cardinalidade 1), cod_dispositivo fica fora da chave primária e é obrigatório.

CREATE TABLE assiste (

    cpf              VARCHAR2(11),
    nome_perfil      VARCHAR2(20),
    cod_conteudo     VARCHAR2(5),
    dt_sessao        DATE,
    cod_dispositivo  VARCHAR2(5) CONSTRAINT nn_assiste_dispositivo NOT NULL,
    minutos          NUMBER(4)   CONSTRAINT nn_assiste_minutos NOT NULL,
    CONSTRAINT pk_assiste PRIMARY KEY (cpf, nome_perfil, cod_conteudo, dt_sessao),
    CONSTRAINT fk_assiste_perfil FOREIGN KEY (cpf, nome_perfil) REFERENCES perfil (cpf, nome_perfil) ON DELETE CASCADE,
    CONSTRAINT fk_assiste_conteudo FOREIGN KEY (cod_conteudo) REFERENCES conteudo (cod_conteudo),
    CONSTRAINT fk_assiste_dispositivo FOREIGN KEY (cod_dispositivo) REFERENCES dispositivo (cod_dispositivo),
    CONSTRAINT ck_assiste_minutos CHECK (minutos > 0)

);
