# Guia rapido: montar o PBIX

Versao minima. Uma pagina so. Tempo estimado: 1 hora.

Os dados ja estao exportados em `bi/dados/` (um CSV por tabela do schema marts).
Se precisar gerar de novo: rode `dbt build` e depois o trecho de exportacao no fim deste guia.

## 1. Importar

1. Abra o Power BI Desktop > Obter dados > Texto/CSV.
2. Importe os 9 arquivos de `bi/dados/`: fct_sales, dim_date, dim_product, dim_customer,
   dim_geography, dim_credit_card, dim_order_status, dim_sales_reason, br_order_sales_reason.
3. Em cada um clique em Carregar (nao precisa transformar nada).
4. Confira em Exibicao de tabela se `fct_sales[date_key]` e `dim_date[date_key]` estao como Data.

## 2. Relacionamentos (Exibicao de modelo)

Apague os que o Power BI criar sozinho e crie estes, todos 1 para N com filtro em direcao unica:

| De (lado 1) | Para (lado N) |
|---|---|
| dim_date[date_key] | fct_sales[date_key] |
| dim_product[product_key] | fct_sales[product_key] |
| dim_customer[customer_key] | fct_sales[customer_key] |
| dim_geography[geography_key] | fct_sales[geography_key] |
| dim_credit_card[credit_card_key] | fct_sales[credit_card_key] |
| dim_order_status[status_key] | fct_sales[status_key] |
| dim_sales_reason[sales_reason_key] | br_order_sales_reason[sales_reason_key] |

A bridge liga ao fato por `sales_order_id` (N para N, filtro de br_order_sales_reason para fct_sales).
Tire um print desta tela: ele entra no video.

## 3. Medidas

Crie uma tabela vazia chamada `_Medidas` (Inserir dados > OK) e crie nela as medidas de
`bi/medidas-dax.md`. O minimo:

- Receita Liquida, Receita Bruta, Descontos, Pedidos, Unidades, Ticket Medio, Unidades em Promocao

Em cada medida, no painel Propriedades, preencha o campo **Descricao** com uma frase
(pode copiar a explicacao que esta no medidas-dax.md). E isso que o enunciado chama de
"medidas DAX documentadas dentro do arquivo".

## 4. Visuais (uma pagina)

Siga o layout de `bi/mockup.jpg`:

| Visual | Campos | Pergunta |
|---|---|---|
| 4 cartoes | Receita Liquida, Pedidos, Unidades, Ticket Medio | resumo |
| Grafico de linhas | Eixo: dim_date[year_month]; valores: Receita Liquida, Pedidos | e |
| Barras horizontais | dim_customer[customer_name] x Receita Liquida, filtro Top N = 10 | c |
| Colunas | dim_geography[city] x Receita Liquida, filtro Top N = 5 | d |
| Colunas | dim_product[product_name] x Ticket Medio, filtro Top N = 10 | b |
| Barras | dim_product[product_name] x Unidades, filtro fct_sales[is_promotion] = True, Top N = 10 | f |
| Matriz | linhas: produto; valores: Pedidos, Unidades, Receita Liquida | a |

Segmentacoes no topo: dim_date[year_number], dim_product[category_name],
dim_credit_card[card_type], dim_sales_reason[sales_reason_name],
dim_order_status[status_name], dim_geography[country].

## 5. Salvar

Salve como `bi/dashboard-adventure-works.pbix`.

## Regerar os CSVs (se mudar o dbt)

```bash
python -c "import duckdb;c=duckdb.connect('adventureworks.duckdb',read_only=True);[c.sql(f\"copy (select * from main_marts.{t}) to 'bi/dados/{t}.csv' (header)\") for t in ['fct_sales','dim_date','dim_product','dim_customer','dim_geography','dim_credit_card','dim_order_status','dim_sales_reason','br_order_sales_reason']]"
```
