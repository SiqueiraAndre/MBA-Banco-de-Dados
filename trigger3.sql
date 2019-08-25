-- criando tabela de auditoria - geral
create table auditoria
( usuario varchar(40),
  acao    varchar(9),
  data    datetime,
  codigo  int);

-- criando tabela de auditoria - insert
create table auditoria1
( usuario varchar(40),
  acao    varchar(9),
  data    datetime,
  codigo  int);

-- criando tabela de auditoria - update
create table auditoria2
( usuario varchar(40),
  acao    varchar(9),
  data    datetime,
  codigo  int);


-- criando tabela de auditoria - delete
create table auditoria3
( usuario varchar(40),
  acao    varchar(9),
  data    datetime,
  codigo  int);

go
create trigger tr_auditor 
on cadfun 
for insert, update, delete
as
begin
    insert into auditoria select
    suser_Sname(),
    'MANUT',
    getdate(),
    codfun
    from inserted
end

go
create trigger tr_auditor1 
on cadfun 
for insert 
as
begin
    insert into auditoria1 select
    suser_Sname(),
    'INSERT',
    getdate(),
    codfun
    from inserted;
end

go
create trigger tr_auditor2 
on cadfun 
for update 
as
begin
    insert into auditoria2 select
    suser_Sname(),
    'UPDATE',
    getdate(),
    codfun
    from inserted;
end

go
create trigger tr_auditor3
on cadfun 
for delete 
as
    begin
    insert into auditoria3 select
    suser_Sname(),
    'DELETE',
    getdate(),
    codfun
    from deleted;
end

-- verificando as triggers existentes na tabela
select OBJECT_NAME(parent_id) as tabela,* 
from sys.triggers
where OBJECT_NAME(parent_id) = 'cadfun';


-- excluindo a trigger que impede deleção de registros
drop trigger tr_impedirdel_cadfun;


-- Testando as triggers de auditoria
-- inserindo novo registro
insert into cadfun values(100,'Marinalva','4','Programador',1200.00);

-- alterando registros
update cadfun set salario = 1600
where codfun = 100;

-- excluindo registro
delete from cadfun where codfun = 20;

select * from cadfun;
select * from auditoria;
select * from auditoria1;
select * from auditoria2;
select * from auditoria3;

drop trigger tr_ins_cadfun;
drop trigger tr_altera_cadfun;
drop trigger tr_impedirdel_cadfun
drop trigger tr_auditor;
drop trigger tr_auditor1;
drop trigger tr_auditor2;
drop trigger tr_auditor3;


-- mostra todos os banco de dados da máquina
SELECT name, database_id, create_date  
FROM sys.databases ;  
GO 

-- mostra todas as tabelas do banco de dados
SELECT * FROM SYSOBJECTS WHERE XTYPE='U' 



