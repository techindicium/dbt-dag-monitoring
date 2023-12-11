with renamed as (
    select
        task_id as task_fail_id
        , task_id
        , dag_id
        , run_id
        , execution_date
        , execution_start_date
        , execution_end_date
        , duration
        , 'not_implemented_for_databricks_workflow' as map_index
    from 
        {{ ref('stg_airflow_monitoring_raw_airflow_monitoring_task_instance') }}
    where 
        state_task_instance in ('MAXIMUM_CONCURRENT_RUNS_REACHED', 'CANCELED', 'FAILED', 'UPSTREAM_FAILED')
)
select * from renamed