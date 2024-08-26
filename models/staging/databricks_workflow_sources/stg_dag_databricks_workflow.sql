with
    renamed as (
        select
            {{ cast_as_string('job_id') }} as dag_id
            , settings.name as dag_name
            , 'not_implemented_for_databricks_workflow' as dag_description
            , 'not_implemented_for_databricks_workflow'  as dag_frequency
            , settings.schedule.quartz_cron_expression as timetable_description
            , case
                when settings.schedule.pause_status = 'PAUSED' then true
                else false
            end as is_paused
            , case
                when settings.schedule.pause_status != 'PAUSED' then true
                else false
            end as is_active
            , 'not_implemented_for_databricks_workflow' as fileloc
            , creator_user_name as owners
            , null as ind_extraction_date
            , settings.schedule.pause_status as pause_status
        from {{ source('raw_databricks_workflow_monitoring', 'jobs') }}
)
select *
from renamed
