with

source as (

    select * from {{ source('src_semantic', 'EMEA_TBL_SUPPORT_CASES_AGG_SECURED') }}

),

renamed as (

    select
        md5(concat_ws('||',
            coalesce(cast(customer_number as varchar), ''),
            coalesce(cast(global_partner_number as varchar), ''),
            coalesce(cast(material_level_2_number as varchar), ''),
            coalesce(cast(case_type as varchar), ''),
            coalesce(cast(case_severity as varchar), ''),
            coalesce(cast(case_status as varchar), ''),
            coalesce(cast(invoice_year as varchar), ''),
            coalesce(cast(invoice_quarter as varchar), ''),
            coalesce(cast(invoice_month as varchar), '')
        )) as support_cases_agg_grain_id,
        customer_name,
        customer_number,
        global_partner_name,
        global_partner_number,
        material_level_2_name,
        material_level_2_number,
        country_name,
        hub,
        invoice_year,
        invoice_quarter,
        invoice_month,
        date_from_parts(invoice_year, invoice_month, 1) as invoice_month_date,
        months_ago,
        quarters_ago,
        years_ago,
        case_type,
        case_severity,
        case_status,
        case_count,
        escalated_case_count,
        sla_breach_case_count,
        warranty_claim_count,
        warranty_cost,
        total_resolution_hours

    from source

)

select * from renamed
