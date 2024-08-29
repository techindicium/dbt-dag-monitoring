with
    dim_dag as (
        select 
            dag_id
            , dag_sk as dag_fk
        from {{ ref('dim_dag_monitoring_dag') }}
    )
    , dim_task as (
        select
            task_sk as task_fk
            , task_id
            , dag_id
        from {{ ref('dim_dag_monitoring_task') }} 
    )
    , util_days as (
        select cast(date_day as date) as date_day
        from {{ ref('dbt_utils_day') }}
    )
    , stg_task_fail as (
        {% for src in var('enabled_sources') -%}
        select 
            task_fail_id
            , task_id
            , dag_id
            , run_id
            , execution_start_date
            , execution_end_date
            , duration
            , execution_date
            , map_index
            , '{{ src }}' as source_system
        from {{ ref('stg_task_fail_' + src) }}
        {% if not loop.last -%} union {% endif -%}
        {% endfor -%}
    )
    , joined as (
        select
            stg_task_fail.task_fail_id
            , stg_task_fail.task_id
            , dim_dag.dag_id
            , stg_task_fail.run_id
            , dim_dag.dag_fk
            , dim_task.task_fk
            , util_days.date_day
            , stg_task_fail.execution_start_date
            , stg_task_fail.execution_end_date
            , stg_task_fail.duration
            , stg_task_fail.source_system
        from stg_task_fail
        left join dim_dag on stg_task_fail.dag_id = dim_dag.dag_id
        left join dim_task on 
            stg_task_fail.task_id = dim_task.task_id
            and stg_task_fail.dag_id = dim_task.dag_id
        left join util_days on {{ cast_as_date('stg_task_fail.execution_date') }} = {{ cast_as_date('util_days.date_day') }}
    )
    , surrogate_key as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'task_fail_id'
                , 'execution_start_date'
                , 'execution_end_date'
                , 'run_id']
            ) }} as task_fail_sk
            , dag_fk
            , task_fk
            , date_day as generated_date
            , execution_start_date
            , execution_end_date
            , duration
            , source_system
        from joined
    )
select *
from surrogate_key
