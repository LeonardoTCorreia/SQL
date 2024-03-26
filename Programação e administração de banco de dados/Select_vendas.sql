--4.1 - Continuando sqls ?? 13/03

use vendas

--23.Consultar os pedidos que foram solicitados pelo cliente 2, registrados pelo funcionário 8 e conferidos pelo estagiário 5.

select *
from pedidos
where cli_codigo = 2 and fun_codigo = 8 and est_codigo = 5

--24.Consultar a quantidade de itens vendidos	

select count(*) [QTD_Itens_Vendidos]
from itens_pedidos

--25.Consultar a quantidade de pedidos do cliente 1.

select COUNT(*) [QTD_Pedidos_Cli_1]
from pedidos
where cli_codigo = 1

--26.	Consultar a quantidade de itens vendidos relacionada ao pedido 2.

select COUNT(*) [QTD_Vendida_Pedido_2]
from itens_pedidos
where ped_numero = 2

--27.	Consultar quantos pedidos foram registrados pelo funcionário 6

select COUNT(*) [QTD_Vendida_Fun_6]
from pedidos
where fun_codigo = 6

--28.	Consultar quantas vezes o produto 3 foi vendido.

select COUNT(*) [QTD_Vendida_Produto_3]
from itens_pedidos
where prd_codigo = 3

--29.	Consultar todas as pessoas.

select * from pessoas

--30.	Consultar todos os dados dos clientes.

select * from  pessoas p, clientes c
where p.pes_codigo = c.pes_codigo

--31.	Consultar nome, CPF, renda e crédito de todos os clientes.

select pessoas.pes_nome, pessoas.pes_cpf, clientes.cli_renda, clientes.cli_credito
from pessoas, clientes
where pessoas.pes_codigo = clientes.pes_codigo

--32.	Consultar os produtos (descrição) e as quantidades vendidas no pedido 1.

select produtos.prd_descricao, itens_pedidos.itp_qtd
from itens_pedidos, produtos
where 
	itens_pedidos.prd_codigo= produtos.prd_codigo and
	itens_pedidos.ped_numero = 1;

--33.	Consultar os produtos (descrição), quantidades vendidas, valores unitários e o valor de cada item do pedido 2.

select produtos.prd_descricao, itens_pedidos.itp_qtd, produtos.prd_valor, (itens_pedidos.itp_qtd * produtos.prd_valor) [valor_item]
from itens_pedidos, produtos
where 
	itens_pedidos.prd_codigo = produtos.prd_codigo and
	itens_pedidos.ped_numero = 2

--34.	Consultar número, data, nome do funcionário, nome do cliente e nome do estagiário de cada pedido.

SELECT 
    p.ped_numero, 
    p.ped_data, 
    fun.pes_nome [nome_funcionario],
    cli.pes_nome [nome_cliente],
    est.pes_nome [nome_estagiario]
FROM 
    pedidos p,
	pessoas fun,
	pessoas cli,
	pessoas est
where
	p.fun_codigo = fun.pes_codigo and
	p.cli_codigo = cli.pes_codigo and
	p.est_codigo = est.pes_codigo

--35.	Consultar código, nome, salário e o nome do supervisor de cada funcionário.

select 
	funcionarios.pes_codigo [codigo_funcionarios],
	funcionarios.pes_nome [nome_funcionario],
	f.fun_salario [salario_funcionario],
	sup.pes_nome [nome_supervisor]
from
	funcionarios f,
	pessoas funcionarios,
	pessoas sup
where
	f.pes_codigo = funcionarios.pes_codigo and
	f.sup_codigo = sup.pes_codigo

--36.	 Consultar o valor de cada item vendido.

select i. *, i.itp_qtd * itp_valor [Valor_Item]
from itens_pedidos i

--37.	Consultar o total vendido (faturado) até o momento.

select
	SUM (itp_qtd * itp_valor) As total_faturado
from
	itens_pedidos

--38.	Consultar o total da folha de pagamento dos supervisores.

select 
	SUM (fun_salario) As total_folha_pagamento
from
	funcionarios
where 
	sup_codigo is not null

--39.	Consultar o valor total do pedido 1.   

select
	SUM(itp_valor * itp_qtd) As valor_total_ped_1
from
	itens_pedidos
where
	ped_numero = 1

--40.	Consultar o total vendido do Produto 4

select
	SUM(itp_valor * itp_qtd) As valor_total_prd_4
from
	itens_pedidos
where
	prd_codigo = 4;

--5.1 poesia em SQL??

--41.	Consultar o valor total de cada pedido.

select
	ped_numero, SUM(itp_valor * itp_qtd) As valor_total_pedidos
from
	itens_pedidos
group by 
	ped_numero;

--42.	Consultar o total vendido do produto 3 em cada pedido.

select * from itens_pedidos

select i.ped_numero, i.prd_codigo, SUM(itp_qtd) [Total Vendido]
from itens_pedidos i, pedidos p
where
	i.ped_numero = p.ped_numero and
	prd_codigo = 3
	group by i.ped_numero, i.prd_codigo
	
--43.	Consultar os pedidos com valor total acima de R$ 30,00 reais.

select i.ped_numero, SUM(i.itp_qtd * i.itp_valor) [Valor_Item]
from itens_pedidos i
group by 
	i.ped_numero
having
	SUM(i.itp_qtd * i.itp_valor) > 30;

--44.	Consultar a quantidade de itens por pedido.

select ped_numero, COUNT(itp_qtd) [Qtd_Itens_por_pedido]
from itens_pedidos
group by
	ped_numero;

--45.	Consultar a quantidade de vezes que cada produto foi vendido.

select prd_codigo, COUNT(distinct ped_numero) As qtd_vendida
from itens_pedidos
group by prd_codigo

--46.	Consultar quantos pedidos cada cliente solicitou.

select cli_codigo, COUNT(*) [qtd_pedidos_clientes]
from 
	pedidos
group by
	cli_codigo

--47.	Consultar quantos pedidos cada funcionário registrou.   

select fun_codigo, COUNT(*) [qtd_pedidos_funcionarios]
from 
	pedidos
group by
	fun_codigo

--48.	Consultar os pedidos que possuem mais do que 3 itens.

SELECT ped_numero, COUNT(*) AS quantidade_itens
FROM itens_pedidos
GROUP BY ped_numero
having count(*) > 3

--49.	Consultar o produto mais vendido em quantidade de itens.

select top 1
	p.prd_codigo [codigo_produto],
	p.prd_descricao [item_mais_vendido],
	max(i.itp_qtd) [qtd_item]
from
	produtos p,
	itens_pedidos i
group by
	p.prd_codigo,
	p.prd_descricao
order by 
	max(i.itp_qtd);

--50.	Consultar os pedidos (ped_numero, ped_data) que possuem mais do que 3 itens.  Usar exists.


select 
	p.ped_numero, 
	p.ped_data
from
	pedidos p
where exists(
	select 1 
	from itens_pedidos  i
	where i.ped_numero = p.ped_numero
	group by i.ped_numero
	having COUNT(*) > 3
);


--51.	Consultar as pessoas que são clientes. Usar exists.    

select * 
from  
	pessoas p
where exists(
	select 
		pes_nome 
	from 
		clientes c 
	where  
		p.pes_codigo = c.pes_codigo
);

--52.	Consultar os clientes que possuem pedidos com valor total acima de R$ 20,00. Usar exists.

select * 
from 
	pessoas p
where exists (
	select 
		pes_nome, SUM(i.itp_qtd * i.itp_valor) 
	from 
		clientes c, itens_pedidos i 
	where
		p.pes_codigo = c.pes_codigo
	group by
		ped_numero 
	having 
		SUM(i.itp_qtd * i.itp_valor) > 20 
);

--53.	Consultar a data do sistema, e separadamente o ano, mês, dia, hora e minutos.

select GETDATE() [Data_atual]
select 
	DATEPART(YEAR, GETDATE()) AS Ano,
    DATEPART(MONTH, GETDATE()) AS Mes,
    DATEPART(DAY, GETDATE()) AS Dia,
    DATEPART(HOUR, GETDATE()) AS Hora,
    DATEPART(MINUTE, GETDATE()) AS Minuto;

--54.	Consultar o valor total do pedido 1.

select 
	SUM(i.itp_qtd * i.itp_valor) [Valor_total]
from 
	itens_pedidos i
where 
	ped_numero = 1;

--55.	Consultar o total vendido do produto 3

select
	prd_codigo, SUM (itp_qtd * itp_valor) As total_vendido
from
	itens_pedidos
where
	prd_codigo = 3
group by
	prd_codigo;
