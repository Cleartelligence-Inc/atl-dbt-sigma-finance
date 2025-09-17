
/*
    Customer Data
*/

{{ config(materialized='view') }}

with 

source as (

    select * from {{ source('sap_ecc', 'ecc_customer_hierarchy') }}

),

renamed as (

    select
        hierarchyid,
        description,
        level,
        'ECC' as source

    from source

)

select * from renamed
