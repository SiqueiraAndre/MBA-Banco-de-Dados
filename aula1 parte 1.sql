-- criar banco de dados
create database posfib;

-- abrindo banco de dados
use posfib;

-- criando tabelas // entidades
create table alunos(
id			int,
aluno		varchar(40),
telefone	varchar(20),
idade		int			
);

-- apagando uma tabela
drop table alunos;

-- criando tabelas utilizando constraints
create table alunos(
id			int			not null,
aluno		varchar(40)	not null,
telefone	varchar(20)	null,
idade		int			null
primary key(aluno)
);

create table professores(
codprof	int			not null,
nome	varchar(40)	not null,
curso	varchar(20)	not null
primary key(codprof)
);

create table dependentes(
coddep	int			not null,	
nome	varchar(40)	not null,
codprof	int			not null
primary key(coddep),
foreign key(codprof) references professores(codprof)
);

-- estudo de caso 1
create table clientes(
codcli	int			not null,
nome	varchar(40) not null,
fone	varchar(20)	null
primary key(codcli)
);

insert into clientes values(1,'marco','3232=6070');
insert into clientes values(2,'ronaldo','3232=6171');

create table vendedor(
codven	int			not null,
nome	varchar(40) not null,
fone	varchar(20)	null
primary key(codven)
);
insert into vendedor values(1,'ana','3344-5566');
insert into vendedor values(2,'bia','4444-5556');

create table fornecedor(
codfor	int			not null,
empresa	varchar(40) not null,
fone	varchar(20)	null,
contato	varchar(40)	null,
primary key(codfor)
);
insert into fornecedor values(1,'sadia','8844-5566','pedro');
insert into fornecedor values(2,'aurora','9944-5556','paulo');

create table produtos(
codprod	int				not null,
produto	varchar(40)		not null,
preco	decimal(7,2)	not null,	
codfor	int				not null
primary key(codprod),
foreign key(codfor) references fornecedor(codfor)
);
insert into produtos values (1,'lasanha',8.90,1);
insert into produtos values (2,'bacon',7.75,2);
insert into produtos values (3,'presuto',5.90,1);
insert into produtos values (4,'queijo',6.75,1);

create table pedidos(
codped	int	not null,
codprod	int not null
primary key(codped),
foreign key(codprod) references produtos(codprod)
);
insert into pedidos values (1,1);
insert into pedidos values (2,1);
insert into pedidos values (3,3);
insert into pedidos values (4,4);

create table vendas(
codven		int				not null,
codcli		int				not null,
codped		int				not null,
valorvenda	decimal(8,2)	not null
primary key(codven),
foreign key(codcli) references clientes(codcli),
foreign key(codped) references pedidos(codped)
);

insert into vendas values(1,1,1,100);
insert into vendas values(2,2,1,200);
insert into vendas values(3,2,2,10);
insert into vendas values(4,1,3,233);

-- importar dados
create table autor
(
cod_autor	int			not null,
nome_autor	varchar(40)	not null,
fone_autor	varchar(20) null,
primary key(cod_autor)
);

insert into autor (cod_autor,nome_autor,fone_autor) values (1,'José','3262-000');
insert into autor (cod_autor,nome_autor) values (2,'João');
insert into autor (cod_autor,nome_autor,fone_autor) values (3,'Antonio',NULL);
insert into autor values (4,'Maria','3262-0000');
insert into autor values (5,'Pedro',NULL);

select * from autor;

create table autor_tmp
(
cod_autor	int			not null,
nome_autor	varchar(40)	not null,
fone_autor	varchar(20) null,
primary key(cod_autor)
);	
 -- importando dados, com campos correspondentes
insert into autor_tmp
select * from autor;

select * from autor_tmp;

create table autor_temp2
(
codigo		int			not null,
nome		varchar(40)	not null,
telefone	varchar(20) null,
email		varchar(18) null,
primary key(codigo)
);	
 
-- importando dados de campos não correspondentes
insert into autor_temp2(codigo,nome,telefone)
select cod_autor,nome_autor,fone_autor from autor;
 
-- verificando dados
select * from autor;
select * from autor_temp2;

create table autor_temp3
(
codigo	 int	     not null,
nome	 varchar(40) not null,
telefone varchar(20) null,
email	 varchar(18) null,
primary key(codigo)
);	

 -- importando dados de campos não correspondentes
insert into autor_temp3(codigo,nome,telefone)
select cod_autor,nome_autor,fone_autor from autor
where cod_autor <=2;
 
-- verificando dados
select * from autor;
select * from autor_temp3;

-- alterando dados
update autor_temp3 
set telefone = '99898-7788'
where codigo = 2;

select * from autor_temp2;
update autor_temp2
set telefone = '3234-9898', email='pedro@fib.com.br'
where codigo = 5;

-- excluindo dados
select * from autor_temp2;
delete from autor_temp2
where codigo = 3;
 
-- distinct
select * from autor;
-- forçando repetição para exemplo
update autor
set fone_autor = '9999-9999'
where cod_autor > 1;

select distinct fone_autor
from autor;

-- order by
select * from produtos;

select *
from produtos
order by produto;

select * 
from produtos
order by codfor,produto;

-- operadores
select * from produtos
where preco >=6  and preco <= 8
order by preco;

select * from produtos
where preco between 6  and 8
order by preco;

select * from produtos
where produto LIKE '%p%';
			
select * from produtos
where produto like '_a%';

select * from produtos
where codprod in(1,4);

-- calculos
select codprod, produto, preco, preco * 1.10 as 'preço com reajuste'
from produtos;

select codprod, produto, preco, preco * 1.10 'preço com reajuste'
from produtos;

-- funções de grupo
select count(*)  
from produtos;

select count(*)  
from produtos
where preco < 7;

select sum(preco)  
from produtos;

select sum(preco)  
from produtos
where codprod in(1,4);

select avg(preco) 
from produtos;
  
select avg(preco)
from produtos
where produto like '%queijo%';

select min(preco) 
from produtos;

select min(preco) 
from produtos
where codfor between 2 and 4;

select max(preco) 
from produtos;

select max(preco) 
from produtos
where codfor between 2 and 3;





 




















