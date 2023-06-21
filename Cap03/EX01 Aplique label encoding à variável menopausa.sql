select distinct menopausa
from cap03.tb_dados;

create table cap03.tb_dados3
as
SELECT 
classe, 
idade,  
case 
	when menopausa = "premeno" then 01
    when menopausa = "ge40" then 02
    when menopausa = "lt40" then 03
  end as menopausa,  
tamanho_tumor,
inv_nodes,
node_caps,
deg_malig,
seio,
quadrante,
irradiando

FROM cap03.tb_dados;