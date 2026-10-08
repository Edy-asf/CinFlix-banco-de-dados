-- =====================================================================
-- CINFLIX - LIMPEZA DO BANCO 
-- Rode este script apenas quando quiser recriar tudo do zero.
-- Na primeira execução as tabelas ainda não existem, então não é preciso.
-- A ordem é a inversa da criação (quem referencia é apagado primeiro).
-- =====================================================================

DROP TABLE assiste CASCADE CONSTRAINTS;
DROP TABLE dispositivo CASCADE CONSTRAINTS;
DROP TABLE recebe CASCADE CONSTRAINTS;
DROP TABLE premio CASCADE CONSTRAINTS;
DROP TABLE atua CASCADE CONSTRAINTS;
DROP TABLE artista CASCADE CONSTRAINTS;
DROP TABLE serie CASCADE CONSTRAINTS;
DROP TABLE filme CASCADE CONSTRAINTS;
DROP TABLE conteudo_genero CASCADE CONSTRAINTS;
DROP TABLE conteudo CASCADE CONSTRAINTS;
DROP TABLE cupom CASCADE CONSTRAINTS;
DROP TABLE perfil CASCADE CONSTRAINTS;
DROP TABLE assinante CASCADE CONSTRAINTS;
DROP TABLE plano CASCADE CONSTRAINTS;

DROP PROCEDURE historico_perfil;
DROP PROCEDURE resgatar_cupom;
DROP FUNCTION valor_mensalidade;
DROP FUNCTION horas_assistidas;
