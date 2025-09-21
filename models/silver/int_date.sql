{{ config(materialized='table') }}

with base as (

    -- generate a date range (adjust start/end as needed)
    select 
        dateadd(day, seq4(), '2000-01-01'::date) as date_day
    from table(generator(rowcount => 365*50)) -- ~50 years of days
    where dateadd(day, seq4(), '2000-01-01'::date) <= '2050-12-31'::date

),

calendar as (

    select
        to_number(to_char(date_day, 'YYYYMMDD')) as date_id,
        date_day,
        extract(year from date_day) as year,
        extract(quarter from date_day) as quarter,
        extract(month from date_day) as month,
        lpad(extract(month from date_day)::varchar, 2, '0') as month_number,
        trim(to_char(date_day, 'Mon')) as month_name,
        extract(week from date_day) as week_of_year,
        extract(doy from date_day) as day_of_year,
        extract(day from date_day) as day_of_month,
        extract(dow from date_day) as day_of_week_num,  -- 0=Sunday, 1=Monday...
        case extract(dow from date_day)
            when 0 then 'Sunday'
            when 1 then 'Monday'
            when 2 then 'Tuesday'
            when 3 then 'Wednesday'
            when 4 then 'Thursday'
            when 5 then 'Friday'
            when 6 then 'Saturday'
        end as day_name,     
        case 
            when extract(dow from date_day) in (6,0) then 'Weekend'
            else 'Weekday'
        end as day_type,
        to_char(date_day, 'YYYY-MM') as year_month,
        to_char(date_day, 'YYYY') || '-Q' || extract(quarter from date_day) as year_quarter

    from base
)

select * from calendar