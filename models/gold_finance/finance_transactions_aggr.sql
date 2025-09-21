select
    a.accountid,
    a.customerid,
    a.customertypeid,
    country,
    g.accounttypeid,
    medium_descr as customertype_descr,
    productid,
    productcategoryid,
    p.level as product_hier_level,
    profitcenterid,
    sum(case when version = 'Actual' then value end) as actual_vale,
    sum(case when version = 'Budget' then value end) as budget_value,
    date,
    year,
    quarter,
    month

from {{ ref("int_transactions") }} a
left outer join {{ ref("int_customer_type") }} b on a.customertypeid = b.customertypeid
inner join {{ ref("int_date") }} d on a.date = d.date_day
left outer join {{ ref('product_hierarchy') }} p
on p.hierarchyid = a.productcategoryid
left outer join {{ ref('int_customer') }} c
on a.customerid = c.customerid
left outer join {{ ref('int_gl_account') }} g
on g.accountid = a. accountid


group by all
