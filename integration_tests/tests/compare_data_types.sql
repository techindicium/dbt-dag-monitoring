with base as (
    select
        column_name,
        data_type
    from system.information_schema.columns
    where
    column_name IN ("run_id","job_id","trigger","start_time","end_time","execution_duration","run_type","tasks")
    AND
    table_catalog = '{{ target.database }}'
    AND
    table_schema = '{{ target.schema }}'
    AND
    table_name = 'databricks_job_runs'
),

compare as (
    select
        column_name,
        data_type
    from system.information_schema.columns
    where 
    column_name IN ("run_id","job_id","trigger","start_time","end_time","execution_duration","run_type","tasks")
    AND
    table_catalog = '{{ var('dag_monitoring_databricks_database')}}'
    AND
    table_schema = '{{ var('dag_monitoring_databricks_schema') }}'
    AND
    table_name = 'job_runs'
)

select
    base.column_name,
    base.data_type as base_data_type,
    compare.data_type as compare_data_type,
    count (*) as difference
from base
left join compare
on base.column_name = compare.column_name
where base.data_type != compare.data_type
group by 1, 2, 3
having difference > 0
