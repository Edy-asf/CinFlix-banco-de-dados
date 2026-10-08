-- =====================================================================
-- CINFLIX - PLATAFORMA DE STREAMING DE FILMES E SÉRIES
-- Projeto físico: PL/SQL (funções, procedimentos e gatilhos) - Oracle
--
--   Funções com SQL embutida e parâmetro ....... valor_mensalidade, horas_assistidas
--   Procedimentos com SQL embutida e parâmetro . historico_perfil, resgatar_cupom
--   Gatilhos ................................... trg_filme_disjuncao, trg_serie_disjuncao,
--                                                trg_assiste_infantil
--
-- Cada bloco termina com uma barra (/) sozinha na linha.
-- Depois de cada objeto há um teste com o resultado esperado.
-- =====================================================================

-- Necessário no SQL*Plus e no SQL Developer para exibir o DBMS_OUTPUT.
-- No Oracle Live SQL a saída já aparece: se a linha der aviso, pode apagá-la.
SET SERVEROUTPUT ON


-----------------------------------------------------------------------
-- FUNÇÃO 1: valor_mensalidade
-- Devolve quanto o assinante paga por mês: o preço do plano com o
-- desconto do cupom resgatado, se houver. CPF não cadastrado devolve NULL.
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION valor_mensalidade (
    p_cpf  IN assinante.cpf%TYPE
) RETURN NUMBER IS

    v_preco     plano.preco%TYPE;
    v_desconto  NUMBER;

BEGIN

    SELECT p.preco, NVL(c.desconto, 0)
    INTO v_preco, v_desconto
    FROM assinante a
    INNER JOIN plano p ON p.cod_plano = a.cod_plano
    LEFT OUTER JOIN cupom c ON c.cpf_assinante = a.cpf
    WHERE a.cpf = p_cpf;

    RETURN ROUND(v_preco * (1 - v_desconto / 100), 2);

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        RETURN NULL;

END;
/

-- Teste: Camila assina o Básico (19,90) e resgatou 10% de desconto
-- Resultado: 17,91

SELECT valor_mensalidade('33333333333') AS mensalidade
FROM dual;

-- Teste: mensalidade de todos os assinantes
-- Resultado: Ana 49,90; Bruno 34,90; Camila 17,91; Diego 59,90; Elisa 27,92;
--            Felipe 49,90; Gabriela 9,95; Heitor 29,67; Isabela 49,90

SELECT a.nome,
       valor_mensalidade(a.cpf) AS mensalidade
FROM assinante a
ORDER BY a.nome;


-----------------------------------------------------------------------
-- FUNÇÃO 2: horas_assistidas
-- Devolve o total de horas assistidas por um assinante, somando todos
-- os seus perfis. Quem nunca assistiu a nada recebe 0.
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION horas_assistidas (
    p_cpf  IN assinante.cpf%TYPE
) RETURN NUMBER IS

    v_minutos  NUMBER;

BEGIN

    SELECT NVL(SUM(s.minutos), 0)
    INTO v_minutos
    FROM assiste s
    WHERE s.cpf = p_cpf;

    RETURN ROUND(v_minutos / 60, 1);

END;
/

-- Teste: Diego soma 645 minutos nos seus perfis
-- Resultado: 10,8

SELECT horas_assistidas('44444444444') AS horas
FROM dual;


-----------------------------------------------------------------------
-- PROCEDIMENTO 1: historico_perfil
-- Imprime o histórico de um perfil (data, conteúdo, dispositivo e minutos)
-- e, no final, a quantidade de sessões e o total de minutos.
-----------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE historico_perfil (
    p_cpf          IN perfil.cpf%TYPE,
    p_nome_perfil  IN perfil.nome_perfil%TYPE
) IS

    CURSOR c_sessoes IS
        SELECT a.dt_sessao,
               c.titulo,
               d.nome AS aparelho,
               a.minutos
        FROM assiste a
        INNER JOIN conteudo c ON c.cod_conteudo = a.cod_conteudo
        INNER JOIN dispositivo d ON d.cod_dispositivo = a.cod_dispositivo
        WHERE a.cpf = p_cpf
          AND a.nome_perfil = p_nome_perfil
        ORDER BY a.dt_sessao;

    v_sessao  c_sessoes%ROWTYPE;
    v_existe  NUMBER;
    v_total   NUMBER := 0;

BEGIN

    SELECT COUNT(*)
    INTO v_existe
    FROM perfil
    WHERE cpf = p_cpf
      AND nome_perfil = p_nome_perfil;

    IF v_existe = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Perfil não encontrado.');
        RETURN;
    END IF;

    OPEN c_sessoes;

    LOOP

        FETCH c_sessoes INTO v_sessao;
        EXIT WHEN c_sessoes%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_sessao.dt_sessao, 'DD/MM/YYYY') || ' - ' || v_sessao.titulo
                             || ' - ' || v_sessao.aparelho || ' - ' || v_sessao.minutos || ' min');

        v_total := v_total + v_sessao.minutos;

    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Sessões: ' || c_sessoes%ROWCOUNT || ' | Total: ' || v_total || ' min');

    CLOSE c_sessoes;

END;
/

-- Teste: histórico do perfil Ana, da assinante Ana Beatriz
-- Resultado: 5 linhas de sessão e "Sessões: 5 | Total: 395 min"

BEGIN

    historico_perfil('11111111111', 'Ana');

END;
/


-----------------------------------------------------------------------
-- PROCEDIMENTO 2: resgatar_cupom
-- Liga um cupom a um assinante, validando as regras do resgate:
-- assinante e cupom precisam existir, o cupom não pode ter dono nem
-- estar vencido, e o assinante não pode ter outro cupom (1:1).
-----------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE resgatar_cupom (
    p_cpf        IN assinante.cpf%TYPE,
    p_cod_cupom  IN cupom.cod_cupom%TYPE
) IS

    v_qtd       NUMBER;
    v_validade  cupom.dt_validade%TYPE;
    v_dono      cupom.cpf_assinante%TYPE;

BEGIN

    SELECT COUNT(*)
    INTO v_qtd
    FROM assinante
    WHERE cpf = p_cpf;

    IF v_qtd = 0 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Assinante não cadastrado.');
    END IF;

    BEGIN

        SELECT dt_validade, cpf_assinante
        INTO v_validade, v_dono
        FROM cupom
        WHERE cod_cupom = p_cod_cupom;

    EXCEPTION

        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20012, 'Cupom inexistente.');

    END;

    IF v_dono IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20013, 'Este cupom já foi resgatado.');
    END IF;

    IF v_validade < TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20014, 'Cupom vencido em ' || TO_CHAR(v_validade, 'DD/MM/YYYY') || '.');
    END IF;

    SELECT COUNT(*)
    INTO v_qtd
    FROM cupom
    WHERE cpf_assinante = p_cpf;

    IF v_qtd > 0 THEN
        RAISE_APPLICATION_ERROR(-20015, 'O assinante já resgatou um cupom.');
    END IF;

    UPDATE cupom
    SET cpf_assinante = p_cpf
    WHERE cod_cupom = p_cod_cupom;

    DBMS_OUTPUT.PUT_LINE('Cupom ' || p_cod_cupom || ' resgatado. Nova mensalidade: R$ '
                         || TO_CHAR(valor_mensalidade(p_cpf), 'FM990.00'));

END;
/

-- Teste 1: Diego (plano Família, 59,90) resgata 25% de desconto
-- Resultado: "Cupom FERIAS25 resgatado. Nova mensalidade: R$ 44.93"

BEGIN

    resgatar_cupom('44444444444', 'FERIAS25');

END;
/

-- Teste 2 (deve falhar): Diego tenta resgatar um segundo cupom
-- Resultado: ORA-20015: O assinante já resgatou um cupom.

BEGIN

    resgatar_cupom('44444444444', 'PRIMEIRA5');

END;
/

-- Teste 3 (deve falhar): cupom com validade vencida
-- Resultado: ORA-20014: Cupom vencido em 30/06/2025.

BEGIN

    resgatar_cupom('11111111111', 'JUNINO20');

END;
/

-- Desfaz o teste 1, para os dados voltarem ao estado do povoamento

UPDATE cupom
SET cpf_assinante = NULL
WHERE cod_cupom = 'FERIAS25';

COMMIT;


-----------------------------------------------------------------------
-- GATILHOS 1 e 2: trg_filme_disjuncao e trg_serie_disjuncao
-- A herança de CONTEUDO é disjunta: um conteúdo não pode ser filme e
-- série ao mesmo tempo. As chaves não conseguem garantir isso, então
-- cada gatilho consulta a tabela da outra subclasse antes de gravar.
-----------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trg_filme_disjuncao
BEFORE INSERT OR UPDATE OF cod_conteudo ON filme
FOR EACH ROW
DECLARE

    v_qtd  NUMBER;

BEGIN

    SELECT COUNT(*)
    INTO v_qtd
    FROM serie
    WHERE cod_conteudo = :NEW.cod_conteudo;

    IF v_qtd > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'O conteúdo ' || :NEW.cod_conteudo || ' já está cadastrado como série.');
    END IF;

END;
/

CREATE OR REPLACE TRIGGER trg_serie_disjuncao
BEFORE INSERT OR UPDATE OF cod_conteudo ON serie
FOR EACH ROW
DECLARE

    v_qtd  NUMBER;

BEGIN

    SELECT COUNT(*)
    INTO v_qtd
    FROM filme
    WHERE cod_conteudo = :NEW.cod_conteudo;

    IF v_qtd > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'O conteúdo ' || :NEW.cod_conteudo || ' já está cadastrado como filme.');
    END IF;

END;
/

-- Teste (deve falhar): C009 (Maré Alta) é uma série
-- Resultado: ORA-20001: O conteúdo C009 já está cadastrado como série.

INSERT INTO filme (cod_conteudo, duracao_min) VALUES ('C009', 100);

-- Teste (deve falhar): C001 (O Farol de Olinda) é um filme
-- Resultado: ORA-20002: O conteúdo C001 já está cadastrado como filme.

INSERT INTO serie (cod_conteudo, qtd_temporadas) VALUES ('C001', 1);


-----------------------------------------------------------------------
-- GATILHO 3: trg_assiste_infantil
-- Um perfil infantil só pode assistir a conteúdos com classificação
-- indicativa livre (0) ou 10 anos.
-----------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trg_assiste_infantil
BEFORE INSERT OR UPDATE ON assiste
FOR EACH ROW
DECLARE

    v_qtd  NUMBER;

BEGIN

    SELECT COUNT(*)
    INTO v_qtd
    FROM perfil p
    CROSS JOIN conteudo c
    WHERE p.cpf = :NEW.cpf
      AND p.nome_perfil = :NEW.nome_perfil
      AND p.infantil = 'S'
      AND c.cod_conteudo = :NEW.cod_conteudo
      AND c.classificacao > 10;

    IF v_qtd > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Perfil infantil não pode assistir a conteúdo com classificação acima de 10 anos.');
    END IF;

END;
/

-- Teste (deve falhar): perfil Kids tentando assistir a Capibaribe Noir (16 anos)
-- Resultado: ORA-20003: Perfil infantil não pode assistir a conteúdo com classificação acima de 10 anos.

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos)
VALUES ('11111111111', 'Kids', 'C003', TO_DATE('01/09/2025', 'DD/MM/YYYY'), 'D05', 30);

-- Teste (deve funcionar): o mesmo perfil assistindo a A Última Jangada (10 anos)
-- Resultado: 1 linha inserida

INSERT INTO assiste (cpf, nome_perfil, cod_conteudo, dt_sessao, cod_dispositivo, minutos)
VALUES ('11111111111', 'Kids', 'C004', TO_DATE('01/09/2025', 'DD/MM/YYYY'), 'D05', 96);

-- Desfaz o teste, para os dados voltarem ao estado do povoamento

DELETE FROM assiste
WHERE cpf = '11111111111'
  AND nome_perfil = 'Kids'
  AND cod_conteudo = 'C004'
  AND dt_sessao = TO_DATE('01/09/2025', 'DD/MM/YYYY');

COMMIT;
