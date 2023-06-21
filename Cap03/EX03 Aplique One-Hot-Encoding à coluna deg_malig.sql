select*
from cap03.tb_dados;

create table cap03.tb_dados5
as
select 
classe,
idade,
menopausa,
tamanho_tumor,
node_caps,
case when deg_malig = 1 then 1 else 0 end as deg_malig_cat1,
case when deg_malig = 2 then 1 else 0 end as deg_malig_cat2,
case when deg_malig = 3 then 1 else 0 end as deg_malig_cat3,
seio, 
irradiando
  
from cap03.tb_dados;


