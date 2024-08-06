with renamed as (
    select
        {{ cast_as_string('task_id') }} as task_fail_id
        , {{ cast_as_string('task_id') }} as task_id
        , {{ cast_as_string('dag_id') }} as dag_id
        , run_id
        , execution_date
        , execution_start_date
        , execution_end_date
        , duration
        , 'not_implemented_for_databricks_workflow' as map_index
    from
        {{ ref('stg_task_instance_databricks_workflow') }}
    where
        state_task_instance in ('MAXIMUM_CONCURRENT_RUNS_REACHED', 'CANCELED', 'FAILED', 'UPSTREAM_FAILED')
)

select * from renamed
