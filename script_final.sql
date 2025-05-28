-- criação das tabelas

CREATE UNLOGGED TABLE clientes_em_memoria (
  id SERIAL PRIMARY KEY,
  nome TEXT,
  saldo NUMERIC
);

CREATE TABLE log (id_operacao BIGINT, operacao TEXT, id_cliente INT, nome TEXT, saldo NUMERIC);


-- inserção de dados

SELECT insere_begin();
BEGIN;
INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 1', 100.00);
UPDATE clientes_em_memoria SET saldo = saldo + 50 WHERE id = 1;
END;
SELECT insere_end();

SELECT insere_begin();
BEGIN;
INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 2', 200.00);
UPDATE clientes_em_memoria SET saldo = saldo + 50 WHERE id = 2;
END;
SELECT insere_end();

SELECT insere_begin();
BEGIN;
INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 3', 300.00);
UPDATE clientes_em_memoria SET saldo = saldo + 50 WHERE id = 2;
END;
SELECT insere_end();

SELECT insere_begin();
BEGIN;
INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 4', 400.00);
UPDATE clientes_em_memoria SET saldo = saldo + 50 WHERE id = 3;

SELECT insere_begin();
BEGIN;
INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 6', 600.00); 

