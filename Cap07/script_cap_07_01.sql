# ordenando por nome de coluna ou número de coluna
select * from cap07.covid_mortes order by location desc, date;
select * from cap07.covid_mortes order by 3 desc, 4;
#############################################################################

set sql_safe_updates = 0; ###  desabilita o bloqueio do update no mysql 

update cap07.covid_mortes
set  date = str_to_date(date,'%d/%m/%y'); ### atualizando e transformando a data dos dados 

update cap07.covid_vacinacao
set  date = str_to_date(date,'%d/%m/%y'); ### atualizando e transformando a data dos dados 

set sql_safe_updates = 1; ###  Habilita o bloqueio do update no mysql, sempre que for usado é preciso habilitar novamente

################################################################################

select 
	date,
    location,
    total_cases,
    new_cases,
    total_deaths,
    population
from cap07.covid_mortes
order by 2,1;

##############################
# qual a média de mortos por país?
# Análise univariada

select
	location,
    round(avg(total_cases),2) as media_total
from cap07.covid_mortes
group by location
order by location;
########
select
	location,
    round(avg(total_cases),2) as media_total,
    round(avg(new_cases),2) as media_new_cases
from cap07.covid_mortes
group by location
order by location;
#######################################
# Qual é a proporção de mortes em relação ao total de casos no Brasil?
# Análise Multivariada

select 
	date,
    location,
    total_deaths,
    (total_deaths / total_cases) * 100 as percentual_mortes
from cap07.covid_mortes
where location = "Brazil"
order by 2,1;
#######################################
# Qual a proporção média entre o total de casos e a população de cada localidade?
select* from cap07.covid_mortes;

select
	location,
    avg((total_cases / population) *100) as percentualpopulacao
    from cap07.covid_mortes
group by location
order by percentualpopulacao desc;
    
## Considerando o maior valor do total de casos, quais os países com a maior taxa de infecção em relação à população?
select 
	location,
    max(total_cases) as maior_numero_infec,
    max((total_cases / population) *100) as percentualpopulacao
from cap07.covid_mortes
where continent is not null
group by location, population
order by 3 desc;
##################################################################
# Quais os países com o maior número de mortes?
select * from cap07.covid_mortes;
##
select 
	location,
    sum(total_deaths) as mortes_totais
from cap07.covid_mortes
WHERE continent IS NOT NULL 
group by location
order by 2 desc;
# Cuidado!
SELECT location, 
       MAX(total_deaths) AS MaiorContagemMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY location
ORDER BY MaiorContagemMortes DESC;

# Quais os países com o maior número de mortes?
# Simples, mas resolve!
SELECT location, 
       MAX(total_deaths * 1) AS MaiorContagemMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY location
ORDER BY MaiorContagemMortes DESC;
# Quais os países com o maior número de mortes?
# Agora a forma ideal de resolver
# https://dev.mysql.com/doc/refman/8.0/en/cast-functions.html#function_cast
SELECT location, 
       MAX(CAST(total_deaths AS UNSIGNED)) AS MaiorContagemMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY location
ORDER BY MaiorContagemMortes DESC;

###############UNSIGNED#################
# quais os continentes com o maior numeros de mortes?
select * from cap07.covid_mortes;
#
select 
	continent,
    max(cast(total_deaths as unsigned))as maior_numero_mortes
from cap07.covid_mortes
where continent is not null
group by continent 
order by 2 desc;

#### Qual o percentual de mortes por dia?
select * from cap07.covid_mortes;
#
select 
	date,
    sum(new_cases) as total_casos,
    sum(cast( new_deaths as unsigned)) as total_deaths,
    coalesce((sum(cast(new_cases as unsigned)) / sum(new_cases)) * 100, 'N/A') as percentualdemortes
from cap07.covid_mortes
where continent is not null
group by date
order by 1,2;

#######
select * from cap07.covid_mortes;
#
select 
	location,
    max(cast(population as unsigned)) as maior_populacao,
    max(cast(total_deaths as unsigned))as maior_numero_mortes,
    max(cast(total_deaths as unsigned)) / max(cast(population as unsigned))*100 as percentual_mortes
from cap07.covid_mortes
where continent is not null
group by location
order by 2 desc;
########################################################
# Qual o número de novos vacinados e a média móvel de novos vacinados ao longo do tempo por localidade?
# Considere apenas os dados da América do Sul
select * from cap07.covid_mortes, cap07.covid_vacinacao;
#
select 
	mortos.continent,
    mortos.location,
    mortos.date,
    vacinados.new_vaccinations,
    avg(cast(vacinados.new_vaccinations as unsigned)) over (partition by mortos.location order by mortos.date)as media_movel_vacinados
from cap07.covid_mortes as mortos
inner join cap07.covid_vacinacao vacinados
on mortos.location = vacinados.location
and mortos.date = vacinados.date
where mortos.continent = "South America"
order by 2,3;




 
    














