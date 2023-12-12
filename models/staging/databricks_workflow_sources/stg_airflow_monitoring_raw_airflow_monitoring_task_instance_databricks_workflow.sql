with tasks as (
    select 
        *
    from 
        {{ source('raw_databricks_workflow_monitoring', 'databricks_job_runs') }} dag_runs
    lateral view explode(dag_runs.tasks) as task
),  
renamed as (
    select 
        {{ cast_as_string('task.task_key') }} as task_id
        , {{ cast_as_string('job_id') }} as dag_id
        , {{ cast_as_string('run_id') }} as run_id
        , from_unixtime( task.start_time / 1000) as execution_date
        , from_unixtime( task.start_time / 1000) as execution_start_date
        , from_unixtime( task.end_time / 1000) as execution_end_date
        , (execution_duration / 1000) as duration
        , task.state.result_state as state_task_instance
        , task.attempt_number as try_number
        , task.notebook_task.notebook_path as hostname
        , 'not_implemented_for_databricks_workflow' as task_pool
        , 'not_implemented_for_databricks_workflow' as priority_weight
        , case 
            when task.notebook_task.notebook_path is not null then task.notebook_task.notebook_path 
            else task.task_key
        end as operator
        , 'not_implemented_for_databricks_workflow' as map_index
    from tasks
)
select 
    {{ dbt_utils.generate_surrogate_key(['task_id', 'dag_id', 'run_id']) }} as task_instance_sk
    , * 
from 
    renamed