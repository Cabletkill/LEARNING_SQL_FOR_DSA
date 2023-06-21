##################################################################
select
	location,
    total_cases,
    new_cases,
    total_deaths,
    population
from cap07.covid_mortes
order by 1 ;
##################################################################
##Total de casos por pais
select 
	location,
    round(sum(cast(new_cases as unsigned)),2) as total_casos
from cap07.covid_mortes
group by location;

##################################################################
# qual a média de mortos por país?
# Análise univariada
select * from cap07.covid_mortes;
select * from cap07.covid_vacinacao;
###
select
	location,
    avg(total_deaths) as media_total_mortos
from cap07.covid_mortes
group by location
order by media_total_mortos desc;

##################################################################
# Qual é a proporção de mortes em relação ao total de casos no Brasil?
# Análise Multivariada
select
	date,
    location,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 as percentual_mortes ##### analise multivariada
from cap07.covid_mortes
where location = "Brazil"
order by 2,1 desc;

##################################################################
# Qual a proporção média entre o total de casos e a população de cada localidade?
select location, population, total_cases, (total_cases / population) * 100 as total
from cap07.covid_mortes
group by location, population, total_cases
order by location;


##################################################################    
## Considerando o maior valor do total de casos, quais os países com a maior taxa de infecção em relação à população?

##################################################################
# Quais os países com o maior número de mortes?

##################################################################
# Quais os países com o maior número de mortes?
# Simples, mas resolve!

###############UNSIGNED#################
# quais os continentes com o maior numeros de mortes?

#################################################################
#### Qual o percentual de mortes por dia?

#################################################################
# Qual o número de novos vacinados e a média móvel de novos vacinados ao longo do tempo por localidade?
# Considere apenas os dados da América do Sul




 
    














