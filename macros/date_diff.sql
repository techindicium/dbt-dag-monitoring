{% macro date_diff(datepart, start_date, end_date) -%}
    {{ return(adapter.dispatch('date_diff')(datepart, start_date, end_date)) }}
{%- endmacro %}

{% macro default__date_diff(datepart, start_date, end_date) -%}
    datediff({{ datepart }}, {{ start_date }}, {{ end_date }})
{%- endmacro %}

{% macro bigquery__date_diff(datepart, start_date, end_date) -%}
    date_diff({{ end_date }}, {{ start_date }}, {{ datepart }})
{%- endmacro %}