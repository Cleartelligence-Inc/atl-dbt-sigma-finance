{% macro union_with_priority(
        table_list,
        partition_by,
        priority_column,
        priority_order
    ) %}
{#-
  table_list     → list of dicts [{model: 'ecc_customer', source: 'ECC'}, {model: 's4_customer', source: 'S4'}]
  partition_by   → list of columns to deduplicate on, e.g. ['customerid']
  priority_column→ column that holds the source/priority flag, e.g. 'source'
  priority_order → list of values in order of priority, e.g. ['S4', 'ECC']
-#}

{# Assign priority weight dynamically #}
{% set priority_case = [] %}
{% for val in priority_order %}
    {% set _ = priority_case.append("when " ~ priority_column ~ " = '" ~ val ~ "' then " ~ loop.index) %}
{% endfor %}
{% set priority_case_sql = priority_case | join(' ') %}

{# Union all sources #}
with unioned as (

    {% for tbl in table_list %}
    select
        t.*
    from {{ ref(tbl.model) }} t
    {% if not loop.last %} union all {% endif %}
    {% endfor %}

),

deduped as (
    select
        *
    from unioned
    qualify row_number() over (
        partition by {{ partition_by | join(', ') }}
        order by case {{ priority_case_sql }} else 999 end
    ) = 1
)

select * from deduped

{% endmacro %}
