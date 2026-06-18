{{ config(materialized='table') }}
{{ union_with_priority(
    table_list=[
        {"model": "stg_ecc_customer_hierarchy"},
        {"model": "stg_s4_customer_hierarchy"}
    ],
    partition_by=["hierarchyid"],
    priority_column="source",
    priority_order=["S4", "ECC"]
) }}
