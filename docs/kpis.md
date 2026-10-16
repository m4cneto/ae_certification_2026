# KPIs do dashboard comercial

Etapa 1 do desafio: propor os indicadores e justificar cada um.
A audiencia e a Diretoria Comercial, que hoje nao ve valor no projeto de dados.

## Indicadores principais

| KPI | Definicao | Por que esta no dashboard |
|---|---|---|
| Receita liquida | `SUM(net_revenue)` | E o numero pelo qual a area comercial responde. Serve de ancora para todo o resto. |
| Crescimento MoM e YoY | variacao percentual da receita liquida | Separa desempenho real de sazonalidade. O AdventureWorks tem picos claros de fim de trimestre. |
| Numero de pedidos | `COUNT(DISTINCT sales_order_id)` | Permite distinguir crescimento por volume de crescimento por preco. |
| Unidades vendidas | `SUM(order_qty)` | Mesma leitura do anterior, no nivel de produto. |
| Ticket medio | `(receita bruta - descontos) / pedidos` | Formula definida no enunciado. Mede quanto se extrai de cada pedido. |
| Taxa de desconto | `SUM(discount_amount) / SUM(gross_revenue)` | Mostra quanto da receita esta sendo entregue em desconto. |

## O indicador que sustenta a argumentacao

**Taxa de desconto cruzada com motivo da venda.**

A Diretora Comercial defende investir em acoes promocionais em vez de dados. Esse
cruzamento responde a pergunta que ninguem fez ainda: os pedidos marcados com o
motivo "Promotion" trazem receita incremental ou apenas transferem margem?

Se a taxa de desconto nos pedidos promocionais for alta e o ticket medio nao subir
proporcionalmente, a promocao esta canibalizando venda que aconteceria de qualquer
jeito. Esse e um achado acionavel e vem de dado, nao de opiniao, que e exatamente o que
o criterio 6 de aprovacao pede.

## Indicadores de apoio

| KPI | Leitura |
|---|---|
| Concentracao de receita | participacao dos 10 maiores clientes no total; risco comercial que ninguem acompanha |
| Mix por categoria | para onde a demanda migra dentro do portfolio |
| Receita por canal | `is_online_order` separa venda online de revenda; sao dois negocios distintos |
| Receita por pais e cidade | onde a expansao funciona e onde nao |
| Top 10 clientes e top 5 cidades | exigidos nominalmente pelas perguntas c e d |
