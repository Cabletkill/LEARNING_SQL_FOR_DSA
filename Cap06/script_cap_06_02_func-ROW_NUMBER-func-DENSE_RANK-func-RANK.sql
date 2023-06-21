# tipos de classificação

# Classificação do Campeonato Brasileiro:    # ROW_NUMBER():                         # DENSE_RANK():                      # RANK():

# Flamengo - 35 pontos                       # 1- Flamengo - 35 pontos               # 1- Flamengo - 35 pontos            # 1- Flamengo - 35 pontos  
# Palmeiras - 35 pontos                      # 2- Palmeiras - 35 pontos              # 1- Palmeiras - 35 pontos           # 1- Palmeiras - 35 pontos 
# Santos - 32 pontos                         # 3- Santos - 32 pontos                 # 2- Santos - 32 pontos              # 3- Santos - 32 pontos  
# Internacional - 30 pontos                  # 4- Internacional - 30 pontos          # 3- Internacional - 30 pontos       # 4- Internacional - 30 pontos       
# Fluminense - 30 pontos                     # 5- Fluminense - 30 pontos             # 3- Fluminense - 30 pontos          # 4- Fluminense - 30 pontos 
# Fortaleza - 29 pontos                      # 6- Fortaleza - 29 pontos              # 4- Fortaleza - 29 pontos           # 6- Fortaleza - 29 pontos

#################################
# Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo
# Função ROW_NUMBER(): 
select 
	estacao_inicio,
	data_inicio,
    duracao_segundos,
    row_number () over(partition by estacao_inicio order by data_inicio) as numeros_alugueis
from cap06.tb_bikes
where data_inicio < "2012-01-08"
and numero_estacao_inicio = '31000';

## função CAST
select 
	estacao_inicio,
	cast(data_inicio as date) as data_inicio,
    duracao_segundos,
    row_number () over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis
from cap06.tb_bikes
where data_inicio < "2012-01-08"
and numero_estacao_inicio = '31000';

##################
# Função DENSE_RANK(): 
select 
	estacao_inicio,
	data_inicio,
    duracao_segundos,
    DENSE_RANK() over(partition by estacao_inicio order by data_inicio) as numeros_alugueis
from cap06.tb_bikes
where data_inicio < "2012-01-08"
and numero_estacao_inicio = '31000';

## função CAST
select 
	estacao_inicio,
	cast(data_inicio as date) as data_inicio,
    duracao_segundos,
    DENSE_RANK() over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis
from cap06.tb_bikes
where data_inicio < "2012-01-08"
and numero_estacao_inicio = '31000';

##################
# Função RANK(): 
select 
	estacao_inicio,
	data_inicio,
    duracao_segundos,
    RANK() over(partition by estacao_inicio order by data_inicio) as numeros_alugueis
from cap06.tb_bikes
where data_inicio < "2012-01-08"
and numero_estacao_inicio = '31000';

## função CAST
select 
	estacao_inicio,
	cast(data_inicio as date) as data_inicio,
    duracao_segundos,
    RANK() over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis
from cap06.tb_bikes
where data_inicio < "2012-01-08"
and numero_estacao_inicio = '31000';

#################################
# Comparando a classificação row_number (), DENSE_RANK() e RANK()
select 
	estacao_inicio,
	cast(data_inicio as date) as data_inicio,
    duracao_segundos,
    row_number () over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis_row_number,
    DENSE_RANK() over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis_dense_rank,
    RANK() over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis_rank
from cap06.tb_bikes
where data_inicio < "2012-01-08"
and numero_estacao_inicio = '31000';

#################################
# Comparando a classificação row_number (), DENSE_RANK() e RANK()
select 
	estacao_inicio,
	cast(data_inicio as date) as data_inicio,
    duracao_segundos,
    row_number () over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis_row_number,
    DENSE_RANK() over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis_dense_rank,
    RANK() over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis_rank
from cap06.tb_bikes
where data_inicio < "2012-01-08"
and numero_estacao_inicio = '31000';

#################################


  


























