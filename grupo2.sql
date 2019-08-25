create database fib2;
use fib2;

create table grupo(
codgrupo	int			not null,
grupo		varchar(10) not null
);
insert into grupo values (1,'doces');
insert into grupo values (2,'salgados');
select * from grupo;

create table subgrupo(
codsub		int			not null,
subgrupo	varchar(10)	not null
);
insert into subgrupo values (1,'nestle');
insert into subgrupo values (2,'lacta');
insert into subgrupo values	(3,'sadia');
insert into subgrupo values	(4, 'aurora');
select * from subgrupo;

create table produtos(
codproduto	int				not null,
codgrupo	int				not null,
codsub		int				not null,
produto		varchar(40)		not null,
preco		decimal(6,2)	not null
);

insert into produtos values (1,1,1,'caixa bombom',8)
insert into produtos values (2,1,1,'alpino',3)
insert into produtos values (3,1,2,'puro leite',3.5)
insert into produtos values (4,1,2,'laka',3.5)
insert into produtos values (5,2,3,'presunto',4.18)
insert into produtos values (6,2,3,'queijo',5.25)
insert into produtos values (7,2,4,'lasanha',5.5)
insert into produtos values (8,2,4,'pizza',6.5)
insert into produtos values (9,2,4,'bacon',7.5)
select * from produtos

-- mostrar os grupos cadastrados
select codgrupo
from produtos
group by codgrupo;

-- mostrar quantidade de produtos cadastrados em cada grupo
select codgrupo, count(*)
from produtos
group by codgrupo;

-- soma do preço dos produtos de cada grupo
select codgrupo,sum(preco)
from produtos
group by codgrupo;

-- mostrar os subgrupos de cada grupo
select codgrupo,codsub
from produtos
group by codgrupo,codsub;

-- mostrar quantidade de produtos cadastrados em cada subgrupo
select codgrupo, codsub, count(*)
from produtos
group by codgrupo,codsub;

-- mostrar quantidade de produtos cadastrados em cada subgrupo
select codgrupo, codsub, max(preco)
from produtos
group by codgrupo,codsub;

-- mostrar os produtos classificados por grupos e subgrupos
select grupo.grupo, subgrupo.subgrupo,produtos.produto,produtos.preco
from grupo, subgrupo, produtos
where produtos.codgrupo = grupo.codgrupo and produtos.codsub = subgrupo.codsub
order by grupo, subgrupo





