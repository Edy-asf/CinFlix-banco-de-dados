# CInFlix — banco de dados de uma plataforma de streaming

Projeto da disciplina de banco de dados: modelo conceitual (EER), modelo relacional e projeto físico em Oracle (DDL, DML, consultas e PL/SQL).

**Equipe:** Edivaldo Ambrozio da Silva Filho, Marcos Antônio Mendes de Amorim, Erick Barros da Silva, Pedro Lucas da Silva Lucena, Iago Lopes da Silva.

## Minimundo

A CInFlix é uma plataforma fictícia de streaming de filmes e séries.

1. **Planos.** Cada plano tem código, nome, preço mensal e quantidade máxima de telas.
2. **Assinantes.** Identificados pelo CPF, têm nome, data de nascimento e endereço (cidade e UF). Todo assinante assina exatamente um plano, e guarda-se a data de adesão.
3. **Indicações.** Um assinante pode ter sido indicado por outro assinante, no máximo um, e pode indicar vários.
4. **Perfis.** Cada assinante cria perfis na sua conta. O nome do perfil só o identifica dentro da conta. Guarda-se a data de criação e se o perfil é infantil.
5. **Cupons.** Cada cupom tem código, percentual de desconto e validade. Um cupom é resgatado por no máximo um assinante, e cada assinante resgata no máximo um cupom.
6. **Conteúdos.** Têm código, título, data de lançamento, classificação indicativa e um ou mais gêneros. Todo conteúdo é um filme (duração) ou uma série (temporadas), nunca os dois.
7. **Artistas.** Têm código, nome, data de nascimento e nacionalidade. Atuam em vários conteúdos, e em cada atuação guarda-se o personagem.
8. **Prêmios.** Um prêmio é concedido a uma atuação (um artista em um conteúdo), em um ano.
9. **Sessões.** Um perfil assiste a um conteúdo em um dispositivo. Guardam-se a data e os minutos. Perfis infantis só assistem a conteúdos de classificação livre ou de 10 anos.

## Estrutura

| Pasta | Arquivo | Conteúdo |
|---|---|---|
| `Projeto Conceitual` | `ModeloEER.png`, `ModeloEER.pdf` | Diagrama EER |
| | `ModeloEER.eer` | O mesmo modelo no formato do EERCASE |
| `Projeto Lógico` | `Mapeamento EER-Relacional.pdf` | Esquema relacional e decisões de mapeamento |
| `Projeto Físico` | `0 - Limpeza (opcional).sql` | Apaga tudo, para recriar do zero |
| | `1 - Scripts Tabela.sql` | Criação das 14 tabelas |
| | `2 - Scripts Povoamento.sql` | Dados fictícios, mais um `UPDATE` e um `DELETE` |
| | `3 - Consultas.sql` | 19 consultas, cobrindo os nove tipos exigidos |
| | `4 - PL-SQL.sql` | Duas funções, dois procedimentos e três gatilhos, com testes |
| raiz | `Relatório do Projeto.pdf` | Minimundo, diagrama, checklists, mapeamento e resumo dos scripts |

## Checklist do modelo conceitual

| Conceito | Onde aparece |
|---|---|
| Atributo composto | `endereco` (cidade, uf) de Assinante |
| Atributo multivalorado | `genero` de Conteudo |
| Atributo discriminador em relacionamento | `dt_sessao` em assiste |
| Relacionamento 1:1 | resgata (Assinante e Cupom) |
| Relacionamento 1:N | assina (Plano e Assinante), possui, indica |
| Relacionamento N:M | atua (Artista e Conteudo), recebe |
| Relacionamento parcial-total | assina: Plano parcial, Assinante total |
| Relacionamento parcial-parcial | resgata, indica, atua |
| Relacionamento unário | indica (Assinante indicador e indicado) |
| Relacionamento identificador e entidade fraca | possui e Perfil |
| Relacionamento binário | assina, resgata, possui, atua, recebe |
| Relacionamento n-ário | assiste (Perfil, Conteudo e Dispositivo) |
| Entidade associativa | atua, ligada a Premio por recebe |
| Herança | Conteudo em Filme e Serie (disjunta e total) |

## Checklist das consultas

| Tipo | Consultas |
|---|---|
| Group by / Having | 1.1 e 1.2 |
| Junção interna | 2.1 e 2.2 |
| Junção externa | 3.1 (`LEFT`) e 3.2 (`FULL`) |
| Semi-junção | 4.1 (`EXISTS`) e 4.2 (`IN`) |
| Anti-junção | 5.1 (`NOT EXISTS`) e 5.2 (`NOT IN`) |
| Subconsulta escalar | 6.1 e 6.2 |
| Subconsulta de linha | 7.1 e 7.2 |
| Subconsulta de tabela | 8.1 e 8.2 |
| Operação de conjunto | 9.1 (`UNION`), 9.2 (`INTERSECT`) e 9.3 (`MINUS`) |

PL/SQL: funções `valor_mensalidade` e `horas_assistidas`, procedimentos `historico_perfil` e `resgatar_cupom`, gatilhos `trg_filme_disjuncao`, `trg_serie_disjuncao` e `trg_assiste_infantil`.

## Como executar

1. Abra o Oracle Live SQL, o SQL Developer ou o SQL*Plus.
2. Execute os scripts de `Projeto Físico` na ordem dos números: 1, 2, 3 e 4. O script 0 só é necessário para recomeçar do zero.
3. No script 4, os testes marcados com "deve falhar" devolvem de propósito os erros `ORA-20001` a `ORA-20015`, que são as mensagens dos gatilhos e do procedimento `resgatar_cupom`.
