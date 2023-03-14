{% set my_query %}
    select cast({{dbt_utils.current_timestamp()}} as date)
{% endset %}

{% if execute %}
{% set today = run_query(my_query).columns[0].values()[0] %}
{% set tomorrow = dbt_utils.dateadd('day', 1, today) %}
{% else %}
{% set tomorrow = ' ' %}
{% endif %}

{{ dbt_utils.date_spine(
datepart="day",
start_date="'2016-01-01'",
end_date="cast('{{tomorrow}}' as date)"
)
}}