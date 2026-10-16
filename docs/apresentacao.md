# Apresentacao: roteiro dos slides

Entregavel 7. O enunciado pede cinco coisas na apresentacao: as etapas do projeto,
argumentos sobre cultura data-driven, os insights da EDA, a justificativa dos
indicadores e visuais, e recomendacoes acionaveis para o cliente.

A audiencia nao e tecnica. A pessoa mais dificil da sala e a Diretora Comercial,
que ja viu projeto de dado prometer e nao entregar.

---

## 1. Capa

Visao Comercial Adventure Works, da base transacional a decisao.

## 2. O problema, na linguagem deles

Nao abra falando de arquitetura. Abra com a pergunta que a area nao consegue
responder hoje sem pedir ajuda ao Gabriel e esperar na fila.

> "Qual cidade cresceu mais no ultimo trimestre e qual produto puxou esse
> crescimento? Hoje essa resposta leva dias e sai diferente dependendo de quem faz."

## 3. Por que isso acontece

O dado existe, mas vive em um banco transacional, desenhado para registrar pedido,
nao para responder pergunta. Toda analise vira um pedido de SQL.

## 4. O que foi construido

Diagrama simples de quatro caixas: origem, ingestao, transformacao com dbt,
dashboard. Uma frase em cada. Nao entre em detalhe tecnico aqui.

## 5. O modelo dimensional

Mostre o modelo conceitual. Explique em uma frase o que e fato e o que e dimensao,
usando o vocabulario deles: "o fato e cada item vendido; as dimensoes sao as formas
de olhar para ele: por produto, por cliente, por cidade, por periodo".

Cite as duas decisoes: o grao do fato e a bridge do motivo de venda.

## 6. Confianca no numero

Este slide e para o CEO, e e o que compra credibilidade com todo mundo.

> "O senhor citou que as vendas brutas de 2011 foram 12.646.112,16. Essa conferencia
> virou um teste automatico. Toda vez que o modelo roda, ele compara com esse numero
> e falha se divergir de um centavo. Sao noventa e quatro testes como esse rodando
> a cada atualizacao."

Esse e o contraponto direto ao historico de promessas nao cumpridas.

## 7. Os indicadores e por que estes

Liste os KPIs de `docs/kpis.md` com a justificativa em uma linha cada.
Deixe claro que indicador que nao muda decisao ficou de fora.

## 8 a 11. Insights da EDA

Um slide por achado, sempre no mesmo formato de tres partes:

1. o que o dado mostra
2. por que isso importa para a area comercial
3. o que fazer a respeito

Os quatro achados vem do notebook: concentracao de clientes, diferenca entre canal
online e revenda, sazonalidade da receita e a analise de promocao.

## 12. O achado principal

O slide da taxa de desconto cruzada com motivo da venda. Apresente o numero antes
da conclusao, e seja honesto com o que ele disser.

Se a promocao estiver transferindo margem, a recomendacao e testar: escolher uma
categoria, reduzir o desconto por um periodo e medir. O painel ja mede.

Se a promocao estiver funcionando, o slide e igualmente util, porque mostra que agora
existe como provar isso, e como defender o orcamento da area com numero.

## 13. Demonstracao do dashboard

Navegue ao vivo ou por print. Mostre os filtros funcionando e responda uma pergunta
que a propria plateia fizer, na hora. E a demonstracao mais convincente possivel.

## 14. Recomendacoes acionaveis

Tres, no maximo, cada uma com responsavel e prazo sugerido:

1. acompanhar mensalmente a concentracao de receita nos dez maiores clientes
2. rodar o teste de reducao de desconto na categoria X por um trimestre
3. separar as metas de ticket medio por canal, porque hoje a meta unica esconde os dois

## 15. Proximos passos

Trazer CRM e web analytics para o mesmo modelo e medir o funil inteiro, do visitante
ao pedido. O custo marginal e baixo porque a fundacao ja esta pronta.

## 16. Fechamento

> "Cultura data-driven nao comeca com ferramenta, comeca quando a reuniao passa a
> discutir o numero em vez de discutir de quem e o numero certo. Isso ja aconteceu
> hoje, nesta apresentacao."
