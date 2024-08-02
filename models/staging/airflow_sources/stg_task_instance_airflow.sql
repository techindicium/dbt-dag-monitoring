with
    renamed as (
        select distinct
            {{ cast_as_string('task_id') }} as task_id
            , {{ cast_as_string('dag_id') }} as dag_id
            , {{ cast_as_string('run_id') }} as run_id
            , {{ cast_as_date('start_date') }} as execution_date
            , start_date as execution_start_date
            , end_date as execution_end_date
            , duration
            , state as state_task_instance
            , try_number
            , hostname
            , pool as task_pool
            , priority_weight
            , operator
            , case
                when map_index = -1 then 'no mapping'
            end as map_index
        from {{ source('raw_airflow_monitoring', 'task_instance') }}
    )

, created_id as (
        /*Table does not have a unique identifier, the id was created as the unique identification of records*/
        select
            {{ dbt_utils.generate_surrogate_key(['task_id', 'dag_id', 'run_id']) }} as task_instance_sk
            , task_id
            , dag_id
            , run_id
            , execution_date
            , execution_start_date
            , execution_end_date
            , duration
            , state_task_instance
            , try_number
            , hostname
            , task_pool
            , priority_weight
            , operator
            , map_index
        from renamed
    )

select *
from created_id
