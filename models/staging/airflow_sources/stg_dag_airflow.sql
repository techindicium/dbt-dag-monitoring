with
    renamed as (
        select distinct
            {{ cast_as_string('dag_id') }} as dag_id
            , {{ cast_as_string('dag_id') }} as dag_name
            , description as dag_description
            , case
                when timetable_description like '% hour, between %' then 'hourly'
                when timetable_description like 'Between %' then 'hourly'
                when timetable_description like '% on day % month' then 'monthly'
                when timetable_description like '% in %' then 'monthly'
                when timetable_description like '%:% on %' then 'weekly'
                when timetable_description like '%:%' then 'daily'
                else timetable_description
            end as dag_frequency
            , timetable_description
            , is_paused
            , is_active
            , fileloc
            , owners
        from {{ source('raw_airflow_monitoring', 'dag') }}
    )

select *
from renamed
