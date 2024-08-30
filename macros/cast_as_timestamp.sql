{% macro cast_as_timestamp(column, n=1000) -%}
    {{ return(adapter.dispatch('cast_as_timestamp')(column, n=1000)) }}
{%- endmacro %}


{% macro databricks__cast_as_timestamp(column, n=1000) -%}
   to_timestamp({{ column }} / {{ n }} ) 
{%- endmacro %} 

{% macro bigquery__cast_as_timestamp(column, n=1000) -%}
   TIMESTAMP_SECONDS(cast({{ column }} / {{ n }} as int)) 
{%- endmacro %}