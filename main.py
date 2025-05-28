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
    transacoes_nao_finalizadas = []

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

        #refaz as transações que finalizaram

        # busca na tabela de log a transação



  
        

   
        
        
      
    
    
  
    cursor.close()
    conexao.close()

redo()
