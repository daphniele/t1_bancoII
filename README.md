# Trabalho Prático - LOG - BDII
**Estudante: Daniele Rohr**

O objetivo desse trabalho de Banco de Dados II é simular o funcionamento do log Redo utilizando o SGBD (Postgres).

## Descrição da atividade

- Uma tabela em memória é criada no banco e algumas operações de insert e update serão simuladas;
- Uma tabela normal armazena as operações realizadas na tabela em memória;
- Após a queda do sistema, a tabela de log é processada para materializar as operações a partir do mecanismo de REDO.

## Implementação

O trabalho foi desenvolvido em duas etapas:
  - Adaptação do script de criação das tabelas no banco e criação de um trigger e duas funções para armazenar as informações na tabela de log (o trigger insere as operações comitadas e as funções marcam o começo e o fim das transações);
  - Feito isso, foi desenvolvido um programa em Python que:
            - conecta com o banco e lê a tabela de log;
            - procura pelas transações que aconteceram (finalizadas e não finalizadas);
            - refaz na tabela de clientes as operações que finalizaram;
            - imprime o número das transações que sofreram REDO e das que não sofreram.   

## Para rodar
- É necessário ter instaladas as seguintes dependências:
  - Python 3.x
  - Postgres 16.x
- É necessária a instalação do pacote psycopg2: **pip install psycopg2**
- É necessária a criação das tabelas, funções, trigger e inserção dos dados de entrada, conforme arquivos .sql disponíveis nesse repositório
- Tendo seguido todos os passos anteriores, é possível rodar o projeto através do comando: **python3 main.py**
