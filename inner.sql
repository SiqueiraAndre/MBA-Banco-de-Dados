create database aulahoje;
use aulahoje;

-- exemplo 1
create table gravadora
(
cod_gravadora	int			not null,
gravadora		varchar(40)	not null,
primary key(cod_gravadora)
);

insert into gravadora values (1,'EMI');
insert into gravadora values (2,'SOM LIVRE');

create table cd
(
cod_cd			int			not null,
nome_cd			varchar(30) not null,
cod_gravadora	int			not null,
primary key(cod_cd),
foreign key(cod_gravadora) references gravadora(cod_gravadora)
);

insert into cd values (1,'rock1',1);
insert into cd values (2,'rock2',1);
insert into cd values (3,'rock',2);

select * from gravadora;
select * from cd;

select a.cod_cd,a.nome_cd,b.gravadora
from cd a INNER JOIN gravadora b 
ON a.cod_gravadora = b.cod_gravadora;

--exemplo2
create table empregados( 
codigo_empregado int, 
nome varchar(50) 
); 

create table pagamentos( 
codigo_pagto int, 
codigo_empregado int, 
valor decimal(10,2) 
) ;

create table descontos( 
codigo_desconto int, 
codigo_empregado int, 
valor decimal(10,2) 
);

insert into empregados(codigo_empregado,nome) values(1,'Luis'); 
insert into empregados(codigo_empregado,nome) values(2,'Marina'); 
insert into empregados(codigo_empregado,nome) values(3,'Letícia'); 
insert into empregados(codigo_empregado,nome) values(4,'Gustavo');
insert into empregados(codigo_empregado,nome) values(5,'Mateus');
 
insert into pagamentos(codigo_empregado,valor) values(1,100); 
insert into pagamentos(codigo_empregado,valor) values(1,200); 
insert into pagamentos(codigo_empregado,valor) values(3,300); 
insert into pagamentos(codigo_empregado,valor) values(5,400); 
insert into pagamentos(codigo_empregado,valor) values(5,500);
 
insert into descontos(codigo_empregado,valor) values(1,50); 
insert into descontos(codigo_empregado,valor) values(2,20);
insert into descontos(codigo_empregado,valor) values(5,30);

select e.codigo_empregado,e.nome,p.valor
from empregados e INNER JOIN pagamentos p 
ON e.codigo_empregado = p.codigo_empregado;

select e.nome, p.valor 'pagamento', d.valor 'desconto'
from empregados e INNER JOIN pagamentos p 
ON e.codigo_empregado = p.codigo_empregado 
INNER JOIN descontos d 
ON e.codigo_empregado = d.codigo_empregado;



