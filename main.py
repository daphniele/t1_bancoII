import psycopg2
from config import config

    
def redo():    
    
    # conexão com o banco
    conexao = psycopg2.connect(**config())
    cursor = conexao.cursor()

   # leitura da tabela de log
    cursor.execute("SELECT * FROM log ORDER BY id_operacao;")
    log = cursor.fetchall()

  
    begins_encontrados=[]
    ends_encontrados=[]

    i = 0
    while i < len(log):
        linha = log[i]
        id_operacao, operacao, id_cliente, nome, saldo = linha

        if operacao == 'begin':
            begins_encontrados.append(id_operacao+1)
        
        elif operacao == 'end':
            ends_encontrados.append(id_operacao-1)
        
        i = i+1

    #compara número das transações para saber quais finalizaram

    transacoes_comitadas = list(set(begins_encontrados) & set(ends_encontrados))
    transacoes_nao_finalizadas = list(set(begins_encontrados) - set(ends_encontrados))


    # imprime as transações:
        
    print("Transações que realizaram REDO:", ', '.join(str(x) for x in transacoes_comitadas))
    print("Transações que NÃO realizaram REDO:", ', '.join(str(x) for x in transacoes_nao_finalizadas))

    #refaz as transações que finalizaram
    i = 0
    while i < len(log):
        linha = log[i]
        id_operacao, operacao, id_cliente, nome, saldo = linha

        if id_operacao in transacoes_comitadas:

            if operacao == 'I': 
                cursor.execute(
                    "INSERT INTO clientes_em_memoria (id, nome, saldo) VALUES (%s, %s, %s)",
                    (id_cliente, nome, saldo)
                )

            elif operacao == 'U': 
                cursor.execute(
                    "UPDATE clientes_em_memoria SET nome = %s, saldo = %s WHERE id = %s",
                    (nome, saldo, id_cliente)
                )

            elif operacao == 'D':
                cursor.execute(
                    "DELETE FROM clientes_em_memoria WHERE id = %s",
                    (id_cliente,)
                )

        i += 1
   
    #executa as ações finaliza a conexão com o banco
    conexao.commit()
    cursor.close()
    conexao.close()

redo()
