{% macro day_of_week_per_platform(column) %}
    {{ return(adapter.dispatch('day_of_week_per_platform')(column)) }}
{%- endmacro %}

{% macro databricks__day_of_week_per_platform(column) %}
            case
                when {{ column }} = 1 then 'Sunday'
                when {{ column }} = 2 then 'Monday'
                when {{ column }} = 3 then 'Tuesday'
                when {{ column }} = 4 then 'Wednesday'
                when {{ column }} = 5 then 'Thursday'
                when {{ column }} = 6 then 'Friday'
                when {{ column }} = 7 then 'Saturday'
            end as name_of_day
{% endmacro %}

{% macro snowflake__day_of_week_per_platform(column) %}
            case
                when {{ column }} = 0 then 'Domingo'
                when {{ column }} = 1 then 'Monday'
                when {{ column }} = 2 then 'Tuesday'
                when {{ column }} = 3 then 'Wednesday'
                when {{ column }} = 4 then 'Thursday'
                when {{ column }} = 5 then 'Friday'
                when {{ column }} = 6 then 'Saturday'
            end as name_of_day
{% endmacro %}

{% macro bigquery__day_of_week_per_platform(column) %}
            case
                when {{ column }} = 1 then 'Domingo'
                when {{ column }} = 2 then 'Monday'
                when {{ column }} = 3 then 'Tuesday'
                when {{ column }} = 4 then 'Wednesday'
                when {{ column }} = 5 then 'Thursday'
                when {{ column }} = 6 then 'Friday'
                when {{ column }} = 7 then 'Saturday'
            end as name_of_day
{% endmacro %}