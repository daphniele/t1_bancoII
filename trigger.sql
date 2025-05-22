-- trigger para registrar as operaçoes -- não salva operações não comitadas ><

CREATE FUNCTION reglog() 
RETURNS TRIGGER AS $$
    BEGIN
         IF (TG_OP = 'DELETE') THEN
            INSERT INTO log values (txid_current(),'D', NULL, NULL, NULL);
            RETURN NEW;
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

CREATE TRIGGER tr_log
    AFTER INSERT OR UPDATE OR DELETE ON clientes_em_memoria
    FOR EACH ROW EXECUTE PROCEDURE reglog();