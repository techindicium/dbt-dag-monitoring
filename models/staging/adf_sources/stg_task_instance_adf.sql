with
    renamed as (
        select distinct
            {{ cast_as_string('activityRunId') }} as task_id
            , {{ cast_as_string('pipelineName') }} as dag_id
            , {{ cast_as_string('pipelineRunId') }} as run_id
            , {{ cast_as_date('activityRunStart') }} as execution_date
            , activityRunStart as execution_start_date
            , activityRunEnd as execution_end_date
            , durationInMs / 1000 as duration
            , status as state_task_instance
            , retryAttempt as try_number
            , 'not_implemented_for_adf' as hostname
            , 'not_implemented_for_adf' as task_pool
            , 'not_implemented_for_adf' as priority_weight
            , activityName as operator
            , 'not_implemented_for_adf' as map_index
        from {{ source('raw_adf_monitoring', 'adf_activity_runs') }}
    )

, created_id as (
        /*Im not sure this is necessary for adf*/
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
