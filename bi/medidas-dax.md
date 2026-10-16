# Medidas DAX

Cole cada uma como medida nova no Power BI. O enunciado exige que as medidas
estejam documentadas dentro do arquivo: use o campo **Description** de cada medida
no painel de propriedades e copie para la o comentario que acompanha a medida.

## Modelo no Power BI

Importe as tabelas do schema `marts`. Relacionamentos, todos um-para-muitos da
dimensao para o fato, direcao simples:

```
dim_date[date_key]                1 --> *  fct_sales[date_key]
dim_product[product_key]          1 --> *  fct_sales[product_key]
dim_customer[customer_key]        1 --> *  fct_sales[customer_key]
dim_geography[geography_key]      1 --> *  fct_sales[geography_key]
dim_credit_card[credit_card_key]  1 --> *  fct_sales[credit_card_key]
dim_order_status[status_key]      1 --> *  fct_sales[status_key]

br_order_sales_reason[sales_order_id]  * --> *  fct_sales[sales_order_id]
dim_sales_reason[sales_reason_key]     1 --> *  br_order_sales_reason[sales_reason_key]
```

Marque `dim_date` como tabela de datas: Modelagem > Marcar como tabela de datas,
coluna `date_key`.

A bridge e o unico relacionamento muitos-para-muitos do modelo. Explique isso no
video: e ela que permite filtrar por motivo da venda sem duplicar receita no resto.

## Metricas base

```dax
// Receita liquida: receita apos descontos. Metrica ancora do dashboard.
Receita Liquida = SUM(fct_sales[net_revenue])
```

```dax
// Receita bruta: antes de qualquer desconto.
Receita Bruta = SUM(fct_sales[gross_revenue])
```

```dax
// Valor total concedido em desconto.
Descontos = SUM(fct_sales[discount_amount])
```

```dax
// Numero de pedidos. Distinct e obrigatorio: o fato esta no grao de item.
Pedidos = DISTINCTCOUNT(fct_sales[sales_order_id])
```

```dax
// Unidades vendidas.
Unidades = SUM(fct_sales[order_qty])
```

## Metricas derivadas

```dax
// Ticket medio conforme a formula do enunciado:
// (receita bruta - descontos) dividido pelo numero de pedidos.
Ticket Medio =
DIVIDE([Receita Bruta] - [Descontos], [Pedidos])
```

```dax
// Percentual da receita bruta entregue em desconto.
Taxa de Desconto = DIVIDE([Descontos], [Receita Bruta])
```

```dax
// Receita do mesmo periodo do ano anterior.
Receita Ano Anterior =
CALCULATE([Receita Liquida], SAMEPERIODLASTYEAR(dim_date[date_key]))
```

```dax
// Crescimento percentual contra o ano anterior.
Crescimento YoY % =
DIVIDE([Receita Liquida] - [Receita Ano Anterior], [Receita Ano Anterior])
```

```dax
// Receita do mes anterior.
Receita Mes Anterior =
CALCULATE([Receita Liquida], DATEADD(dim_date[date_key], -1, MONTH))
```

```dax
// Crescimento percentual contra o mes anterior.
Crescimento MoM % =
DIVIDE([Receita Liquida] - [Receita Mes Anterior], [Receita Mes Anterior])
```

```dax
// Participacao dos 10 maiores clientes na receita total do contexto atual.
// Indicador de risco: receita concentrada em poucos compradores.
Concentracao Top 10 Clientes =
VAR Total = CALCULATE([Receita Liquida], ALLSELECTED(dim_customer))
VAR Top10 =
    CALCULATE(
        [Receita Liquida],
        TOPN(10, ALLSELECTED(dim_customer), [Receita Liquida], DESC)
    )
RETURN DIVIDE(Top10, Total)
```

```dax
// Unidades vendidas apenas em pedidos com motivo "Promotion".
// Usa a flag do fato, nao a bridge: evita contagem dupla quando o pedido
// tem mais de um motivo. Responde a pergunta f do enunciado.
Unidades em Promocao =
CALCULATE([Unidades], fct_sales[is_promotion] = TRUE())
```

```dax
// Taxa de desconto restrita a pedidos promocionais.
// Comparada com a taxa geral, mostra se a promocao gera receita incremental
// ou apenas transfere margem.
Taxa de Desconto em Promocao =
CALCULATE([Taxa de Desconto], fct_sales[is_promotion] = TRUE())
```

## Como cada pergunta do enunciado e respondida

| Pergunta | Visual | Medidas |
|---|---|---|
| a | matriz, com os filtros do painel aplicados | Pedidos, Unidades, Receita Liquida |
| b | barras por produto | Ticket Medio |
| c | barras com filtro Top N = 10 em `dim_customer` | Receita Liquida |
| d | barras com filtro Top N = 5 em `dim_geography[city]` | Receita Liquida |
| e | linha por `dim_date[year_month]` | Pedidos, Unidades, Receita Liquida |
| f | barras por produto, filtro `is_promotion` | Unidades em Promocao |
