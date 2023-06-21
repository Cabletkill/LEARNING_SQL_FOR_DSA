select *
from cap06.tb_vendas
;
####Total de vendas
select sum(valor_venda) as total_de_vendas
from cap06.tb_vendas
;
####Total de vendas por ano_fiscal
select ano_fiscal, sum(valor_venda) as total_de_vendas
from cap06.tb_vendas
group by ano_fiscal;

####Total de vendas por nome_funcionario
select nome_funcionario, sum(valor_venda) as total_de_vendas
from cap06.tb_vendas
group by nome_funcionario;

####Total de vendas por nome_funcionario ano_fiscal
select nome_funcionario, ano_fiscal, sum(valor_venda) as total_de_vendas
from cap06.tb_vendas
group by nome_funcionario, ano_fiscal
order by 2 asc;

SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) OVER (PARTITION BY ano_fiscal) total_vendas_ano
FROM cap06.TB_VENDAS
ORDER BY nome_funcionario;
#######################
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) OVER (PARTITION BY nome_funcionario) total_vendas_ano
FROM cap06.TB_VENDAS
ORDER BY nome_funcionario;
#### Query sem sentido
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) total_vendas,
    SUM(valor_venda) OVER (PARTITION BY ano_fiscal) total_vendas_ano
FROM cap06.TB_VENDAS
group by ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;
##########################################
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
  
    SUM(valor_venda) OVER (PARTITION BY ano_fiscal) total_vendas_ano
FROM cap06.TB_VENDAS
ORDER BY ano_fiscal;

#########################################

select 
	ano_fiscal,
    nome_funcionario,
    valor_venda,
    sum(valor_venda) over (partition by ano_fiscal) total_vendas
from cap06.tb_vendas
order by ano_fiscal;
#############################################
select sum(valor_venda) as total_vendas
from cap06.tb_vendas;
#############################################
select 
	ano_fiscal,
    nome_funcionario,
    valor_venda,
    sum(valor_venda) over () total_vendas
from cap06.tb_vendas
order by ano_fiscal;
#############################################
# Total de vendas por ano, por funcionário e total de vendas geral
select
	ano_fiscal,
    nome_funcionario,
    count(*) over() num_vendas_geral
from cap06.tb_vendas
order by ano_fiscal;
#############################################
select
	ano_fiscal,
    nome_funcionario,
    count(*) num_vendas_ano,
    count(*) over() num_vendas_geral
from cap06.tb_vendas
group by ano_fiscal, nome_funcionario
order by ano_fiscal;

################################################
# Reescrevendo a query anterior usando subquery 
select
	ano_fiscal,
    nome_funcionario,
    count(*) num_vendas_geral,
    (select count(*) from cap06.tb_vendas) as num_geral_vendas
from tb_vendas
group by ano_fiscal, nome_funcionario
order by ano_fiscal;    
    













