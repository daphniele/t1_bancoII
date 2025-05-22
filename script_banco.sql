
CREATE UNLOGGED TABLE clientes_em_memoria (
  id SERIAL PRIMARY KEY,
  nome TEXT,
  saldo NUMERIC
);

CREATE TABLE log (id_operacao BIGINT, operacao TEXT, id_cliente INT, nome TEXT, saldo NUMERIC);


BEGIN;
insert into log (id_operacao, operacao) values (txid_current(), 'begin');

INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 1', 100.00);
UPDATE clientes_em_memoria SET saldo = saldo + 50 WHERE id = 1;

insert into log (id_operacao, operacao) values (txid_current(), 'end');
END;

BEGIN;

insert into log (id_operacao, operacao) values (txid_current(), 'begin');

INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 2', 200.00);
UPDATE clientes_em_memoria SET saldo = saldo + 50 WHERE id = 2;
insert into log (id_operacao, operacao) values (txid_current(), 'end');

END;

BEGIN;
insert into log (id_operacao, operacao) values (txid_current(), 'begin');

INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 3', 300.00);
UPDATE clientes_em_memoria SET saldo = saldo + 50 WHERE id = 2;
insert into log (id_operacao, operacao) values (txid_current(), 'end');

END;

BEGIN;
insert into log (id_operacao, operacao) values (txid_current(), 'begin');

INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 4', 400.00);
UPDATE clientes_em_memoria SET saldo = saldo + 50 WHERE id = 3;

BEGIN;
insert into log (id_operacao, operacao) values (txid_current(), 'begin');

INSERT INTO clientes_em_memoria (nome, saldo) VALUES ('Cliente 6', 600.00); 

-- 

TRUNCATE TABLE clientes_em_memoria RESTART IDENTITY CASCADE;

--

ALTER SEQUENCE clientes_em_memoria_id_seq RESTART WITH 1;

--
sudo kill -9 $(pidof postgres)

--
sudo service postgresql start
