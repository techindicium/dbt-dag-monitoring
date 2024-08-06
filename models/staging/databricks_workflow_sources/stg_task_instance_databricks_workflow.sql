with tasks_ as (
    select *
    from
        {{ source('raw_databricks_workflow_monitoring', 'job_runs') }},
        lateral flatten(input => tasks)
)

, renamed as (
    select
        cast(tasks_.tasks.key as string) as task_id
        , cast(tasks.job_id as string) as dag_id
        , cast(tasks.run_id as string) as run_id
        , to_timestamp(tasks_.tasks.start_time / 1000) as execution_date
        , to_timestamp(tasks_.tasks.start_time / 1000) as execution_start_date
        , to_timestamp(tasks_.tasks.end_time / 1000) as execution_end_date
        , (tasks_.tasks.execution_duration / 1000) as duration
        , tasks_.state.result_state as state_task_instance
        , tasks_.tasks.attempt_number as try_number
        , tasks_.tasks.notebook_task.notebook_path as hostname
        , 'not_implemented_for_databricks_workflow' as task_pool
        , 'not_implemented_for_databricks_workflow' as priority_weight
        , case
            when tasks_.tasks.notebook_task:notebook_path is not null then tasks_.tasks.notebook_task:notebook_path
            else tasks_.tasks.key
        end as operator
        , 'not_implemented_for_databricks_workflow' as map_index
    from tasks_
)

select
    {{ dbt_utils.generate_surrogate_key(['task_id', 'dag_id', 'run_id']) }} as task_instance_sk
    , *
from
    renamed
