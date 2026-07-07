with

source as (

    select * from {{ source('src_semantic', 'EMEA_TBL_SALES_REVENUE_AGG_SECURED') }}

),

renamed as (

    select
        md5(concat_ws('||',
            coalesce(cast(customer_number as varchar), ''),
            coalesce(cast(material_level_4_number as varchar), ''),
            coalesce(cast(profit_center_number as varchar), ''),
            coalesce(cast(sales_rep_number as varchar), ''),
            coalesce(cast(order_type as varchar), ''),
            coalesce(cast(order_reason as varchar), ''),
            coalesce(cast(invoice_type as varchar), ''),
            coalesce(cast(invoice_date as varchar), '')
        )) as sales_rev_agg_grain_id,
        area_group,
        country_name,
        customer_city,
        customer_name,
        customer_number,
        division_name,
        global_partner_name,
        global_partner_number,
        hub,
        hub_one,
        hub_two,
        invoice_type,
        item_category,
        limited_partner_name,
        limited_partner_number,
        material_level_1_name,
        material_level_1_number,
        material_level_2_name,
        material_level_2_number,
        material_level_3_name,
        material_level_3_number,
        material_level_4_name,
        material_level_4_number,
        order_reason,
        order_type,
        profit_center_name,
        profit_center_number,
        sales_area_manager,
        sales_area_name,
        sales_area_number,
        sales_division_name,
        sales_division_number,
        sales_org,
        sales_region_manager,
        sales_region_name,
        sales_region_number,
        sales_rep_name,
        sales_rep_number,
        sales_territory_name,
        sales_territory_number,
        business_day_in_month,
        business_day_month_to_date_indicator,
        business_day_quarter_to_date_indicator,
        business_day_year_to_date_indicator,
        business_days_ago,
        invoice_date,
        invoice_fiscal_period,
        invoice_month,
        invoice_quarter,
        invoice_year,
        last_business_day_indicator,
        months_ago,
        quarters_ago,
        years_ago,
        email_id_lower,
        quantity,
        rebate,
        revenue,
        sales

    from source

)

select * from renamed
