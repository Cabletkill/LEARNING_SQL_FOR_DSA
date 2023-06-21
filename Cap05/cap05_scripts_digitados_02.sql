#contagem de clientes por cidade
select count(id_cliente) as count_id_cliente, cidade_cliente
from cap05.tb_clientes
group by cidade_cliente
order by count_id_cliente;

###############################
# Calculando a Média 
select round(avg(valor_pedido),2) as media_venda_pedido
from cap05.tb_pedidos;
 
# Calculando a média do valor dos pedidos por cidade com right join
select case 
	when round(avg(valor_pedido),2) is null then 0 
    else round(avg(valor_pedido),2)
	end as media_venda_pedido, 
cidade_cliente
from cap05.tb_pedidos as p right join cap05.tb_clientes as c
on p.id_cliente = c.id_cliente
group by cidade_cliente
order by media_venda_pedido;

# Calculando a média do valor dos pedidos por cidade com where
select
case 
	when round(avg(valor_pedido),2) is null then 0 
    else round(avg(valor_pedido),2)
	end as media_venda_pedido, 
cidade_cliente
from cap05.tb_pedidos as p, cap05.tb_clientes as c
where p.id_cliente = c.id_cliente
group by cidade_cliente
order by media_venda_pedido;

############################
#lista tabela de pedidos
select * from cap05.tb_pedidos;

#############################
##Soma total do valor dos pedidos
select sum(valor_pedido) as total_pedidos
from cap05.tb_pedidos;

################################
#soma total dos pedido por cidade com inner join
select sum(valor_pedido) as total_pedidos, cidade_cliente
from cap05.tb_pedidos as p inner join cap05.tb_clientes as c
on p.id_cliente = c.id_cliente
group by cidade_cliente
order by total_pedidos;

################################
#soma total dos pedido por cidade com right join
select 
case
	when floor(sum(valor_pedido)) is null then 0
    else floor(sum(valor_pedido))
	end as total_pedidos,
 cidade_cliente
from cap05.tb_pedidos as p right join cap05.tb_clientes as c
on p.id_cliente = c.id_cliente
group by cidade_cliente
order by total_pedidos;

###############################
#soma total dos pedido por cidade com right join
select 
case
	when floor(sum(valor_pedido)) is null then 0
    else floor(sum(valor_pedido))
	end as total_pedidos,
 cidade_cliente,
 estado_cliente
from cap05.tb_pedidos as p right join cap05.tb_clientes as c
on p.id_cliente = c.id_cliente
group by cidade_cliente, estado_cliente
order by total_pedidos;

#######################################
# Supondo que a comissão de cada vendedor seja de 10%, quanto cada vendedor ganhou de comissão nas vendas no estado do Ceará?
# Retorne 0 se não houve ganho de comissão
select 
case 
	when round(sum(valor_pedido * 0.10), 2) is null then 0
    else round(sum(valor_pedido * 0.10), 2)
    end as comissao_vendedor,
nome_vendedor,
case
	when estado_cliente is Null then 'não atua no CE'
    else estado_cliente
    end as estado_cliente
from cap05.tb_pedidos as p 
right join cap05.tb_vendedor as v
on p.id_vendedor = v.id_vendedor
inner join cap05.tb_clientes as c
on p.id_cliente = c.id_cliente
where estado_cliente = "CE" 
group by nome_vendedor, cidade_cliente, estado_cliente
order by comissao_vendedor;

##2° tentativa
select
case # valor_pedido = comissao_vendedor
	when round(sum(valor_pedido * 0.10), 2) is null then 0
    else round(sum(valor_pedido * 0.10), 2)
    end as comissao_vendedor,
nome_vendedor,
case # stado_cliente
	when estado_cliente is Null then 'Não atua no CE'
    else estado_cliente
    end as estado_cliente
from cap05.tb_clientes as c inner join cap05.tb_pedidos as p right join cap05.tb_vendedor as v
on c.id_cliente = p.id_cliente
and p.id_vendedor = v.id_vendedor
and estado_cliente = 'CE'
group by nome_vendedor, cidade_cliente, estado_cliente
order by comissao_vendedor;

###############################################
 #maior valor de pedido 
select 
max(valor_pedido) as valor_maximo_pedido, 
min(valor_pedido) valor_minimo_pedido
from cap05.tb_pedidos;

############################################
# quantidade de clientes que fizeram pedidos
select count(distinct(id_cliente)) as quantos_clientes_compraram
from cap05.tb_clientes;    

############################################
# algum vendedor participou de vendas cujo o valor do pedido tenha sido superios a 600 no estado de SP?
#1° separando os clientes por cidade
select *
from cap05.tb_clientes as  c, cap05.tb_pedidos as p
where c.id_cliente = p.id_cliente
and estado_cliente = "SP"
;
#2° procurar vendader que vendeu mas de 600
select c.id_cliente, 
nome_cliente, 
cidade_cliente, 
estado_cliente,
id_pedido,
id_vendedor,
data_pedido,
id_entrega,
valor_pedido
from cap05.tb_clientes as  c, cap05.tb_pedidos as p
where c.id_cliente = p.id_cliente
and estado_cliente = "SP"
and valor_pedido > 600;   

# 3°
select  nome_vendedor, valor_pedido
from cap05.tb_clientes as c inner join cap05.tb_pedidos as p inner join cap05.tb_vendedor as v
on c.id_cliente = p.id_cliente
and p.id_vendedor = v.id_vendedor
and valor_pedido > 600
and estado_cliente = "SP";

####################################################
#Algum vendedor participou de vendas em que a média do valor pedido por estado do cliente foi maior que 800?
select nome_vendedor, estado_cliente, ceiling(avg(valor_pedido)) as media
from cap05.tb_clientes as c 
inner join cap05.tb_pedidos as p 
inner join cap05.tb_vendedor as v
on c.id_cliente = p.id_cliente
and p.id_vendedor = v.id_vendedor
group by nome_vendedor, estado_cliente
having media > 800
order by nome_vendedor;

####################################################
#Qual estado teve mais de 5 pedidos
select estado_cliente, count(estado_cliente) as quantos_pedidos
from cap05.tb_clientes as c inner join cap05.tb_pedidos as p  
on c.id_cliente = p.id_cliente
group by estado_cliente
having quantos_pedidos > 5;
####################################################
# Faturamento total por ano
select ano, sum(faturamento) as total
from cap05.tb_vendas
group by ano with rollup  
having total > 13000
;
####################################################
select ano, sum(faturamento) as total
from cap05.tb_vendas
group by ano with rollup  
order by ano desc
;
####################################################
select ano, 
case
	when pais is null then "soma total"
    else pais
    end as pais
,sum(faturamento) as total
from cap05.tb_vendas
group by ano, pais   
with rollup  
having total > 1800
order by ano desc
;
####################################################
select ano, produto, sum(faturamento) as total
from cap05.tb_vendas
group by ano, produto with rollup  
order by grouping(produto) desc
;
####################################################
# Por que não podemos usar o CASE na query acima?
select ano, 
case 
	when produto is null then "valor total"
    else produto
    end as produto
, sum(faturamento) as total
from cap05.tb_vendas
group by ano, produto with rollup  
order by grouping(produto) desc
;
####################################################
select
	if(grouping(ano), "Total de Todos os Anos", ano)as ano,
    if(grouping(pais), "Total de Todos os Anos", pais)as pais,
    if(grouping(produto), "Total de Todos os Anos", produto)as produto,
    sum(faturamento) faturamento
from cap05.tb_vendas
group by ano, pais, produto with rollup
 
order by ano;
####################################################


