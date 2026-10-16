# Regras de negocio

Documento exigido no entregavel 6. Registra as decisoes de modelagem que nao sao
obvias a partir do codigo, para que qualquer pessoa chegue ao mesmo numero.

## 1. Grao da tabela fato

`fct_sales` tem **uma linha por item de pedido** (`salesorderdetailid`).

Consequencia direta: os valores que vivem no cabecalho do pedido (`subtotal`,
`taxamt`, `freight`, `totaldue`) **nao foram trazidos para o fato**. Eles se
repetiriam em cada item do mesmo pedido e qualquer soma ficaria inflada.
Se o frete precisar entrar em alguma analise, a saida e ratear por item ou criar
um segundo fato no grao de pedido.

## 2. Contagem de pedidos

Numero de pedidos e sempre `COUNT(DISTINCT sales_order_id)`.
`COUNT(*)` conta itens, nao pedidos.

## 3. Metricas de receita

| Metrica | Formula | Significado |
|---|---|---|
| `gross_revenue` | `order_qty * unit_price` | receita antes do desconto |
| `discount_amount` | `order_qty * unit_price * unit_price_discount_pct` | desconto concedido |
| `net_revenue` | `line_total` da origem | receita apos o desconto |

Vale a identidade `gross_revenue - discount_amount = net_revenue`, verificada pelo
teste `assert_receita_bruta_menos_desconto`.

## 4. Ticket medio

A formula vem definida no proprio enunciado da pergunta b:

```
ticket medio = (receita bruta - descontos) / numero de pedidos no periodo
```

Ou seja, o numerador e `net_revenue`. Nao usamos a definicao alternativa de
dividir pela quantidade de itens.

## 5. Motivo da venda e o muitos-para-muitos

Um pedido pode ter varios motivos de venda. Juntar `salesorderheadersalesreason`
direto no fato multiplicaria cada item pelo numero de motivos e inflaria a receita.

Tratamento adotado:

- **`br_order_sales_reason`**: bridge no grao pedido x motivo, usada para analises
  por motivo. Somas feitas atraves da bridge precisam estar conscientes de que a
  receita de um pedido com dois motivos aparece sob os dois.
- **`is_promotion`**: flag booleana no fato, verdadeira quando o pedido tem o
  motivo "Promotion". Responde a pergunta f sem nenhum risco de duplicacao.

## 6. Geografia da venda

Cidade, estado e pais vem do **endereco de entrega do pedido** (`shiptoaddressid`),
nao do endereco de cobranca nem do cadastro do cliente.

Motivo: e a leitura comercial de "onde a venda aconteceu". `salesterritory` tem um
pais proprio e **nao foi misturado** com esta dimensao, para nao criar dois eixos
geograficos conflitantes no dashboard.

## 7. Pedidos sem cartao de credito

Vendas de revenda e faturamento direto nao tem cartao. Em vez de deixar a chave nula,
o fato recebe `-1` e `dim_credit_card` ganha o membro "Sem cartao". Isso mantem a
integridade referencial e evita que o filtro de tipo de cartao esconda pedidos no BI.

## 8. Situacao do pedido

O OLTP guarda apenas um codigo de 1 a 6. Os nomes estao no seed `order_status.csv`,
versionado junto com o projeto.

## 9. Validacao contra a auditoria

Requisito do CEO: vendas brutas de 2011 = **12.646.112,16**.

O teste `assert_vendas_brutas_2011` falha se a soma de `net_revenue` dos pedidos de
2011 divergir em mais de um centavo. A definicao de "vendas brutas" adotada aqui e a
soma de `line_total`, que corresponde a soma dos `subtotal` dos cabecalhos.

> Se o teste falhar por diferenca pequena quando os dados reais forem carregados,
> teste `gross_revenue` no lugar e atualize esta secao com a definicao que bate.

## 10. Periodo coberto

`dim_date` cobre de 2011-01-01 a 2014-12-31, faixa dos dados do AdventureWorks.
