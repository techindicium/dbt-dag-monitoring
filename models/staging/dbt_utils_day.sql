{% set my_query %}
    select cast({{current_timestamp()}} as date)
{% endset %}

{% if execute %}
    {% set today = run_query(my_query).columns[0].values()[0] %}
    {% set tomorrow = dateadd('day', 1, "'" ~ today ~ "'") %}
    {% set start_date = var('dbt_dag_monitoring')['dag_monitoring_start_date'] %}
    {% else %}
    {% set tomorrow = ' ' %}
    {% set start_date = ' ' %}
{% endif %}

{{ dbt_utils.date_spine(
    datepart="day",
    start_date=start_date,
    end_date=tomorrow
)
}}