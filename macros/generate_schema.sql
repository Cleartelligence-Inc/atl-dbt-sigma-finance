{% macro generate_schema_name(custom_schema_name, node) -%}
 
{%- set default_schema = target.schema -%}
   
    {%- if custom_schema_name is none -%}
        {{ generate_schema_name_for_env(custom_schema_name, node) }}
   
    {% elif 'fivetran' in custom_schema_name|lower or 'raw' == custom_schema_name|lower -%}
        {{ custom_schema_name | trim }}
 
    {% elif target.name == 'dev'  -%}
        dev_{{ custom_schema_name | trim }}
   
    {% elif target.name == 'qa'  -%}
        qa_{{ custom_schema_name | trim }}
   
    {% elif target.name == 'emerald-target' -%}
        {{ custom_schema_name | trim }}
    {%- else -%}
        {{ generate_schema_name_for_env(custom_schema_name, node) }}
    {% endif %}
{%- endmacro %}