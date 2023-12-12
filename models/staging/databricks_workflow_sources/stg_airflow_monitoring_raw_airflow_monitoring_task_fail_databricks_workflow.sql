with renamed as (
    select
        task_id::string as task_fail_id
        , task_id::string
        , dag_id::string
        , run_id
        , execution_date
        , execution_start_date
        , execution_end_date
        , duration
        , 'not_implemented_for_databricks_workflow' as map_index
    from 
        {{ ref('stg_airflow_monitoring_raw_airflow_monitoring_task_instance_databricks_workflow') }}
    where 
        state_task_instance in ('MAXIMUM_CONCURRENT_RUNS_REACHED', 'CANCELED', 'FAILED', 'UPSTREAM_FAILED')
)
select * from renamed