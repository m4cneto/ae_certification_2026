# Roteiro do video: 5 minutos

O entregavel 8 pede de 3 a 5 minutos. A etapa 9 lista oito demonstracoes
obrigatorias; todas estao cobertas abaixo. Grave por blocos, nao em uma tomada so.

Comece pelos blocos 3 e 4, que sao os do terminal. Sao os que mais travam.

---

## Bloco 1: Objetivo (0:00 a 0:30)

> "A Adventure Works fabrica bicicletas e cresce rapido, mas decide no escuro.
> Construi uma plataforma de dados para a area comercial: do banco transacional
> ate o dashboard, com testes que provam que os numeros batem com a contabilidade.
> O que voces vao ver e o caminho completo."

## Bloco 2: Modelo dimensional (0:30 a 1:15)

Mostre o modelo conceitual em PDF.

> "Uma tabela fato no grao de item de pedido e sete dimensoes em volta.
> Duas decisoes importantes. A primeira: valores de cabecalho, como frete e imposto,
> ficaram fora do fato, porque se repetiriam em cada item e inflariam qualquer soma.
> A segunda: motivo da venda e muitos-para-muitos, entao usei uma bridge. Se eu
> juntasse direto no fato, a receita seria contada uma vez por motivo do pedido."

## Bloco 3: dbt run (1:15 a 1:45)

Terminal, com o comando visivel na tela:

```
dbt run
```

> "Vinte e cinco modelos em tres camadas: staging espelha a origem, intermediate faz
> os joins, marts entrega as dimensoes e o fato. Todos executaram."

## Bloco 4: Testes (1:45 a 2:45)

```
dbt test --select source:*
```

> "Primeiro os testes na fonte: chave primaria unica e nao nula nas tabelas cruas e
> integridade referencial entre elas. Se o dado chegar quebrado, para aqui."

```
dbt test
```

> "Agora o projeto inteiro: noventa e quatro testes. Chave primaria de cada dimensao,
> integridade referencial de cada chave do fato, faixa de valor nas metricas e tres
> testes singulares."

Aponte para o teste do CEO:

> "Este atende um pedido direto do CEO. Ele citou que as vendas brutas de 2011 foram
> doze milhoes, seiscentos e quarenta e seis mil, cento e doze reais e dezesseis.
> O teste falha se o modelo divergir disso em mais de um centavo. Enquanto ele
> passar, o numero bate com a auditoria."

## Bloco 5: A tabela fato (2:45 a 3:30)

Abra `fct_sales.sql` e o lineage no dbt docs.

> "O fato junta o item do pedido com o cabecalho e carrega cinco metricas:
> quantidade, preco unitario, receita bruta, desconto e receita liquida.
> Separei receita bruta de desconto de proposito: e isso que permite medir taxa de
> desconto, que e o indicador central da minha analise."

## Bloco 6: Dashboard (3:30 a 4:40)

> "O dashboard responde as seis perguntas do escopo." Passe por elas rapido.

> "Os filtros no topo valem para a pagina inteira: periodo, produto, tipo de cartao,
> motivo da venda, status e geografia."

> "E aqui esta o achado principal: INSIRA SEU INSIGHT DA EDA."

## Bloco 7: Fechamento (4:40 a 5:00)

> "A proxima camada natural e trazer CRM e web analytics para o mesmo modelo e medir
> o funil inteiro. A base ja esta pronta para isso."

---

## Checklist antes de postar

- [ ] `dbt run` aparece com todos os modelos em sucesso
- [ ] `dbt test --select source:*` aparece passando
- [ ] `dbt test` aparece passando
- [ ] a tabela fato e os joins foram mostrados
- [ ] as metricas do fato foram justificadas
- [ ] os testes de dados foram apresentados
- [ ] dashboard com filtros, visuais e possibilidades de analise
- [ ] a modelagem dentro do Power BI foi mostrada
- [ ] duracao entre 3 e 5 minutos
- [ ] link publico, testado em aba anonima
