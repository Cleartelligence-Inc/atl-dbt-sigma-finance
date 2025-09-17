{{ config(materialized='view') }}

with 

source as (

    select * from {{ source('sap_s4', 's4_customer_hierarchy') }}

),

renamed as (

    select
        hierarchyid,
        description,
        level,
        'S4' as source

    from source

)

select * from renamed
