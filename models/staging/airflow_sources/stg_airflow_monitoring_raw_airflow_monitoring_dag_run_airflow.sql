with
    renamed as (
        select distinct
            {{ cast_as_string('id') }} as dag_run_id
            , {{ cast_as_string('dag_id') }} as dag_id
            , {{ cast_as_date('start_date') }} as run_date
            , state as dag_state
            , external_trigger
            , start_date as execution_start_date
            , end_date as execution_end_date
            , (end_date - start_date) as duration
            , run_type
            , {{ cast_as_string('run_id') }} as run_id
        from {{ source('raw_airflow_monitoring', 'dag_run') }}
    )
select *
from renamed
