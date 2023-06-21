# 1- Qual o número de hubs por cidade?
select 
	if(grouping(hub_city), "Total de cidades", hub_city) as hub_city
, count(hub_id) as numero_hubs
from exec4.hubs
group by hub_city with rollup
order by 1 ;

# 2- Qual o número de pedidos (orders) por status?
select order_status, count(order_status) as contagem
from exec4.orders
group by order_status;
#
select 
	if(grouping(channel_id),'Total de ID', channel_id) as channel_id,
    if(grouping(order_status), 'Total por STATUS', order_status) as order_status,
    count(order_status) as contagem 
from exec4.orders
group by channel_id, order_status with rollup
order by 1,2;

# 3- Qual o número de lojas (stores) por cidade dos hubs?
select hub_city, count(store_id) as total_stores
from exec4.hubs as h inner join exec4.stores as s
on h.hub_id = s.hub_id
group by hub_city
order by hub_city;

# 4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?
select min(payment_amount) as menor_pagamento, max(payment_amount) as maior_pagamento
from exec4.payments;

# 5- Qual tipo de driver (driver_type) fez o maior número de entregas?
select 
	if(grouping(driver_type), "Total", driver_type) as driver_type
from exec4.drivers
group by driver_type with rollup;
#2° parte
select 
	if(grouping(driver_type), "Total", driver_type) as driver_type,
	count(delivery_status) as tipo_deliveri
from exec4.drivers as dr inner join exec4.deliveries as de
on dr.driver_id = de.driver_id
group by driver_type with rollup; 

# 6- Qual a distância média das entregas por tipo de driver (driver_modal)?
select 
	driver_type,driver_modal,
    floor(avg(delivery_distance_meters)) as avg_distence
from exec4.deliveries as del inner join exec4.drivers as dri
on del.driver_id = dri.driver_id
group by driver_type,driver_modal;

####2° codigo with rolloup 
select 
	if (grouping(driver_modal), 'Media', driver_modal) as driver_modal,
    floor(avg(delivery_distance_meters)) as avg_distence
from exec4.deliveries as del inner join exec4.drivers as dri
on del.driver_id = dri.driver_id
group by driver_type with rollup;

# 7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?
select 
	if (grouping(store_name), 'Media', store_name) as store_name,
    floor(avg(order_amount)) as order_amount
from exec4.orders as orders right join exec4.stores as stores
on orders.store_id = stores.store_id
group by store_name with rollup;

#2°
select 
	store_name,
    floor(avg(order_amount)) as media
from exec4.orders as orders inner join exec4.stores as stores
on orders.store_id = stores.store_id
group by store_name  
order by store_name;

# 8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?
 
select 
case
 when store_name is null then "Pedidos Sem Loja"
 else store_name
 end as store_name
, count(order_id) as order_id
from exec4.orders as ord left join exec4.stores as sto
on ord.store_id = sto.store_id
group by store_name;

#####
select coalesce(store_name, "Pedido sem loja") as store_id , count(order_id) as order_id
from exec4.orders as ord left join exec4.stores as sto
on ord.store_id = sto.store_id
group by store_name
order by order_id desc;

# 9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
select*
from exec4.channels as ch inner join exec4.orders as ord
on ch.channel_id = ord.channel_id
inner join exec4.payments as pay
on ord.payment_order_id = pay.payment_order_id
;
#########
select 
     channel_name
    , round(sum(order_amount),2) as order_amount
from exec4.channels as ch inner join exec4.orders as ord
on ch.channel_id = ord.channel_id
inner join exec4.payments as pay
on ord.payment_order_id = pay.payment_order_id
where channel_name = "FOOD PLACE"
group by channel_name
;
## Correto corrigido
select round(sum(order_amount),2) as total
from exec4.orders as ord, exec4.channels as ch
where ch.channel_id = ord.channel_id
and channel_name = "FOOD PLACE";

# 10- Quantos pagamentos foram cancelados (chargeback)?
select payment_status, count(payment_id) as pagamentos
from exec4.payments
where payment_status = "chargeback"
;
# 11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?
select 
payment_status, 
round(avg(payment_amount),2) as media_valor_cancelados,
count(payment_id) as pagamentos_cancelados
from exec4.payments
where payment_status = "chargeback"
;

# 12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?
select payment_method, round(avg(payment_amount),2) as media_pagamentos
from exec4.payments
group by payment_method
order by media_pagamentos desc
;

# 13- Quais métodos de pagamento tiveram valor médio superior a 100?
select payment_method, round(avg(payment_amount),2) as media_pagamentos
from exec4.payments
group by payment_method
having media_pagamentos > 100
order by media_pagamentos
;
# 14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
select hub_state, store_segment, channel_type, round(avg(payment_amount),2) as media_pagamentos
from exec4.hubs as hubs 
inner join exec4.stores as stores
inner join exec4.orders as orders
inner join exec4.channels as channels
inner join exec4.payments as pay
on hubs.hub_id = stores.hub_id
on stores.store_id = orders.store_id
on orders.channel_id = channels.channel_id
on orders.payment_order_id = pay.payment_order_id
group by hub_state, store_segment, channel_type
;
#
select hub_state, store_segment, channel_type, round(avg(payment_amount),2) as media_pagamentos  
from exec4.hubs as hubs 
inner join exec4.stores as stores
on hubs.hub_id = stores.hub_id
inner join exec4.orders as orders
on stores.store_id = orders.store_id
inner join exec4.payments as pay
on orders.payment_order_id = pay.payment_order_id
inner join exec4.channels as channels
on orders.channel_id = channels.channel_id
group by hub_state, store_segment, channel_type 
order by 1,2 asc
;

# 15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?
select hub_state, store_segment, channel_type, round(avg(payment_amount),2) as media_pagamentos  
from exec4.hubs as hubs 
inner join exec4.stores as stores
on hubs.hub_id = stores.hub_id
inner join exec4.orders as orders
on stores.store_id = orders.store_id
inner join exec4.payments as pay
on orders.payment_order_id = pay.payment_order_id
inner join exec4.channels as channels
on orders.channel_id = channels.channel_id
group by hub_state, store_segment, channel_type 
having media_pagamentos > 10
order by 1,2 asc
;
# melhorar a query anterior 
 


# 16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e 
# tipo de canal (channel_type)? Demonstre os totais intermediários e formate o resultado.

select
	if (grouping(hub_state), "Total tipo state", hub_state) as hub_state,
	if (grouping(channel_type), "Total tipo Channel", channel_type) as channel_type,
	if (grouping(store_segment), "Total tipo segment", store_segment) as store_segment,
    round(sum(order_amount),2) as total_vendas
from exec4.orders as orders
inner join exec4.channels as channels
on orders.channel_id = channels.channel_id
inner join exec4.stores as stores
on orders.store_id = stores.store_id
inner join exec4.hubs as hubs
on stores.hub_id = hubs.hub_id
GROUP BY hub_state, store_segment, channel_type WITH ROLLUP;
;
SELECT 
    IF(GROUPING(hub_state), 'Total Hub State', hub_state) AS hub_state,
    IF(GROUPING(channel_type), 'Total Tipo de Canal', channel_type) AS channel_type,
	IF(GROUPING(store_segment), 'Total Segmento', store_segment) AS store_segment,
    ROUND(SUM(order_amount),2) total_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
GROUP BY hub_state, store_segment, channel_type WITH ROLLUP;


# 17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?
SELECT 
    hub_state,
    channel_type,
	store_segment,
    delivery_status,
    ROUND(SUM(order_amount),2) total_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs, exec4.deliveries deliveries
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
and orders.delivery_order_id = deliveries.delivery_order_id
AND hub_state = "RJ"
AND delivery_status = "CANCELLED"
and channel_type = "Marketplace"
GROUP BY hub_state, store_segment, channel_type, delivery_status;


# 18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, algum hub_state teve total de valor do pedido superior a 100.000?


# 19- Em que data houve a maior média de valor do pedido (order_amount)? Dica: Pesquise e use a função SUBSTRING().


# 20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)? Dica: Use a função SUBSTRING().


