with renamed as (
    select
        run_id as dag_run_id
        , job_id as dag_id
        , from_unixtime(start_time / 1000) run_date
        , state.result_state as dag_state
        , `trigger`as external_trigger
        , from_unixtime(start_time / 1000) as execution_start_date
        , from_unixtime(end_time / 1000) execution_end_date
        , execution_duration / 1000 as duration
        , run_type
        , run_id
    from
        {{ source('raw_databricks_workflow_monitoring', 'databricks_job_runs') }}
)
select * from renamed
