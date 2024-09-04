with
    renamed as (
        select
            {{ cast_as_string('run_id') }} as dag_run_id
            , {{ cast_as_string('job_id') }} as dag_id
            , {{cast_as_timestamp('start_time')}} as run_date
            , {{replace_dot_for_colon('state','result_state')}} as dag_state
            , "trigger" as external_trigger
            , {{cast_as_timestamp('start_time')}} as execution_start_date
            , {{cast_as_timestamp('end_time')}} as execution_end_date
            , execution_duration / 1000 as duration
            , run_type
            , {{ cast_as_string('run_id') }} as run_id
        from {{ source('raw_databricks_workflow_monitoring', 'job_runs') }}
)
select *
from renamed
