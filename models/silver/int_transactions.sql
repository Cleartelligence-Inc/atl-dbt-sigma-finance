
{{ union_with_priority(
    table_list=[
        {"model": "stg_ecc_transactions"},
        {"model": "stg_s4_transactions"}
    ],
    partition_by=["transactionid"],
    priority_column="source",
    priority_order=["S4", "ECC"]
) }}
