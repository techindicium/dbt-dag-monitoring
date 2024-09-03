{% macro dia_mes(column, format='') -%}
    {{ return(adapter.dispatch('dia_mes')(column)) }}
{%- endmacro %}


{% macro databricks__dia_mes(column, format='dd-MM') -%}
   date_format({{ column }}, '{{ format }}')
{%- endmacro %}


{% macro bigquery__dia_mes(column, format='%d-%m') -%}
   cast(parse_date('{{ format }}', cast({{ column }} as string)) as string)
{%- endmacro %}