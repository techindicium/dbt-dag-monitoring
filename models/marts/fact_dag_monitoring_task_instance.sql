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

, stg_task_instance as (
        {% for src in var('enabled_sources') -%}
        select
            task_instance_sk
            , task_id
            , dag_id
            , run_id
            , execution_date
            , execution_start_date
            , execution_end_date
            , duration
            , state_task_instance
            , try_number
            , priority_weight
            , '{{ src }}' as source_system
        from {{ ref('stg_task_instance_' + src) }}
        {% if not loop.last -%} union {% endif -%}
        {% endfor -%}
)

, joined as (
        select
            stg_task_instance.task_instance_sk
            , stg_task_instance.task_id
            , stg_task_instance.dag_id
            , stg_task_instance.run_id
            , dim_dag.dag_fk
            , dim_task.task_fk
            , util_days.date_day
            , stg_task_instance.execution_start_date
            , stg_task_instance.execution_end_date
            , stg_task_instance.duration
            , stg_task_instance.state_task_instance
            , stg_task_instance.try_number
            , stg_task_instance.priority_weight
            , stg_task_instance.source_system
        from stg_task_instance
        left join dim_dag on stg_task_instance.dag_id = dim_dag.dag_id
        left join dim_task on
            stg_task_instance.task_id = dim_task.task_id
            and stg_task_instance.dag_id = dim_task.dag_id
        left join util_days on stg_task_instance.execution_date = util_days.date_day
    )

, surrogate_key as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'task_instance_sk'
                , 'execution_start_date'
                , 'execution_end_date'
                , 'run_id']) }} as task_instance_sk
            , dag_fk
            , task_fk
            , date_day as generated_date
            , execution_start_date
            , execution_end_date
            , duration
            , state_task_instance
            , try_number
            , priority_weight
            , source_system
        from joined
    )

select *
from surrogate_key
