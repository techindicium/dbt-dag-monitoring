with
    stg_dag as (
    {% for src in var('enabled_sources') -%}
        select
            dag_id
            , dag_name
            , dag_description
            , dag_frequency
            , timetable_description
            , is_paused
            , is_active
            , fileloc
            , owners 
            , '{{ src }}' as source_system
        from         
            {{ ref('stg_airflow_monitoring_raw_airflow_monitoring_dag_' + src) }}
        {% if not loop.last -%} union {% endif -%}
    {% endfor -%}
    )
    , stg_dag_with_sk as (
        select
            {{ dbt_utils.surrogate_key(['dag_id']) }} as dag_sk
            , *
        from stg_dag
    )
select *
from stg_dag_with_sk