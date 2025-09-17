{{ config(materialized='view') }}

with 

source as (

    select * from {{ source('sap_s4', 's4_customer_type') }}

),

type_text as (

    select * from {{ source('sap_s4', 's4_customer_type_text') }}

),

renamed as (

    select
        a.customertypeid,
        a.language,
        short_descr,
        medium_descr,
        long_descr,
        a.createdat as src_createdat, 
        {{ convert_yyyymmdd('createdat') }} as createdat,       
        changedby,
        a.changedat as src_changedat,
        {{ convert_yyyymmdd('changedat') }} as changedat,
        'S4' as source

    from source a
    left outer join type_text
    on a.customertypeid = type_text.customertypeid

)

select * from renamed
