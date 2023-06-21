#Retornar o id od pedido e nome do cliente
# inner join

# junção de tabelas
select id_pedido, nome_cliente
from tb_clientes, tb_pedidos;

# Inner Join
select id_pedido, nome_cliente
from tb_clientes as c
inner join tb_pedidos as p
on c.id_cliente = p.id_cliente;

# utilizando where no lugar de inner join 
select id_pedido, nome_cliente
from tb_clientes as c, tb_pedidos as p
where c.id_cliente =p.id_cliente;

# retornar id do pedido, nome do cliente, e nome do vendedor
# inner join com 3 tabelas
select id_pedido, nome_cliente, nome_vendedor
from tb_clientes as c 
inner join tb_pedidos as p
inner join tb_vendedor as v
on c.id_cliente = p.id_cliente 
and p.id_vendedor = v.id_vendedor; 

# retornar id do pedido, nome do cliente, e nome do vendedor
# Corrigido
SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor
FROM ((cap04.TB_PEDIDOS AS P
INNER JOIN cap04.TB_CLIENTES AS C ON P.id_cliente = C.id_cliente)
INNER JOIN cap04.TB_VENDEDOR AS V ON P.id_vendedor = V.id_vendedor);

# retornar id do pedido, nome do cliente, e nome do vendedor
# Utilizando where
select id_pedido, nome_cliente, nome_vendedor
from tb_clientes as c, tb_pedidos as p, tb_vendedor as v
where c.id_cliente = p.id_cliente and p.id_vendedor = v.id_vendedor;

# Quando o nome da coluna e o mesmo nas duas tabelas utilizar (using)
select id_pedido, nome_cliente
from tb_clientes as c 
inner join tb_pedidos as p
using(id_cliente);

# inner join, where e order by
select id_pedido, nome_cliente
from cap04.tb_pedidos as p
inner join cap04.tb_clientes as c
using(id_cliente)
where c.nome_cliente like 'Bob%'
order by p.id_pedido desc;

# retornar todos os clientes, com ou sem pedido associado
# Usando left join
# left join - indica que queremos todos os dados da tabela da esquerda mesmo sem correspondente na tabela da direita
select nome_cliente, id_pedido
from tb_clientes as c
left outer join tb_pedidos as p
on c.id_cliente = p.id_cliente;


# Retornar a data do pedido, o nome do cliente, todos os vendedores, com ou sem pedido associado, e ordenar o resultado pelo nome do cliente.
select 
case
	when id_pedido is null then 'Sem Pedido'
		else id_pedido
     end as id_pedido,
case 
	when nome_cliente is null then 'Sem Cliente'
		else nome_cliente
	end as nome_cliente,
case 
	when nome_vendedor is null then 'sem Vendedor'
		else nome_vendedor
	end as nome_vendedor, 
case 
	when data_pedido is null then 'Sem Pedido nesta Data'
		else data_pedido
    end as data_pedido
   
from tb_pedidos as p
inner join tb_clientes as c
right join tb_vendedor as v
on c.id_cliente = p.id_cliente and
p.id_vendedor = v.id_vendedor
order by nome_cliente desc;

###### 2ª forma

select nome_cliente, nome_vendedor, data_pedido
from tb_clientes as c, tb_pedidos as p, tb_vendedor as v
where c.id_cliente = p.id_cliente and p.id_vendedor = v.id_vendedor
order by nome_cliente;

#######################################################################################################################
## FULL OUTER JOIN não funciona no mysql sgbd, sera necessario o UNION ou UNION ALL
select nome_cliente, id_pedido
from tb_clientes as c
left outer join tb_pedidos as p
on c.id_cliente = p.id_cliente
union all
select nome_cliente, id_pedido
from tb_clientes as c
right outer join tb_pedidos as p
on c.id_cliente = p.id_cliente
order by id_pedido;

# Retornar clientes que sejam da mesma cidade 
# nesse caso e necessario identificar os dados da tabela
select a.id_cliente, a.nome_cliente, a.cidade_cliente
from tb_clientes as a, tb_clientes as b
where a.id_cliente <> b.id_cliente
and a.cidade_cliente = b.cidade_cliente ; 

# Self Join resposta 
SELECT A.nome_cliente, A.cidade_cliente
FROM cap04.TB_CLIENTES A, cap04.TB_CLIENTES B
WHERE A.id_cliente <> B.id_cliente
AND A.cidade_cliente = B.cidade_cliente;

################################################################################################
# CROSS JOIN
select c.nome_cliente, p.id_cliente
from cap04.tb_clientes as c
cross join cap04.tb_pedidos as p;

#sem cross join junçao de tabelas
select*
from cap04.tb_clientes, cap04.tb_pedidos, cap04.tb_vendedor;

#################################################################################################




























 


