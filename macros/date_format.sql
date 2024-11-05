{% macro month_day(column, format='') -%}
    {{ return(adapter.dispatch('month_day')(column)) }}
{%- endmacro %}


{% macro databricks__month_day(column, format='dd-MM') -%}
   date_format({{ column }}, '{{ format }}')
{%- endmacro %}

{% macro snowflake__month_day(column, format='dd-MM') -%}
   to_char(cast({{ column }} as date), '{{ format }}')
{%- endmacro %}


{% macro bigquery__month_day(column, format='%d-%m') -%}
   cast(parse_date('{{ format }}', cast({{ column }} as string)) as string)
{%- endmacro %}