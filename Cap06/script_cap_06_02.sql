# Duração total do aluguel de bikes (em hora)
select *
from tb_bikes;
##
select round(sum(duracao_segundos/60/60), 2) as total_utilizado_horas
from cap06.tb_bikes;

# Duração total do aluguel de bikes (em hora), ao longo do tempo (suma acumulada).
## com a função windows

select 
	duracao_segundos,
    sum(duracao_segundos/60/60) OVER (order by data_inicio) as total_utilizado_horas
from cap06.tb_bikes;

###############################################
select 
	duracao_segundos,
    sum(duracao_segundos/60/60) OVER () as total_utilizado_horas
from cap06.tb_bikes;

#######################################################
# Duração total do aluguel de bikes (em hora), ao longo do tempo, por estação de inicio do aluguel de bike
# quando a data de inicio  foi inferior a 2012-01-08
select *
from tb_bikes;
 #############
 SELECT estacao_inicio,
       duracao_segundos,
       data_inicio,
       SUM(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS tempo_total_horas
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';
######
SELECT estacao_inicio,
       duracao_segundos,
       data_inicio,
       SUM(duracao_segundos/60/60) OVER () AS tempo_total_horas
FROM cap06.TB_BIKES
WHERE data_inicio < '2012-01-08';

# Estatísticas
# Qual a média de tempo (em horas) de aluguel de bike da estação de início 31017?
select 
	estacao_inicio,
    avg(duracao_segundos/60/60) AS tempo_total_horas
from cap06.tb_bikes
where numero_estacao_inicio = "31017"
group by estacao_inicio 
;
########################################################## # group by agrupa por coluna em quanto o over agrupa por linha
# Qual a média de tempo (em horas) de aluguel da estação de 31017, ao longo do tempo? (media movel)
select 
	estacao_inicio,
    avg(duracao_segundos/60/60) OVER (partition by estacao_inicio order by data_inicio) AS media_tempo_aluguel
from cap06.tb_bikes
where numero_estacao_inicio = "31017";
##########################################################
# Retornar:
# Estação de início, data de início e duração de cada aluguel de bike em segundos
# Duração total de aluguel das bikes ao longo do tempo por estação de início
# Duração média do aluguel de bikes ao longo do tempo por estação de início
# Número de aluguéis de bikes por estação ao longo do tempo 
# Somente os registros quando a data de início for inferior a '2012-01-08'
select 
	estacao_inicio,
    data_inicio,
    duracao_segundos,
    sum(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as total_segundos,
    avg(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as total_media_tempo,
    count(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as total_count
from cap06.tb_bikes
where data_inicio < "2012-01-08";
#######################################################################################################
# Retornar:
# Estação de início, data de início de cada aluguel de bike e duração de cada aluguel em segundos
# Número de aluguéis de bikes (independente da estação) ao longo do tempo 
# Somente os registros quando a data de início for inferior a '2012-01-08'
select 
	estacao_inicio,
    data_inicio,
    duracao_segundos,
    sum(duracao_segundos/60/60) over (partition by data_inicio order by estacao_inicio) as total_segundos,
    avg(duracao_segundos/60/60) over (partition by data_inicio order by estacao_inicio) as total_media_tempo,
    count(duracao_segundos/60/60) over (partition by data_inicio order by estacao_inicio) as total_count
from cap06.tb_bikes
where data_inicio < "2012-01-08";
########
select 
	estacao_inicio,
    data_inicio,
    duracao_segundos,
    count(duracao_segundos/60/60) over (order by data_inicio) as total_count
from cap06.tb_bikes
where data_inicio < "2012-01-08";
########
select 
	estacao_inicio,
    data_inicio,
    duracao_segundos,
    row_number() over(order by data_inicio) as total_count
from cap06.tb_bikes
where data_inicio < "2012-01-08";
#####
select 
	estacao_inicio,
    data_inicio,
    duracao_segundos,
    row_number() over(partition by estacao_inicio order by data_inicio) as total_count
from cap06.tb_bikes
where data_inicio < "2012-01-08";
####################################################################################























 
 

 


