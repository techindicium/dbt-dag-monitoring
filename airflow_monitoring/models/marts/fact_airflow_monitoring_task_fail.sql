with
    dim_dag as (
        select 
            dag_id
            , dag_sk as dag_fk
        from {{ ref('dim_airflow_monitoring_dag') }}
    )
    , dim_task as (
        select
            task_sk as task_fk
            , task_id
            , dag_id
        from {{ ref('dim_airflow_monitoring_task') }}
    )
    , dim_datas as (
        select generated_date
        from {{ ref('dim_datas') }}
    )
    , stg_task_fail as (
        select 
            task_fail_id
            , task_id
            , dag_id
            , run_id
            , execution_start_date
            , execution_end_date
            , duration
            , execution_date
            , map_index
        from {{ ref('stg_airflow_monitoring_raw_airflow_monitoring_task_fail') }}
    )
    , joined as (
        select
            stg_task_fail.task_fail_id
            , stg_task_fail.task_id
            , dim_dag.dag_id
            , stg_task_fail.run_id
            , dim_dag.dag_fk
            , dim_task.task_fk
            , dim_datas.generated_date
            , stg_task_fail.execution_start_date
            , stg_task_fail.execution_end_date
            , stg_task_fail.duration
        from stg_task_fail
        left join dim_dag on stg_task_fail.dag_id = dim_dag.dag_id
        left join dim_task on 
            stg_task_fail.task_id = dim_task.task_id
            and stg_task_fail.dag_id = dim_task.dag_id
        left join dim_datas on stg_task_fail.execution_date = dim_datas.generated_date
    )
    , surrogate_key as (
        select
            {{ dbt_utils.surrogate_key([
                'task_fail_id'
                , 'execution_start_date'
                , 'execution_end_date'
                , 'run_id']
            ) }} as task_fail_sk
            , dag_fk
            , task_fk
            , generated_date
            , execution_start_date
            , execution_end_date
            , duration
        from joined
    )
select *
from surrogate_key
