{% macro de_para_dias_da_semana(column) %}
    {{ return(adapter.dispatch('de_para_dias_da_semana')(column)) }}
{%- endmacro %}

{% macro databricks__de_para_dias_da_semana(column) %}
            case
                when {{ column }} = 1 then 'Domingo'
                when {{ column }} = 2 then 'Segunda-feira'
                when {{ column }} = 3 then 'Terça-feira'
                when {{ column }} = 4 then 'Quarta-feira'
                when {{ column }} = 5 then 'Quinta-feira'
                when {{ column }} = 6 then 'Sexta'
                when {{ column }} = 7 then 'Sábado'
            end as nome_do_dia
{% endmacro %}

{% macro snowflake__de_para_dias_da_semana(column) %}
            case
                when {{ column }} = 0 then 'Domingo'
                when {{ column }} = 1 then 'Segunda-feira'
                when {{ column }} = 2 then 'Terça-feira'
                when {{ column }} = 3 then 'Quarta-feira'
                when {{ column }} = 4 then 'Quinta-feira'
                when {{ column }} = 5 then 'Sexta'
                when {{ column }} = 6 then 'Sábado'
            end as nome_do_dia
{% endmacro %}

{% macro bigquery__de_para_dias_da_semana(column) %}
            case
                when {{ column }} = 1 then 'Domingo'
                when {{ column }} = 2 then 'Segunda-feira'
                when {{ column }} = 3 then 'Terça-feira'
                when {{ column }} = 4 then 'Quarta-feira'
                when {{ column }} = 5 then 'Quinta-feira'
                when {{ column }} = 6 then 'Sexta'
                when {{ column }} = 7 then 'Sábado'
            end as nome_do_dia
{% endmacro %}