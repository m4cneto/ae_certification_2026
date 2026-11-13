# Roteiro do video: cerca de 4 minutos

Grave com o OBS Studio, tela inteira, voz por cima. Pode gravar em partes e juntar.
Antes de gravar, deixe abertos: o terminal na pasta `dbt`, o PDF do modelo conceitual,
o VS Code com `fct_sales.sql` e o PBIX.

No terminal, antes de tudo:

```powershell
cd dbt
$env:DBT_PROFILES_DIR = $PWD
```

---

## 1. Objetivo (0:00 a 0:20)

Tela: slide 1 ou 2 da apresentacao.

> "A Adventure Works quer usar dados para decidir na area comercial. Construi o caminho
> completo: dos dados crus ate um dashboard, com testes que garantem que os numeros batem
> com a auditoria."

## 2. Modelo dimensional (0:20 a 1:00)

Tela: `modelagem/modelo-conceitual.pdf`.

> "O fato e o fct_sales, uma linha por item de pedido. Em volta estao sete dimensoes:
> data, produto, cliente, geografia, cartao, status e motivo da venda. Como um pedido pode
> ter varios motivos, o motivo fica numa tabela ponte, para nao duplicar a receita.
> Embaixo de cada tabela esta a tabela de origem."

## 3. EL e dbt run (1:00 a 1:30)

Tela: terminal.

```
dbt run
```

> "Os dados foram carregados do repositorio da Indicium para o warehouse, no schema
> adventure_works. O dbt organiza em tres camadas: staging, intermediate e marts.
> Todos os modelos rodaram com sucesso."

## 4. Testes (1:30 a 2:15)

```
dbt test --select source:*
```

> "Primeiro os testes na fonte: chaves unicas, nao nulas e relacionamentos. Todos passam."

```
dbt test
```

> "Agora todos os testes do projeto: chaves primarias das dimensoes e do fato,
> integridade entre fato e dimensoes, e testes de qualidade. O mais importante e este:
> o CEO pediu que as vendas brutas de 2011 batessem com 12.646.112,16. O teste
> assert_vendas_brutas_2011 confere isso, e passa."

## 5. A tabela fato (2:15 a 2:45)

Tela: `dbt/models/marts/fct_sales.sql` no VS Code.

> "O fato junta o item do pedido com o cabecalho e traz as chaves de cada dimensao.
> As metricas sao quantidade, preco unitario, receita bruta, desconto e receita liquida.
> Separei receita bruta e desconto para conseguir calcular o ticket medio como o enunciado pede."

## 6. Power BI (2:45 a 3:50)

Tela: PBIX, primeiro a Exibicao de modelo, depois o relatorio.

> "No Power BI, o mesmo modelo estrela: o fato no centro e as dimensoes ligadas por chave.
> As medidas DAX estao documentadas no campo descricao."

Troque para a pagina do relatorio:

> "Os cartoes no topo dao o resumo. O grafico de linha mostra pedidos e receita por mes.
> Aqui estao os 10 maiores clientes, as 5 maiores cidades, o ticket medio por produto e
> os produtos mais vendidos em promocao: o primeiro e a Water Bottle."

Clique em um filtro (por exemplo, pais = Canada) e mostre os visuais mudando:

> "Todos os filtros do topo valem para a pagina inteira."

> "O principal achado: pedidos em promocao sao 11% dos pedidos, mas so cerca de 6% da
> receita, com metade do ticket medio. A recomendacao e medir o retorno das promocoes
> antes de ampliar a verba."

## 7. Fechamento (3:50 a 4:00)

> "Com essa base, o proximo passo e trazer CRM e web analytics para o mesmo modelo.
> Obrigado."

---

## Antes de postar

- [ ] duracao entre 3 e 5 minutos
- [ ] apareceram `dbt run`, `dbt test --select source:*` e `dbt test` passando
- [ ] apareceram o modelo dentro do Power BI e um filtro funcionando
- [ ] YouTube como "Nao listado", link testado em aba anonima e colado em `links.txt`
