{{ config(materialized='view') }}

with 

source as (

    select * from {{ source('sap_s4', 's4_gl_account') }}

),

renamed as (

    select
        accountid,
        accounttypeid,
        language,
        createdby,
        createdat as src_createdat, 
        {{ convert_yyyymmdd('createdat') }} as createdat,       
        changedby,
        changedat as src_changedat,
        {{ convert_yyyymmdd('changedat') }} as changedat,
        'S4' as source 

    from source

)

select * from renamed
