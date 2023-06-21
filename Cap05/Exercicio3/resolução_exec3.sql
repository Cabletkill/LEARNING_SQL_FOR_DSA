select distinct(modalidade)
from exec3.atletas
order by 1;

#############################
#1-Quem são os técnicos (coaches) eatletas das equipes de Handball?
#############################

select nome_atleta, nome_treinador, A.modalidade
from exec3.atletas as A inner join exec3.treinadores as T
on A.pais_origem = T.pais_origem
where A.modalidade = 'Handball';

## 2° forma
select nome_atleta, T.pais_origem, nome_treinador, A.modalidade
from exec3.atletas as A, exec3.treinadores as T
where A.modalidade = T.modalidade
and A.modalidade ='Handball'
order by nome_treinador asc;

##########################
#2-Quem são os técnicos (coaches) dos atletas da Austrália que receberam medalhas de Ouro?
##########################
select nome_treinador, ouro
from treinadores as T inner join medalhas as M
on T.pais_origem = M.pais_time
where T.pais_origem = 'Austrália'
order by nome_treinador;

##########################
#3-Quais países tiveram mulheres conquistando medalhas de Ouro?
##########################


##########################
#4-Quais atletas da Noruega receberam medalhas de Ouro ou Prata?
##########################



##########################
#5-Quais atletas Brasileiros não receberam medalhas?
##########################
 
 