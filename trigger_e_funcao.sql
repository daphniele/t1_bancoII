-- trigger para registrar as operaçoes comitadas

CREATE OR REPLACE FUNCTION reglog() 
RETURNS TRIGGER AS $$
    BEGIN
         IF (TG_OP = 'DELETE') THEN
            INSERT INTO log values (txid_current(),'D', old.id, old.nome, old.saldo);
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO log values (txid_current(), 'U', new.id, new.nome, new.saldo);
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO log  values (txid_current(), 'I', new.id, new.nome, new.saldo);
            RETURN NEW;
        END IF;
        RETURN NEW; 
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tr_log
    AFTER INSERT OR UPDATE OR DELETE ON clientes_em_memoria
    FOR EACH ROW EXECUTE PROCEDURE reglog();
    
-- função para inserir begin

CREATE OR REPLACE FUNCTION insere_begin() 
RETURNS VOID AS $$
    BEGIN
        insert into log (id_operacao, operacao) values (txid_current(), 'begin');
    END;
$$ LANGUAGE plpgsql;

-- função para inserir end

CREATE OR REPLACE FUNCTION insere_end() 
RETURNS VOID AS $$
	
	 BEGIN
        insert into log (id_operacao, operacao) values (txid_current(), 'end');
    END;
$$ LANGUAGE plpgsql;

	
-- resetar serial da tabela clientes

ALTER SEQUENCE clientes_em_memoria_id_seq RESTART WITH 1;

-- derrubar banco

sudo kill -9 $(pidof postgres)

-- ressuscitar banco

sudo service postgresql start

