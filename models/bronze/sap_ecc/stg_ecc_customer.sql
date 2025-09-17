
/*
    Customer Data
*/

{{ config(materialized='view') }}
with 

source as (

    select * from {{ source('sap_ecc', 'ecc_customer') }}

),

renamed as (

    select
        customerid,
        customertypeid,
        country,
        language,
        createdby,
        createdat as src_createdat, 
        {{ convert_yyyymmdd('createdat') }} as createdat,       
        changedby,
        changedat as src_changedat,
        {{ convert_yyyymmdd('changedat') }} as changedat,  
        'ECC' as source

    from source

)

select * from renamed
