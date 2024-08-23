{% macro day_of_year(column) -%}
    {{ return(adapter.dispatch('day_of_year')(column)) }}
{%- endmacro %}


{% macro default__day_of_year(column) -%}
   extract(dayofyear from {{ column }})
{%- endmacro %}


{% macro databricks__day_of_year(column) -%}
   extract(doy from {{ column }})
{%- endmacro %}