with
    renamed as (
        select distinct
            activityRunId::string as task_fail_id
            , activityRunId::string as task_id
            , pipelineName::string as dag_id
            , pipelineRunId as run_id
            , {{ cast_as_date('activityRunStart') }} as execution_date
            , activityRunStart as execution_start_date
            , activityRunEnd as execution_end_date
            , durationInMs / 1000 as duration
            , "not_implemented_for_adf" as map_index
        from {{ source('raw_adf_monitoring', 'adf_activity_runs') }}
        where status in ('TimedOut', 'Cancelled', 'Failed')
    )
select *
from renamed

