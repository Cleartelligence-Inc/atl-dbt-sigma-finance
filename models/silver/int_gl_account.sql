{{ config(materialized='table') }}
{{ union_with_priority(
    table_list=[
        {"model": "stg_ecc_gl_account"},
        {"model": "stg_ecc_gl_account"}
    ],
    partition_by=["accountid"],
    priority_column="source",
    priority_order=["S4", "ECC"]
) }}
