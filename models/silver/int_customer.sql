
{{ union_with_priority(
    table_list=[
        {"model": "stg_ecc_customer"},
        {"model": "stg_s4_customer"}
    ],
    partition_by=["customerid"],
    priority_column="source",
    priority_order=["S4", "ECC"]
) }}
