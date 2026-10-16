"""
Carrega o AdventureWorks cru para o arquivo DuckDB que o dbt usa.

Duas origens possiveis, escolhidas pelo primeiro argumento:

    python scripts/carregar_dados.py postgres "postgresql://user:senha@host:5432/banco"
    python scripts/carregar_dados.py csv "C:/caminho/para/pasta_com_csv"

No modo csv, cada arquivo vira uma tabela com o nome do arquivo sem extensao.
Em ambos os casos tudo cai no schema adventure_works, que e o unico que o
enunciado permite usar.
"""

import sys
import pathlib
import duckdb

DB = pathlib.Path(__file__).resolve().parents[1] / "adventureworks.duckdb"
SCHEMA = "adventure_works"

TABELAS = [
    "salesorderheader", "salesorderdetail", "customer", "store", "creditcard",
    "salesreason", "salesorderheadersalesreason", "person", "address",
    "stateprovince", "countryregion", "product", "productsubcategory",
    "productcategory",
]


def de_postgres(con, dsn):
    con.execute("INSTALL postgres; LOAD postgres;")
    con.execute(f"ATTACH '{dsn}' AS pg (TYPE postgres, READ_ONLY);")
    origens = {t: None for t in TABELAS}
    achadas = con.execute(
        "select table_schema, table_name from pg.information_schema.tables"
    ).fetchall()
    for esquema, tabela in achadas:
        if tabela.lower() in origens and origens[tabela.lower()] is None:
            origens[tabela.lower()] = f'pg."{esquema}"."{tabela}"'
    for tabela, origem in origens.items():
        if origem is None:
            print(f"  ! nao encontrada no postgres: {tabela}")
            continue
        con.execute(f"create or replace table {SCHEMA}.{tabela} as select * from {origem}")
        print(f"  ok {tabela}")


def de_csv(con, pasta):
    for arquivo in sorted(pathlib.Path(pasta).glob("*.csv")):
        tabela = arquivo.stem.lower()
        con.execute(
            f"create or replace table {SCHEMA}.{tabela} as "
            f"select * from read_csv_auto('{arquivo.as_posix()}', header=true)"
        )
        print(f"  ok {tabela}")


def main():
    if len(sys.argv) != 3 or sys.argv[1] not in ("postgres", "csv"):
        print(__doc__)
        sys.exit(1)

    modo, origem = sys.argv[1], sys.argv[2]
    con = duckdb.connect(str(DB))
    con.execute(f"create schema if not exists {SCHEMA};")

    print(f"Carregando para {DB}")
    if modo == "postgres":
        de_postgres(con, origem)
    else:
        de_csv(con, origem)

    total = con.execute(
        "select count(*) from information_schema.tables where table_schema = ?", [SCHEMA]
    ).fetchone()[0]
    print(f"\n{total} tabelas no schema {SCHEMA}.")
    con.close()


if __name__ == "__main__":
    main()
