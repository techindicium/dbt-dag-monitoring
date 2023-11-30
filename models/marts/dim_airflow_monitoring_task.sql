with
    stg_task_instance as (
        select distinct 
            task_id
            , dag_id
            , hostname
            , operator
            , task_pool
            , map_index
        from {{ ref('stg_airflow_monitoring_raw_airflow_monitoring_task_instance') }} 
    )   
    , stg_task_fail as (
        select distinct 
            task_id
            , dag_id
            , map_index
            , null as hostname
            , null as operator
            , null as task_pool
        from {{ ref('stg_airflow_monitoring_raw_airflow_monitoring_task_fail') }}
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
            {{ dbt_utils.surrogate_key([
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
