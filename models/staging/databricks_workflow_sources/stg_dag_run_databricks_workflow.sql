with
    renamed as (
        select
            {{ cast_as_string('run_id') }} as dag_run_id
            , {{ cast_as_string('job_id') }} as dag_id
            , to_timestamp(start_time / 1000) as run_date
            , state.result_state as dag_state
            , `trigger` as external_trigger
            , to_timestamp(start_time / 1000) as execution_start_date
            , to_timestamp(end_time / 1000) as execution_end_date
            , execution_duration / 1000 as duration
            , run_type
            , {{ cast_as_string('run_id') }} as run_id
        from {{ source('raw_databricks_workflow_monitoring', 'job_runs') }}
)
select *
from renamed
