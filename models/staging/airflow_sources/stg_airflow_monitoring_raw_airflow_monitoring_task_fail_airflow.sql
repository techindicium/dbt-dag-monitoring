with
    renamed as (
        select distinct
            id::string as task_fail_id
            , task_id::string
            , dag_id::string
            , run_id::string
            , {{ cast_as_date('start_date') }} as execution_date
            , start_date as execution_start_date
            , end_date as execution_end_date
            , duration
            , case 
                when map_index = -1 then 'no mapping'
            end as map_index
        from {{ source('raw_airflow_monitoring', 'task_fail') }}
    )
select *
from renamed
