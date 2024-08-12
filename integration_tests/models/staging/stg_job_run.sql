with raw_data as (
    select 
        *
    from 
        {{ source('raw_databricks_workflow_monitoring', 'databricks_job_run_json') }}
),  
transformed_data as (
    select 
        , cast(raw_data.job_id as string) as dag_id
        , cast(raw_data.run_id as string) as run_id
        , to_timestamp( raw_data.start_time / 1000) as execution_date
        , to_timestamp( raw_data.start_time / 1000) as execution_start_date
        , to_timestamp( raw_data.end_time / 1000) as execution_end_date
        , (raw_data.execution_duration / 1000) as duration
        , from_json(raw_data.tasks, '{{ read_file('integration_tests/schemas/tasks.json') }}') as struct_tasks
    from raw_data
)

select *
from transformed_data