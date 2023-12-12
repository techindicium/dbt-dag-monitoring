{% macro cast_as_string(column) -%}
    {{ return(adapter.dispatch('cast_as_string')(column)) }}
{%- endmacro %}


{% macro default__cast_as_string(column) -%}
   cast({{ column }} as string) 
{%- endmacro %} 
