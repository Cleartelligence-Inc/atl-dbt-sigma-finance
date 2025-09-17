{{ config(materialized='view') }}

with 

source as (

    select * from {{ source('sap_s4', 's4_financial_transactions') }}

),

renamed as (

    select
        transactionid,
        accountid,
        accounttypeid,
        customerid,
        customertypeid,
        productid,
        productcategoryid,
        profitcenterid,
        version,
        date as src_date,
        {{ convert_yyyymmdd('date') }} as date,
        value as src_value,
        TO_DECIMAL(REPLACE(value, ',', '.'), 18, 2) as value,
        'S4' as source
    from source

)

select * from renamed
