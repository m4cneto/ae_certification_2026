-- O pedido do CEO: os numeros do modelo tem que bater com a auditoria contabil.
-- Referencia informada: vendas brutas de 2011 = 12.646.112,16
--
-- Se este teste falhar por pouco, a causa costuma ser a definicao de "vendas brutas".
-- Candidatos, nesta ordem: net_revenue (soma de linetotal, igual ao subtotal do
-- cabecalho) ou gross_revenue (antes do desconto). Troque a coluna abaixo,
-- descubra qual bate ao centavo e registre a definicao em docs/regras-de-negocio.md.

select
    sum(net_revenue) as valor_apurado,
    {{ var('gross_sales_2011') }} as valor_auditado,
    sum(net_revenue) - {{ var('gross_sales_2011') }} as diferenca
from {{ ref('fct_sales') }}
where extract(year from date_key) = 2011
having abs(sum(net_revenue) - {{ var('gross_sales_2011') }}) > 0.01
