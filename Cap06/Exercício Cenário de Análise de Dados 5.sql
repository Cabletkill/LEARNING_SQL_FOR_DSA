#1- Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro?
select*
from cap06.tb_bikes;
#
select 
case
	when tipo_membro ='Unknown' then 'Desconhecidos'
    else tipo_membro
    end tipo_membro,
    avg(duracao_segundos) as media_tempo
from cap06.tb_bikes
group by tipo_membro 
;
# 2- Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro e por estação fim (onde as bikes são entregues após o aluguel)?
select*
from cap06.tb_bikes;
#
select 
case
	when tipo_membro ='Unknown' then 'Desconhecidos'
    else tipo_membro
    end tipo_membro,
    estacao_fim,
    avg(duracao_segundos) as media_tempo
from cap06.tb_bikes
group by tipo_membro, estacao_fim
order by estacao_fim;

# 3- Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro e por estação fim (onde as bikes são entregues após o aluguel) ao longo do tempo?
#
select 
case
	when tipo_membro ='Unknown' then 'Desconhecidos'
    else tipo_membro
    end tipo_membro,
    estacao_fim,
    avg(duracao_segundos) OVER (order by estacao_fim) as media_tempo
from cap06.tb_bikes
order by estacao_fim;

# 4- Qual hora do dia (independente do mês) a bike de número W01182 teve o maior número de aluguéis considerando a data de início?
select*
from cap06.tb_bikes;
#
select 
	numero_bike,
    right(data_inicio, 8) as hora_inicio,
    count(numero_bike) as alugueis
from cap06.tb_bikes
where numero_bike = 'W01182'
group by right(data_inicio, 8)
order by 2;
#
select 	 
    numero_bike,
    extract(hour from data_inicio) as hora_inicio,
    count(duracao_segundos) as alugueis
from cap06.tb_bikes
where numero_bike = 'W01182'
group by hora_inicio
order by 2;

# 5- Qual o número de aluguéis da bike de número W01182 ao longo do tempo considerando a data de início?
select *
from cap06.tb_bikes;
#
select 
	numero_bike,
    count(numero_bike)
from cap06.tb_bikes
group by numero_bike
order by 1;
#
select 
	numero_bike,
	estacao_inicio,
    count(numero_bike) over(partition by data_inicio ) as numeros_aluguel
from cap06.tb_bikes
where numero_bike = 'W01182'
order by 1;
#
select 
	numero_bike,
    cast(data_inicio as date) as data_inicio,
	estacao_inicio,
    count(duracao_segundos) over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_aluguel
from cap06.tb_bikes
where numero_bike = 'W01182'
order by 1;

# 6- Retornar:
# Estação fim, data fim de cada aluguel de bike e duração de cada aluguel em segundos
# Número de aluguéis de bikes (independente da estação) ao longo do tempo
# Somente os registros quando a data fim foi no mês de Abril
#####
select
    estacao_fim,
    data_fim,
    duracao_segundos,
    count(duracao_segundos) over (order by data_fim) as tempo_uso
from cap06.tb_bikes
where extract(month from data_fim) = 4
; 

# 7- Retornar:
# Estação fim, data fim e duração em segundos do aluguel ________________________________________OK
# A data fim deve ser retornada no formato: 01/January/2012 00:00:00 ____________________________OK
# Queremos a ordem (classificação ou ranking) dos dias de aluguel ao longo do tempo _____________OK
# Retornar os dados para os aluguéis entre 7 e 11 da manhã ______________________________________OK
select 
	estacao_fim,
    DATE_FORMAT(data_fim, '%d/%M/%Y %H:%i:%s') as data_fim, # manipula a data para retornar por extenso
    duracao_segundos,
    row_number () over(partition by estacao_inicio order by data_inicio) as numeros_alugueis
from cap06.tb_bikes
WHERE HOUR(data_fim) BETWEEN 7 AND 11
;
select 
	estacao_fim,
    DATE_FORMAT(data_fim, '%d/%M/%Y %H:%i:%s') as data_fim, # manipula a data para retornar por extenso
    duracao_segundos,
    dense_rank () over(partition by estacao_inicio order by cast(data_inicio as date)) as numeros_alugueis
from cap06.tb_bikes
WHERE HOUR(data_fim) BETWEEN 7 AND 11
;

# 8- Qual a diferença da duração do aluguel de bikes ao longo do tempo, de um registro para outro, considerando data de início do aluguel e estação de início?
# A data de início deve ser retornada no formato: Sat/Jan/12 00:00:00 (Sat = Dia da semana abreviado e Jan igual mês abreviado). 
# Retornar os dados para os aluguéis entre 01 e 03 da manhã
select 
	estacao_inicio,
    date_format(data_inicio, '%d/%M/%Y %H:%i:%s') as data_inicio,
    duracao_segundos,
    duracao_segundos - lag(duracao_segundos, 1) over(partition by estacao_inicio order by cast( data_inicio as date)) as diferenca
from cap06.tb_bikes
where extract(hour from data_fim) between 01 and 03
;
select 
	estacao_inicio,
    date_format(data_inicio, '%d/%M/%Y %H:%i:%s') as data_inicio,
    duracao_segundos,
    TIMESTAMPDIFF(SECOND, data_inicio, data_fim) AS diferenca_segundos
from cap06.tb_bikes
order by data_inicio
;

# 9- Retornar:
# Estação fim, data fim e duração em segundos do aluguel ___________________________________OK
# A data fim deve ser retornada no formato: 01/January/2012 00:00:00 _______________________OK
# Queremos os registros divididos em 4 grupos ao longo do tempo por partição _______________OK
# Retornar os dados para os aluguéis entre 8 e 10 da manhã _________________________________OK
# Qual critério usado pela função NTILE para dividir os grupos? ____________________________OK
#
select
	estacao_fim,
    date_format(data_fim, '%d/%M/%Y %H:%i:%s' ) as data_fim,
    duracao_segundos,
    NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_quatro
from cap06.tb_bikes
where extract(hour from data_fim) between 08 and 10
;

# 10- Quais estações tiveram mais de 35 horas de duração total do aluguel de bike ao longo do tempo considerando a data fim e estação fim?
# Retorne os dados entre os dias '2012-04-01' e '2012-04-02'
# Dica: Use função window e subquery
select *
from cap06.tb_bikes;
select 
	estacao_inicio,
	round(sum(duracao_segundos/60/60),2) as total
from cap06.tb_bikes
group by estacao_inicio
having total > 35
order by estacao_inicio;

#################################
select 
	estacao_fim,
    cast(data_fim as date) as data_fim,
	sum(duracao_segundos/60/60) over (partition by estacao_fim order by cast(data_fim as date)) as total
from cap06.tb_bikes
where data_fim between "2012-04-01" and "2012-04-02"
;
select*
from
	(select 
	estacao_fim,
    cast(data_fim as date) as data_fim,
	sum(duracao_segundos/60/60) over (partition by estacao_fim order by cast(data_fim as date)) as total
    from cap06.tb_bikes
	where data_fim between "2012-04-01" and "2012-04-02"
) resultado
where resultado.total > 10
order by resultado.estacao_fim;

















