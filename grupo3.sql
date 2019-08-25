create database fib3;
use fib3;

create table produtos(
id			int				not null,
nome		varchar(30)		not null,
fabricante	varchar(30)		not null,
quantidade	int				not null,
vlunitario	decimal(7,2)	not null,
tipo		varchar(20)		not null
);

insert into produtos values (1,'playstation3','sony',100,1999,'console');
insert into produtos values (2,'core 2 duo','dell',200,1899,'notebook');
insert into produtos values (3,'xbox 360','microsoft',350,1299,'console');
insert into produtos values (4,'gt 16220 quad','samsung',300,499,'celular');
insert into produtos values (5,'iphone 4','apple',50,1499,'smartphone');
insert into produtos values (6,'playstation2','sony',100,399,'console');
insert into produtos values (7,'sofa estofado','brasilar',200,499,'sofa');
insert into produtos values (8,'armario','tapapinus',50,129,'armario');
insert into produtos values (9,'wi 120gb','nintendo',250,999,'console');
select * from produtos;

-- quantidade de produtos em estoque de cada TIPO - agrupamento por tipo
select tipo, sum(quantidade) as 'Quantidade em Estoque'
from Produtos
group by tipo;

-- produto mais caro em estoque de cada TIPO - agrupamento por tipo
select tipo, max(vlunitario) as 'Produto com maior preco'
from Produtos
group by tipo;

-- quantidade de produtos em estoque por fabricante
select fabricante, sum(quantidade) as 'Quantidade em Estoque'
from produtos
group by fabricante;

-- quantidade de produtos em estoque por tipo/fabricante (grupo/subgrupo)
select tipo, fabricante, sum(quantidade) as 'Quantidade em Estoque'
from produtos
group by tipo, fabricante
order by tipo;

-- valor do estoque em mercadorias por tipo
select tipo, sum(quantidade * vlunitario) as 'Valor do Estoque'
from produtos
group by tipo;

-- valor do estoque em mercadorias por tipo/fabricante
select tipo, fabricante, sum(quantidade * vlunitario) as 'Valor do Estoque'
from produtos
group by tipo,fabricante;

-- mostrar a quantidade em estoque por tipos com saldo maior que 200
select tipo, sum(quantidade) as 'Quantidade em Estoque'
from produtos
group by tipo
having sum(quantidade) > 200;

-- mostrar o valor médio dos preços por tipo
select tipo, avg(vlunitario) as 'Valor medio'
from produtos
group by tipo
having tipo = 'console';

-- mostrar a quantidade em estoque por tipos e fabricantes com saldo maior que 200
select tipo, fabricante, sum(quantidade) as 'Quantidade em Estoque'
from produtos
group by tipo, fabricante
having sum(quantidade) > 200
