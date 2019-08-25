-- Correção exercício aula 6
use stp;

create table tbl_cliente
(
codigo		int				not null primary key,
nome		varchar(40)   	not null,
saldo		decimal(7,2)   	not null,
);

insert into tbl_cliente values (1,'Marco',100.00);
insert into tbl_cliente values (2,'Aurelio',100.00);
insert into tbl_cliente values (3,'Antunes',100.00);
select * from tbl_cliente;

create table movi
(
data		datetime        default getdate(),
valor       decimal(7,2)	not null,
codigo		int				not null 
);
select * from movi;

go
create procedure sp1
	-- parametros recebidos na execução da stored procedure
	@vcod    int,
	@vvalor  decimal(7,2),
    @op      varchar(1)
as
    if @op = 'D'
	begin
	insert into movi values (default,@vvalor,@vcod)
	update tbl_cliente set saldo = saldo + @vvalor 
	where codigo = @vcod
	end
    if @op = 'S'
	begin
	insert into movi values (default,@vvalor,@vcod)
	update tbl_cliente set saldo = saldo - @vvalor 
	where codigo = @vcod
	end

select * from tbl_cliente
select * from movi

exec sp1 1,100,'D'
exec sp1 2,10,'S'

select * from tbl_cliente
select * from movi

----
create table tbl_usuario
(codigo		decimal(5,0)	not null primary key,
 nome		varchar(40)   	not null,
 email		varchar(60)   	not null,
 dt_cadastro	datetime	null default getdate()
 );

-- criar Stored Procedure para inclusao de dados
go
create procedure sp_insereUsuario
	-- parametros recebidos na execução da stored procedure
	@vcod  decimal(5,0),
	@vnome varchar(40),
	@vemail varchar(60)
as
	insert into tbl_usuario (codigo,nome,email,dt_cadastro)
	values (@vcod,@vnome,@vemail,DEFAULT)
	print 'Usuário cadastrado com Sucesso'

-- executar Stored Procedure passando os parametros necessarios
exec sp_insereUsuario 12345,'Marco','prof_marco@terra.com.br';
exec sp_insereUsuario 67890,'Maria','prof_maria@terra.com.br';
exec sp_insereUsuario 22222,'Marco','prof_marco@terra.com.br';
exec sp_insereUsuario 33333,'Mario','mario@uol.com.br';
exec sp_insereUsuario 44444,'Marco','prof_marco@terra.com.br';
exec sp_insereUsuario 55555,'Mario','mario@uol.com.br';
select * from tbl_usuario;

go
create procedure sp_ExemploIF2
   -- parametros recebidos
   @vnome1 Varchar(40),
   @vnome2 Varchar(40)
as
   -- declarar variaveis locais
   declare @totnome1 int, @totnome2 int
   declare @mensagem char(100)

   -- captura o valor de cada variavel desde que a condicao seja valida
   set @totnome1 = (select count(nome) from tbl_usuario where nome=@vnome1)
   set @totnome2 = (select count(nome) from tbl_usuario where nome=@vnome2)

   -- teste de execucao
   if (@totnome1) > (@totnome2)
      begin
      set @mensagem = 'O Número de ocorrências do primeiro nome é maior'
      print(@mensagem)
      print @vnome1
	  print @totnome1
      end
   else if (@totnome1) < (@totnome2)
      begin
      set @mensagem = 'O número de ocorrências do segundo nome é maior'
	  print(@mensagem)
      print @vnome2
	  print @totnome2
      end
   else
      begin
      set @mensagem = 'O número de ocorrências dos dois nomes é igual'
      print(@mensagem)
      end

exec sp_ExemploIF2
@vnome1 = 'Marco', 
@vnome2 = 'Mario' 
--ou 
exec sp_ExemploIF2 'MARCO','MARIO'
-- O SQL por padrão NÂO é key sensitive

--- procedure com Looping
--  e gravando resultado em tabela
create table somanaturais
(
contador int,
soma	 int
);

go
create procedure usp_CalculaSoma
   -- parametros recebidos
   @numero int
as
   -- declarar variaveis locais
   declare @contador int
   declare @soma int
   -- atribuindo valores a variaveis
   set @soma=0
   set @contador=1
   -- lopping
   while (@contador<=@numero)
     begin
     set @soma=@soma+@contador
     insert into somanaturais values (@contador,@soma)
     set @contador = @contador+1
     end

exec usp_CalculaSoma 100;

select * from somanaturais;

-----
go
create procedure grava_dados
   -- parametros recebidos
   @vcod  decimal(5,0),
   @vnome varchar(40),
   @vemail varchar(60)
as
   -- declarar variaveis locais
   declare @contador int
   -- atribuindo valores a variaveis
   set @contador=1
   -- lopping
   while (@contador<=20)
     begin
	 insert into tbl_usuario (codigo,nome,email,dt_cadastro)
	 values (@vcod,@vnome,@vemail,default)
	 print 'Usuário cadastrado com Sucesso'
     set @vcod = @vcod + @contador;
	 set @contador = @contador+1
     end

exec grava_dados 10000,'Silas','silas@uol.com.br';
select * from tbl_usuario;


-----
-- testar banco de dados e status
-- uma stored procedure nao precisa de variaveis ou parametros para ser ececutada
go
create procedure uspBancos
as
   select Database_ID, Name, State_Desc from sys.databases;
    
exec uspBancos

-- Criar tabela dos exemplos 
create table funcionarios
(
codigo	varchar(5),
nome	varchar(80),
funcao	int,
depto	int,
salario	decimal(8,2),
primary key(codigo)
);

-- Inserções para a tabela de FUNCIONARIOS
insert into FUNCIONARIOS values('00001','OSCAR DA SILVA', '5','30', 2500);
insert into FUNCIONARIOS values('00002','JOÃO DA SILVA ', '5','30', 3500);
insert into FUNCIONARIOS values('00003','MARIA DA SILVA', '7','20',1500);
insert into FUNCIONARIOS values('00004','BENEDITO ARAUJO', '7','10',1500);
insert into FUNCIONARIOS values('00005','PEDRO ALVES', '5','30',1500);
select * from funcionarios;

-- Procedure para mostrar a soma dos salários da tabela FUNCIONARIOS
go
create procedure sp_somasalario 
as
   -- variavel local
   declare @sal_total decimal(10,2)
   -- verificando
   select @sal_total=sum(salario) from funcionarios
   print 'Salário total R$'+(cast(@sal_total as varchar(20)))

exec sp_somasalario;  
 
-- Procedure para mostrar a soma dos salários e aplicar estrutura de decisão
go
create procedure sp_somasalario2 
as
   -- variavel local
   declare @soma decimal(10,2)
   -- verificando
   select @soma=sum(salario) from funcionarios
   if @soma < 20000 
	  begin
	  print '***GASTO SALARIAL DENTRO DO ORÇAMENTO***** '
	  print 'Salário total R$'+(cast(@soma as varchar(20)))
	  end
   else
	  begin
	  print '***GASTO SALARIAL ACIMA DO ORÇAMENTO***** '
	  print 'Salário total R$'+(cast(@soma as varchar(20)))
	  end

exec sp_somasalario2

-- Procedure com passagem de parâmetro para mostrar a soma dos salários por depto
go
create procedure sp_somasal_depto
   -- recebe parametro
   @vdepto int  
as
   -- variavel local
   declare @soma decimal(10,2)
   -- verificando
   select @soma=sum(salario) 
   from funcionarios 
   where depto=@vdepto
   print 'Salário total do departamento '+ cast(@vdepto as varchar)+ 
   ' é R$'+(CAST(@soma as varchar(20)))

exec sp_somasal_depto 30;

--Procedure para alterar registro
go

create procedure sp_AlteraReg
   -- recebe parametro
   @vcod varchar(5),
   @vnome varchar(80)
as 
   -- alterando
   update funcionarios
   set nome = @vnome
   where codigo = @vcod

select * from funcionarios;

exec sp_AlteraReg
@vcod = '00004',
@vnome = 'BENEDITO DA SILVA'

select * from funcionarios;

-- Procedure para importar dados para tabela temporaria
create table tempfunc
(
nome	varchar(50),
salario decimal(8,2)
);

go
create procedure sp_importadados
   as
   -- importando dados dentro dos parametros fixos
   insert into tempfunc(nome,salario)
   select nome,salario 
   from funcionarios
   where salario > 1500 and salario < 3500;

exec sp_importadados
select * from tempfunc;

--Procedure para importar dados para tabela temporaria com parametros
create table tempfunc2
(
nome	varchar(50),
salario decimal(8,2)
);

go
create procedure sp_importadados2
   -- recebe parametro
   @vini decimal(8,2),
   @vfim decimal(8,2)
as
   insert into TempFunc2(nome,salario)
   select nome,salario from funcionarios
   where salario > @vini and salario < @vfim

exec sp_ImportaDados2 1500,3500
select * from tempfunc2;
