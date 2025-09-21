{{ config(materialized='table') }}
{{ union_with_priority(
    table_list=[
        {"model": "stg_ecc_customer_type"},
        {"model": "stg_s4_customer_type"}
    ],
    partition_by=["customertypeid"],
    priority_column="source",
    priority_order=["S4", "ECC"]
) }}
