{% macro cast_as_string(column) -%}
    {{ return(adapter.dispatch('cast_as_string')(column)) }}
{%- endmacro %}


{% macro default__cast_as_string(column) -%}
   cast({{ column }} as string) 
{%- endmacro %}

{% macro bigquery__cast_as_string(column) -%}
   {% if column ==  'invokedBy' or column == 'properties.typeProperties.recurrence.schedule' -%}
      {{ column }}
   {% else -%}
      cast({{ column }} as string)
   {% endif -%}
{%- endmacro %}

{% macro redshift__cast_as_string(column) -%}
   cast({{ column }} as varchar) 
{%- endmacro %} 
