{% macro date_add(datepart, interval, column, default='INTERVAL') -%}
    {{ return(adapter.dispatch('date_add')(datepart, interval, column)) }}
{%- endmacro %}


{% macro databricks__date_add(datepart, interval, column, default='INTERVAL') -%}
   dateadd({{ datepart }}, {{ interval }}, {{ column }} ) 
{%- endmacro %} 

{% macro bigquery__date_add(datepart, interval, column, default='INTERVAL') -%}
   date_add({{ column }}, {{ default }} {{ interval }} {{ datepart }} )  
{%- endmacro %}