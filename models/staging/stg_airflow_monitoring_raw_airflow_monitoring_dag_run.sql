with
    renamed as (
        select distinct
            id as dag_run_id
            , dag_id
            , {{ cast_as_date('start_date') }} as run_date
            , state as dag_state
            , external_trigger
            , start_date as execution_start_date
            , end_date as execution_end_date
            , run_type
            , run_id
        from {{ source('raw_airflow_monitoring', 'dag_run') }}
    )
select *
from renamed
