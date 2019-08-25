create database fib;
use fib;


create table contacorrente
(
nconta	int			not null,
cliente varchar(40)	not null,
saldo	decimal(7,2)not null
);

insert into contacorrente values (1,'Marco',1000);
insert into contacorrente values (2,'Aurelio',500);
insert into contacorrente values (3,'Antunes',750);
select * from contacorrente;

create table movicc
(
nconta		int			 not null,
dt_mov		datetime	 not null,
valor		decimal(7,2) not null,
Operacao	varchar(1)   not null
);
select * from movicc;

go
create trigger tr_ins_cc 
on contacorrente
for insert
as 
if (select count(*) from inserted) = 1
   Print 'Cliente Cadastrado com Sucesso!!'
go

insert into contacorrente values (4,'Tiburcio',5110);

go
create trigger tr_movicc_dep
on movicc
for insert
as
begin
   declare
   @nconta int,
   @dt_mov datetime,
   @operacao varchar(1),
   @valor decimal(7,2)

   select @nconta = nconta, @dt_mov = dt_mov, @operacao = Operacao, @valor = valor from INSERTED
   where Operacao = 'D' 

   update contacorrente set saldo = saldo + @VALOR
   where nconta = @nconta

   print 'Deposito realizado com sucesso'
end
go


insert into movicc values (1,'05/09/2016',500,'D');

select * from contacorrente;
select * from movicc;

go
create trigger tr_movicc_saq
on movicc
for insert
as
begin
   declare
   @nconta int,
   @dt_mov datetime,
   @operacao varchar(1),
   @valor decimal(7,2)

   select @nconta = nconta, @dt_mov = dt_mov, @operacao = Operacao, @valor = valor from INSERTED
   where Operacao = 'S' 

   update contacorrente set saldo = saldo - @VALOR
   where nconta = @nconta

   print 'Saque realizado com sucesso'
end
go
