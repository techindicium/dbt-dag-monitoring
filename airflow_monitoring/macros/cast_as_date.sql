{% macro cast_as_date(column) -%}
    {{ return(adapter.dispatch('cast_as_date')(column)) }}
{%- endmacro %}


{% macro default__cast_as_date(column) -%}
   cast({{ column }} as date) 
{%- endmacro %}

