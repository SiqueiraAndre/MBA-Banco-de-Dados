create table caixa
(
data		datetime,
saldo_inicial	decimal(10,2),
saldo_final	decimal(10,2)
);
go

insert into caixa values ('21/08/2017',100,100);
go

select * from caixa;

create table vendas
(
data	datetime,
codigo	int,
valor	decimal(10,2)
);
go

-- Trigger para insert na tabela de vendas
create trigger tgr_vendas_ai
on vendas
for insert
as
begin
   declare
   @valor decimal(10,2),
   @data  datetime;

   select @data = data, @valor = valor from inserted;

   update caixa set saldo_final = saldo_final + @valor
   where data = @data;
end
go

select * from caixa;
select * from vendas;

insert into vendas values ('21/08/2017',1,10);

select * from caixa;
select * from vendas;

go
create trigger tgr_vendas_as
on vendas
for delete
as
begin
      declare
      @valor decimal(10,2),
      @data  datetime;

      select @data = data, @valor = valor from deleted;

       update caixa set saldo_final = saldo_final - @valor
       where data = @data;
end
go

select * from caixa;
select * from vendas;

delete from vendas where codigo = 1;
go

select * from caixa;
select * from vendas;





