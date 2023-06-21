# Lista os Clientes
select *
from cap05.tb_clientes;

################################################ 
##contagem de clientes por cidade group by
select count(id_cliente) as id_cliente, cidade_cliente
from cap05.tb_clientes
group by cidade_cliente
order by id_cliente;

#################################################
#Média do valor dos pedidos
select avg(valor_pedido) as media
from cap05.tb_pedidos;

##################################################
#Média dos valores dos pedidos por cidade com inner join
select round(avg(valor_pedido), 2) as media, cidade_cliente
from cap05.tb_clientes as c inner join cap05.tb_pedidos as p
on c.id_cliente = p.id_cliente
group by cidade_cliente
order by media asc;

# Média do valor dos pedidos por cidade com where
SELECT AVG(valor_pedido) AS media, cidade_cliente
FROM cap05.TB_PEDIDOS P, cap05.TB_CLIENTES C
WHERE P.id_cliente = C.id_cliente
GROUP BY cidade_cliente;

#Média dos valores dos pedidos por cidade com left join with case
select 
case 
   when round(avg(valor_pedido), 2) is Null then 0
   else round(avg(valor_pedido), 2)
   end as media
, cidade_cliente
from cap05.tb_clientes as c left join cap05.tb_pedidos as p
on c.id_cliente = p.id_cliente
group by cidade_cliente
order by media asc;
##################################################

select * from tb_clientes;

























