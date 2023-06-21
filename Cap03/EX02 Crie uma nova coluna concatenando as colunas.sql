create table cap03.tb_dados4
as
select 
classe,
idade,
menopausa,
tamanho_tumor,
concat(inv_nodes, '-', quadrante) as posicao_tumor,
node_caps,
deg_malig,
seio
irradiando
from cap03.tb_dados;