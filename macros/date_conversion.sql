{% macro convert_yyyymmdd(column_name) %}
    try_to_date(cast({{ column_name }} as varchar), 'YYYYMMDD')
{% endmacro %}
