with
    stg_task_instance as (
        {% for src in var('enabled_sources') -%}
        select distinct 
            task_id
            , dag_id
            , hostname
            , operator
            , task_pool
            , map_index
            , '{{ src }}' as source_system
        from {{ ref('stg_airflow_monitoring_raw_airflow_monitoring_task_instance_' + src) }}
        {% if not loop.last -%} union {% endif -%}
        {% endfor -%}
    )   
    , stg_task_fail as (
        {% for src in var('enabled_sources') -%}
        select distinct 
            task_id
            , dag_id
            , map_index
            , null as hostname
            , null as operator
            , null as task_pool
            , '{{ src }}' as source_system
        from {{ ref('stg_airflow_monitoring_raw_airflow_monitoring_task_fail_' + src) }}
        {% if not loop.last -%} union {% endif -%}
        {% endfor -%}
    )
    , union_task_instance_with_fail as (
        select
            task_id
            , dag_id
            , map_index
            , hostname
            , operator
            , task_pool
        from stg_task_instance
        union all
        select
            task_id
            , dag_id
            , map_index
            , hostname
            , operator
            , task_pool
        from stg_task_fail
    )
    , dedup_dim_task as (
        select
            task_id
            , dag_id
            , map_index
            , hostname
            , operator
            , task_pool
            , row_number() over(
                partition by 
                    task_id
                    , dag_id
                order by 
                    task_id
                    , dag_id
                ) as dedup
        from union_task_instance_with_fail
    )
    , dim_task_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'task_id'
                , 'dag_id']
            ) }} as task_sk
            , task_id
            , dag_id
            , map_index
            , hostname
            , operator
            , task_pool
        from dedup_dim_task
        where dedup = 1
    )
select *
from dim_task_with_sk
