with
    renamed as (
        select distinct
            id::string as dag_run_id
            , pipelineName::string as dag_id
            , {{ cast_as_date('runStart') }} as run_date
            , status as dag_state
            , invokedBy::string as external_trigger
            , runStart as execution_start_date
            , runEnd as execution_end_date
            , durationInMs / 1000 as duration
            , "not_implemented_by_adf" as run_type
            , runId::string as run_id
        from {{ source('raw_adf_monitoring', 'adf_pipeline_runs') }}
    )
select *
from renamed
