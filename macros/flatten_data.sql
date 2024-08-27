{% macro flatten_data(column) -%}
    {{ return(adapter.dispatch('flatten_data')(column)) }}
{%- endmacro %}


{% macro databricks__flatten_data(column) -%}
   lateral view explode ({{ column }})
{%- endmacro %}

{% macro snowflake__flatten_data(column) -%}
  , lateral flatten(input => {{ column }})
{%- endmacro %}

{% macro bigquery__flatten_data(column) -%}
  , unnest({{ column }})
{%- endmacro %}
