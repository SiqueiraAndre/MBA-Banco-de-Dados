-- abrindo banco de dados
use posfib;

-- criando view
create view vwprodutos as  
  select codprod   	as 'Codigo', 
		produto,
		preco		as 'Preco Atual',
		preco * 1.1	as 'Preco com reajuste',
        codfor
  from produtos
  where	codprod > 2;

-- alterando view
alter view vwprodutos as
  select codprod, produto, preco * 1.1	as 'Preco com reajuste'
  from produtos;

 
