{% macro replace_dot_for_colon(struct_column, column_item) -%}
    {{ return(adapter.dispatch('replace_dot_for_colon')(struct_column, column_item)) }}
{%- endmacro %}

{% macro default__replace_dot_for_colon(struct_column, column_item) -%}
  {{ struct_column }}.{{ column_item }}
{%- endmacro %}

{% macro snowflake__replace_dot_for_colon(struct_column, column_item) -%}
   {{ struct_column }}:{{ column_item }}
{%- endmacro %}