# Adventure Works: Analytics Engineer Certification 2026

Plataforma de dados da area comercial da Adventure Works: do banco transacional ao
dashboard, com testes que provam que os numeros batem com a contabilidade.

Banco: **DuckDB**, um arquivo unico, sem servidor, sem conta, sem senha.

## Estrutura

```
ae-project-certification/
  dbt/            projeto dbt: 25 modelos, 94 testes, 1 seed
  scripts/        carga dos dados crus para o DuckDB
  analise/        notebook de EDA (entregavel 1)
  modelagem/      modelo conceitual em draw.io (entregavel 2)
  bi/             medidas DAX e mockup do dashboard (entregaveis 4 e 5)
  docs/           regras de negocio, KPIs e roteiro da apresentacao (entregaveis 6 e 7)
  entrega/        roteiro do video, links e checklist final (entregavel 8)
```

## Como rodar

### 1. Dependencias

```bash
pip install dbt-core dbt-duckdb duckdb pandas matplotlib jupyter
```

### 2. Carregar os dados crus

O processo de EL (repositorio da Indicium) deixa os dados em algum lugar. O script
traz de la para o arquivo DuckDB, sempre no schema `adventure_works`.

```bash
# vindo de um Postgres
python scripts/carregar_dados.py postgres "postgresql://usuario:senha@host:5432/banco"

# ou de uma pasta de CSVs
python scripts/carregar_dados.py csv "C:/caminho/para/os/csv"
```

### 3. Rodar o dbt

```bash
cd dbt
set DBT_PROFILES_DIR=%CD%     # no PowerShell: $env:DBT_PROFILES_DIR = $PWD

dbt deps
dbt build                      # seed + run + test de uma vez
```

Separado, que e como o video pede:

```bash
dbt run
dbt test --select source:*
dbt test
```

### 4. Documentacao navegavel

```bash
dbt docs generate
dbt docs serve
```

### 5. Analise exploratoria

```bash
jupyter notebook analise/eda.ipynb
```

## O modelo

`fct_sales` no grao de **item de pedido**, com sete dimensoes e uma bridge.

| Objeto | Origem |
|---|---|
| `fct_sales` | salesorderdetail + salesorderheader |
| `dim_product` | product + productsubcategory + productcategory |
| `dim_customer` | customer + person + store |
| `dim_geography` | address + stateprovince + countryregion (endereco de entrega) |
| `dim_credit_card` | creditcard, mais o membro -1 "Sem cartao" |
| `dim_sales_reason` | salesreason |
| `dim_order_status` | seed `order_status.csv` |
| `dim_date` | gerada pelo dbt |
| `br_order_sales_reason` | salesorderheadersalesreason |

As decisoes de modelagem estao em [docs/regras-de-negocio.md](docs/regras-de-negocio.md).

## Testes

94 testes em cinco categorias: chave de origem, chave primaria dos marts,
integridade referencial, faixa de valores e tres testes singulares.

O principal deles, `assert_vendas_brutas_2011`, atende um pedido direto do CEO:
falha se as vendas de 2011 divergirem de **12.646.112,16** em mais de um centavo.

## Pendencias

- [ ] Rodar o EL e carregar os dados
- [ ] Conferir se os nomes de coluna da origem batem com os do staging
- [ ] Confirmar qual definicao de receita bate com o numero da auditoria
- [ ] Preencher os insights do notebook
- [ ] Montar o PBIX e o mockup no Figma
- [ ] Gravar o video
