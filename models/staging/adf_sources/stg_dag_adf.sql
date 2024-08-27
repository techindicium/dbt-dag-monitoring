with exploded_by_pipeline as (
    select 
        *
    from 
        {{ source('raw_adf_monitoring', 'adf_triggers') }}
    {{ flatten_data('properties.pipelines') }} as pipelines
), 

triggers_renamed as (
    select
        id as trigger_id
        , case 
            when properties.typeProperties.recurrence.frequency  = 'Hour' then 'hourly'
            when properties.typeProperties.recurrence.frequency  = 'Day' then 'daily'
            when properties.typeProperties.recurrence.frequency  = 'Week' then 'weekly'
            when properties.typeProperties.recurrence.frequency  = 'Month' then 'monthly'
            when properties.typeProperties.recurrence.frequency  = 'Minute' then 'minutely'
        end as dag_frequency
        ,cast(properties.typeProperties.recurrence.schedule as varchar(255)) as timetable_description
        ,properties.typeProperties.recurrence.frequency as adf_frequency
        ,properties.typeProperties.recurrence.startTime as start_time
        , case 
            when properties.runtimeState = 'Started' then 'true'
            else 'false'
            end as is_active
        , case 
            when properties.runtimeState = 'Started' then 'false'
            else 'true'
            end as is_paused
        ,properties.runtimeState
        ,pipelines.pipelineReference.referenceName as pipeline_name
        
    from exploded_by_pipeline
),
pipeline_with_row_number as (
  select 
    *,
    row_number() over (partition by id order by etag desc) row_number
  from {{ source('raw_adf_monitoring', 'adf_pipelines') }}
),
pipeline_dedup as (
    select * from 
    pipeline_with_row_number
    where row_number = 1
),
pipelines_and_triggers as (
    select 
        pipelines.id as dag_id
        ,pipelines.name as dag_name
        ,triggers.*
    from pipeline_dedup pipelines
    left join triggers_renamed triggers
    on pipelines.name = triggers.pipeline_name
)
select 
    {{ cast_as_string('dag_name') }} as dag_id
    , {{ cast_as_string('dag_name') }} as dag_name
    , "not_implemented_for_adf" as dag_description
    , dag_frequency
    , timetable_description
    , is_paused
    , is_active
    , 'not_implemented_for_adf' as fileloc
    , 'not_implemented_for_adf' as owners
    , null as ind_extraction_date
from    
    pipelines_and_triggers
