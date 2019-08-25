use master;
drop database stp;

-- criar e selecionar banco de dados
create database stp;
use stp;

-- primeiro exemplo
-- criar tabela usuario
create table tbl_usuario
(
codigo		decimal(5,0)	not null primary key,
nome		varchar(40)   	not null,
email		varchar(60)   	not null,
dt_cadastro	datetime		null default getdate()
);
select * from tbl_usuario;

-- criar Stored Procedure para inclusao de dados
go
create procedure sp_insereUsuario
	-- parametros recebidos na execução da stored procedure
	@vcod   decimal(5,0),
	@vnome  varchar(40),
	@vemail varchar(60)
as
	insert into tbl_usuario (codigo,nome,email,dt_cadastro)
	values (@vcod,@vnome,@vemail,default)
	print 'Usuário cadastrado com Sucesso';

-- executar Stored Procedure passando os parametros necessarios
exec sp_insereUsuario
@vcod = 12345,
@vnome = 'Marco',
@vemail = 'prof_marco@terra.com.br';

exec sp_insereUsuario
@vcod = 67890,
@vnome = 'Maria',
@vemail = 'prof_maria@terra.com.br';

-- verificando os dados cadastrados
select * from tbl_usuario;

-- forçando o erro - violando chave primaria
exec sp_insereUsuario
@vcod = 12345,
@vnome = 'Marco',
@vemail = 'prof_marco@terra.com.br';

-- criar Stored Procedure para inclusão de dados verificando a sua consistência
go
create procedure sp_insereUsuario2
	@vcod   decimal(5,0),
	@vnome  varchar(40),
	@vemail varchar(60)
as
	if @vcod <> 0 and @vnome <> '' and @vemail <> ''
	   begin
	   insert into tbl_usuario (codigo,nome,email,dt_cadastro)
	   values (@vcod,@vnome,@vemail,getdate())
	   print 'Usuário cadastrado com Sucesso'
	   end
	else
	   print 'Os valores devem ser corretamente preenchidos';

-- executar Stored Procedure com erro
exec sp_insereUsuario2
@vcod = 0,
@vnome = 'Marco',
@vemail = 'prof_torrex@terra.com.br';

select * from tbl_usuario;

exec sp_insereUsuario2
@vcod = 11111,
@vnome = '',
@vemail = 'prof_marco@terra.com.br';

select * from tbl_usuario;

exec sp_insereUsuario2
@vcod = 11111,
@vnome = 'Marco',
@vemail = '';

select * from tbl_usuario;

-- executar Stored Procedure certa
exec sp_insereUsuario2
@vcod = 22222,
@vnome = 'Marco',
@vemail = 'prof_marco@terra.com.br';

select * from tbl_usuario;

exec sp_insereUsuario2 33333,'Mario','mario@uol.com.br';
select * from tbl_usuario;

-- procedure consulta usuario
go
create procedure sp_procuraUsuario
    @vnome varchar(40)
as
	if @vnome <> '' 
		select * from tbl_usuario where nome  = @vnome
	else
		print 'Os valores devem ser corretamente preenchidos';

-- execucao certa
exec sp_procuraUsuario
@vnome = 'Mario'; 
-- ou --
exec sp_procuraUsuario 'Marco';

-- execucao errada
exec sp_procuraUsuario
@vnome = ''; 

-- procedure deleta usuário
go
create procedure sp_deletaUsuario
    @vcod decimal(5,0)
as
	if @vcod <> 0 
	   begin
	   delete from tbl_usuario where codigo  = @vcod
	   print 'Usuário excluído'
	   end
	else
	   print 'Os valores devem ser corretamente preenchidos';

-- execucao certa
exec sp_deletaUsuario
@vcod = 33333; 
-- ou --
exec sp_deletaUsuario '33333';

create table tbl_produtos
(
codigo		decimal(5,0)	not null primary key,
nome		varchar(40)   	not null,
preco		decimal(7,2)   	not null,
);
select * from tbl_produtos;

insert into tbl_produtos values (1,'Memoria',100.00);
insert into tbl_produtos values (2,'Mouse',15.00);
insert into tbl_produtos values (3,'Monitor',200.00);
insert into tbl_produtos values (4,'HD',190.00);
select * from tbl_produtos;

-- procedure projecao de valores em intervalo de produtos
go
create procedure sp_calculareajuste
    @vproini decimal(5,0),
	@vprofim decimal(5,0)
as
	if @vproini > 0 and @vprofim > 0
	    begin
		select nome, preco, preco + (preco * 0.2) 'Preco Reajustado'
		from tbl_produtos 
		where codigo >= @vproini and codigo <= @vprofim
		end
	else
		print 'Os valores devem ser corretamente preenchidos';

-- execucao certa
exec sp_calculareajuste 2,3;
exec sp_calculareajuste 1,10;

-- execucao errada
exec sp_calculareajuste 0,2;

-- Utilidade Publica :)
-- Localizando Stored Procedures
Select name From sys.objects Where type = 'P';

-- Localizando Tables
Select name From sys.objects Where type = 'U';

-- Localizando Views
Select name From sys.objects Where type = 'V';

-- Localizando Triggers
Select name From sys.objects Where type = 'T';






