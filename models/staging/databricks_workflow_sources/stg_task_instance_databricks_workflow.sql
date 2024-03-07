with tasks as (
    select 
        *
    from 
        {{ source('raw_databricks_workflow_monitoring', 'job_runs') }},
        lateral flatten(input => tasks)
),  
renamed as (
    select 
        cast(tasks.key as string) as task_id
        , cast(job_id as string) as dag_id
        , cast(run_id as string) as run_id
        , to_timestamp( tasks.start_time / 1000) as execution_date
        , to_timestamp( tasks.start_time / 1000) as execution_start_date
        , to_timestamp( tasks.end_time / 1000) as execution_end_date
        , (execution_duration / 1000) as duration
        , tasks.state:result_state as state_task_instance
        , tasks.attempt_number as try_number
        , tasks:notebook_task:notebook_path as hostname
        , 'not_implemented_for_databricks_workflow' as task_pool
        , 'not_implemented_for_databricks_workflow' as priority_weight
        , case 
            when tasks:notebook_task:notebook_path is not null then tasks:notebook_task:notebook_path 
            else tasks.key
        end as operator
        , 'not_implemented_for_databricks_workflow' as map_index
    from tasks
)
select 
    {{ dbt_utils.generate_surrogate_key(['task_id', 'dag_id', 'run_id']) }} as task_instance_sk
    , * 
from 
    renamed