with
    flatten_data as (
        select
            job_runs.job_id
            , job_runs.inserteddate as inserted_date
            , exploded_tasks.*
        from
            {{ source('raw_databricks_workflow_monitoring', 'job_runs') }} as job_runs
            {{ flatten_data('tasks') }} as exploded_tasks
    ) 
    , renamed as (
        select 
            {{ cast_as_string("flatten_data.task_key") }} as task_id
            , {{ cast_as_string("flatten_data.job_id") }} as dag_id
            , {{ cast_as_string("flatten_data.run_id") }} as run_id
            , {{cast_as_timestamp('flatten_data.start_time')}} as execution_date
            , {{cast_as_timestamp('flatten_data.start_time')}} as execution_start_date
            , {{cast_as_timestamp('flatten_data.end_time')}} as execution_end_date
            , (flatten_data.execution_duration / 1000) as duration
            , state.result_state as state_task_instance
            , attempt_number as try_number
            , notebook_task.notebook_path as hostname
            , 'not_implemented_for_databricks_workflow' as task_pool
            , 'not_implemented_for_databricks_workflow' as priority_weight
            , case 
                when notebook_task.notebook_path is not null then notebook_task.notebook_path 
                else flatten_data.task_key
            end as operator
            , 'not_implemented_for_databricks_workflow' as map_index
        from flatten_data
    )
select 
    {{ dbt_utils.generate_surrogate_key(['task_id', 'dag_id', 'run_id']) }} as task_instance_sk
    , * 
from renamed