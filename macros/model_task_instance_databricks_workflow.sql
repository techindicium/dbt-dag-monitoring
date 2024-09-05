{% macro model_task_instance_databricks_workflow() -%}
    {{ return(adapter.dispatch('model_task_instance_databricks_workflow')()) }}
{%- endmacro %}


{% macro default__model_task_instance_databricks_workflow() -%}
    with
        flatten_data as (
            select
                job_runs.job_id
                , job_runs.inserteddate as inserted_date
                , exploded_tasks.*
            from
                {{ source('raw_databricks_workflow_monitoring', 'job_runs') }} as job_runs
                {{ flatten_data('tasks') }} as exploded_tasks
        ) 
        , renamed as (
            select 
                {{ cast_as_string("flatten_data.task_key") }} as task_id
                , {{ cast_as_string("flatten_data.job_id") }} as dag_id
                , {{ cast_as_string("flatten_data.run_id") }} as run_id
                , {{cast_as_timestamp('flatten_data.start_time')}} as execution_date
                , {{cast_as_timestamp('flatten_data.start_time')}} as execution_start_date
                , {{cast_as_timestamp('flatten_data.end_time')}} as execution_end_date
                , (flatten_data.execution_duration / 1000) as duration
                , {{replace_dot_for_colon('state','result_state')}} as state_task_instance
                , attempt_number as try_number
                , {{replace_dot_for_colon('notebook_task','notebook_path')}} as hostname
                , 'not_implemented_for_databricks_workflow' as task_pool
                , 'not_implemented_for_databricks_workflow' as priority_weight
                , case 
                    when {{replace_dot_for_colon('notebook_task','notebook_path')}} is not null then
                        {{replace_dot_for_colon('notebook_task','notebook_path')}} 
                    else flatten_data.task_key
                end as operator
                , 'not_implemented_for_databricks_workflow' as map_index
            from flatten_data
        )
    select 
        {{ dbt_utils.generate_surrogate_key(['task_id', 'dag_id', 'run_id']) }} as task_instance_sk
        , * 
    from renamed
{%- endmacro %}

{% macro snowflake__model_task_instance_databricks_workflow() -%}
    with
        flatten_data as (
            select *
            from
                {{ source('raw_databricks_workflow_monitoring', 'job_runs') }} as job_runs
                {{ flatten_data('"tasks"') }} as exploded_tasks
        ) 
        , renamed as (
            select 
                {{ cast_as_string("value:task_key") }} as task_id
                , {{ cast_as_string("job_id") }} as dag_id
                , {{ cast_as_string("run_id") }} as run_id
                , {{cast_as_timestamp('start_time')}} as execution_date
                , {{cast_as_timestamp('start_time')}} as execution_start_date
                , {{cast_as_timestamp('end_time')}} as execution_end_date
                , (execution_duration / 1000) as duration
                , {{replace_dot_for_colon('state','result_state')}} as state_task_instance
                , {{replace_dot_for_colon('value','attempt_number')}} as try_number
                , {{replace_dot_for_colon('value','notebook_task.notebook_path')}} as hostname
                , 'not_implemented_for_databricks_workflow' as task_pool
                , 'not_implemented_for_databricks_workflow' as priority_weight
                , case 
                    when {{replace_dot_for_colon('value','notebook_task.notebook_path')}} is not null then
                        {{replace_dot_for_colon('value','notebook_task.notebook_path')}} 
                    else {{replace_dot_for_colon('value','task_key')}}
                end as operator
                , 'not_implemented_for_databricks_workflow' as map_index
            from flatten_data
        )
    select 
        {{ dbt_utils.generate_surrogate_key(['task_id', 'dag_id', 'run_id']) }} as task_instance_sk
        , * 
    from renamed
{%- endmacro %}
