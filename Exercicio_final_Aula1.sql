-- Aluno: Andre Felipe Siqueira
-- RA: 48974
-- Turma IV - P—s Eng. Software

-- criar banco de dados
create database MERCADO;

-- abrindo banco de dados
use MERCADO;

-- criando tabelas 
create table CLIENTES	(
ID_cliente			int not null,
cliente		varchar(50)not null,	
email		varchar(50)not null,	
telefone	varchar(20)not null,	
primary key(ID_cliente)
);

create table FORNECEDORES	(
ID_fornecedor			int not null,	
razaosocial		varchar(50) not null,	
telefone	varchar(20) not null,
email		varchar(50) not null,	
contato		varchar(50) not null,	
primary key(ID_fornecedor)
);

create table CONVENIOS		(
ID_convenio		int not null,		
tipo			varchar(50) not null,	
valordesconto	decimal(7,2)	not null,	
primary key(ID_convenio	)
);

create table PRODUTOS	(
ID_produto		int not null,			
produto			varchar(50) not null,	
preco			decimal(7,2)	not null,	
dt_validade		date	not null,	
ID_fornecedor	int not null,
primary key(ID_produto),
foreign key(ID_fornecedor) references FORNECEDORES(ID_fornecedor)
);

create table FUNCIONARIOS		(
ID_funcionario		int not null,		
nome				varchar(50) not null,	
cargo				varchar(20) not null,
primary key(ID_funcionario	)
);

create table PEDIDO		(
ID_pedido			int not null,		
datapedido			date	not null,
valortotal			decimal(7,2)	not null,
ID_cliente			int not null,
ID_funcionario		int not null,
ID_convenio			int not null,	
primary key(ID_pedido	),
foreign key(ID_cliente) references CLIENTES(ID_cliente),
foreign key(ID_funcionario) references FUNCIONARIOS(ID_funcionario),
foreign key(ID_convenio) references CONVENIOS(ID_convenio)
);

create table ITENSPEDIDO	(
ID_pedido		int not null,			
ID_produto		int not null,			
precounitario	decimal(7,2)	not null,	
quantidade		decimal(7,2)	not null,	
total			decimal(7,2)	not null,	
primary key(ID_pedido,ID_produto),
foreign key(ID_pedido) references PEDIDO(ID_pedido),
foreign key(ID_produto) references PRODUTOS(ID_produto)
);


-- inserindo registros nas tabelas

insert into CLIENTES values(1,'Fabio', 'fabio@fib.br' ,'(14)3214-6070');
insert into CLIENTES values(2,'Elcio', 'elcio@fib.br' ,'(14)3233-8161');
insert into CLIENTES values(3,'Thiago','thiago@fib.br','(14)3294-6482');
insert into CLIENTES values(4,'Rafael','rafael@fib.br','(14)3284-6593');


insert into FORNECEDORES values(1,'Carrefour','(14)4352-5120','joao@carrefour.com', 'Joao Silva' );
insert into FORNECEDORES values(2,'Makro'    ,'(14)2221-8781','santos@makro.com.br', 'Santos Neves' );
insert into FORNECEDORES values(3,'Confiança','(14)7889-8882','feranda@confianca.com.br', 'Fernanda Moraes' );
insert into FORNECEDORES values(4,'Atacadão' ,'(14)6332-8853','pamela@atacadao.com', 'Pamela Brazil' );
		

insert into CONVENIOS values(1,'Atacado',25.0);
insert into CONVENIOS values(2,'Varejo',5.0);


insert into PRODUTOS values (1,'lasanha',8.90, '2019-08-31',1);
insert into PRODUTOS values (2,'bacon'  ,7.75, '2019-10-01',2);
insert into PRODUTOS values (3,'presuto',5.90, '2019-09-15',3);
insert into PRODUTOS values (4,'queijo' ,6.75, '2019-09-25',4);
insert into PRODUTOS values (5,'mortadela',3.90, '2019-08-25',2);
insert into PRODUTOS values (6,'frango'   ,9.55, '2019-09-04',4);	


insert into FUNCIONARIOS values(1,'Joao','Vendedor');
insert into FUNCIONARIOS values(2,'Carlos','Gerente');
insert into FUNCIONARIOS values(3,'Pedro','Caixa');
insert into FUNCIONARIOS values(4,'Maria','Caixa');


insert into PEDIDO values(1,'2019-08-25',1000 ,2,3,1);
insert into PEDIDO values(2,'2019-08-26',350  ,1,2,2);
insert into PEDIDO values(3,'2019-08-27',558  ,3,4,2);
insert into PEDIDO values(4,'2019-08-29	',1250,4,1,1);	
insert into PEDIDO values(5,'2019-08-29',741  ,1,2,2);
insert into PEDIDO values(6,'2019-08-30',2500.88,4,1,1);	


insert into ITENSPEDIDO values(1,3,5.90,10,59.0);	
insert into ITENSPEDIDO values(2,4,6.75,5,33.75);	
insert into ITENSPEDIDO values(3,1,8.90,20,178);	
insert into ITENSPEDIDO values(4,2,9.55,15,143.25);	
		