with
    tasks as (
        select
            job_id
            , InsertedDate as inserted_date
            , exploded_data.*
        from {{ source('raw_databricks_workflow_monitoring_test', 'job_runs') }}
        lateral view explode (tasks) as exploded_data
    )
    
    , renamed as (
        select
            cast(tasks.task_key as string) as task_id
            , cast(tasks.job_id as string) as dag_id
            , cast(tasks.run_id as string) as run_id
            , to_timestamp( tasks.start_time / 1000) as execution_date
            , to_timestamp( tasks.start_time / 1000) as execution_start_date
            , to_timestamp( tasks.end_time / 1000) as execution_end_date
            , (tasks.execution_duration / 1000) as duration
            , tasks.state.result_state as state_task_instance
            , tasks.attempt_number as try_number
            , notebook_task.notebook_path as hostname
            , 'not_implemented_for_databricks_workflow' as task_pool
            , 'not_implemented_for_databricks_workflow' as priority_weight
            , case
                when notebook_task.notebook_path is not null then notebook_task.notebook_path
                else task_key
            end as operator
            , 'not_implemented_for_databricks_workflow' as map_index
        from tasks
        qualify
            row_number() over(
                partition by
                    task_id
                    , dag_id
                    , run_id
                order by inserted_date desc
            ) = 1
    )
    
select
    {{ dbt_utils.generate_surrogate_key(['task_id', 'dag_id', 'run_id']) }} as task_instance_sk
    , *
from renamed