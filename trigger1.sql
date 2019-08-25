create database fib;

-- selecionar banco de dados
use fib;

-- criar tabela de funcionários
create table cadfun
(codfun  int         	not null primary key,
 nome    varchar(40) 	not null,
 depto   varchar(2)		null,
 funcao  varchar(20)	null,
 salario decimal(10,2)	null);

 -- inserir registros na tabela funcionários
insert into cadfun values (10,'Carlos','3','Vendedor',1530.00);
insert into cadfun values (20,'Alberto','2','Caixa',730.00);
insert into cadfun values (30,'Joao','2','Vendedor',1530.00);
insert into cadfun values (40,'Pedro','1','Programador',730.00);
select * from cadfun;

-- Validar a inclusão de funcionários
go
create trigger tr_ins_cadfun on cadfun
for insert
as
if (select count(*) from inserted) = 1
   print 'registro inserido com sucesso';
go


insert into cadfun values (50,'Maria','3','Programador',830.00);

go
-- Impedir a exclusão de funcionarios
create trigger tr_impedirdel_cadfun on cadfun
for delete
as
if (select count(*) from deleted) = 1
   begin
   raiserror('Funcionário não pode ser excluído',16,1);
   rollback transaction;
   end
go

select * from cadfun;

delete from cadfun where codfun = 50; 

drop trigger tr_impedirdel_cadfun;

delete from cadfun where codfun = 50; 

select * from cadfun;

-- Conferindo o que foi alterado
go
create trigger tr_altera_cadfun on cadfun
for update
as
if (select count(*) from deleted) <> 0
    begin
    Select * from deleted;  -- antes da alteração
    Select * from inserted; -- depois da alteração
    end
go

select * from cadfun;
update cadfun set nome = 'Mara' where codfun = 20;



