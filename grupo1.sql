create database fib;
use fib;

create table grupo(
codgrupo	int			not null,
grupo		varchar(20)	not null,
primary key(codgrupo)
);

insert into grupo values (10,'verdura');
insert into grupo values (20,'legumes');
insert into grupo values (30,'frutas');
insert into grupo values (40,'granja');
select * from grupo;

create table produtos(
codproduto	int				not null,
codgrupo	int				not null,
produto		varchar(30)		not null,
preco		decimal(6,2)	not null,
primary key(codproduto),
foreign key(codgrupo) references grupo(codgrupo)
);

insert into produtos values(1,10,'alface',5.30)
insert into produtos values(2,20,'abobrinha',3.30)
insert into produtos values(3,30,'morango',4.30)
insert into produtos values(4,10,'rucula',2.30)
insert into produtos values(5,20,'pepino',6.30)
insert into produtos values(6,30,'maca',9.30)
insert into produtos values(7,30,'uva',9.99)
insert into produtos values(8,20,'batata',4.99)
insert into produtos values(9,10,'repolho',1.99)
insert into produtos values(10,20,'cebola',4.99)
select * from produtos;

-- uniao de tabelas e ordenando o resultado por grupo
select produtos.codgrupo, grupo.grupo, produtos.produto
from produtos, grupo
where produtos.codgrupo = grupo.codgrupo
order by produtos.codgrupo;

-- uniao de tabelas e ordenando o resultado por grupo
-- classificando por grupo e ordem alfabética de produtos
select produtos.codgrupo, grupo.grupo, produtos.produto
from produtos, grupo
where produtos.codgrupo = grupo.codgrupo
order by grupo.grupo, produtos.codgrupo;

-- mesma sintaxe anterior
-- filtrando preços menores que 5
select grupo.grupo, produtos.produto, produtos.preco
from produtos, grupo
where (produtos.codgrupo = grupo.codgrupo) and produtos.preco < 5
order by grupo.grupo, produtos.codgrupo;

-- mesma sintaxe anterior
-- classificando preços em ordem decrescente
select grupo.grupo, produtos.produto, produtos.preco
from produtos, grupo
where (produtos.codgrupo = grupo.codgrupo) and produtos.preco < 5
order by grupo.grupo, produtos.preco desc;
