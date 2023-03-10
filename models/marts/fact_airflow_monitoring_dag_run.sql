with
    dim_dag as (
        select 
            dag_id
            , dag_sk as dag_fk
        from {{ ref('dim_airflow_monitoring_dag') }}
    )
    , util_days as (
        select * 
        from {{ ref('dbt_utils_day') }}
    )
    , stg_dag_run as (
        select 
            dag_run_id
            , dag_id
            , run_id
            , run_date
            , execution_start_date
            , execution_end_date
            , dag_state
            , external_trigger
            , run_type
        from {{ ref('stg_airflow_monitoring_raw_airflow_monitoring_dag_run') }}
    )
    , joined as (
        select
            stg_dag_run.dag_run_id
            , dim_dag.dag_fk
            , dim_dag.dag_id
            , stg_dag_run.run_id
            , util_days.date_day
            , stg_dag_run.execution_start_date
            , stg_dag_run.execution_end_date
            , stg_dag_run.dag_state
            , stg_dag_run.external_trigger
            , stg_dag_run.run_type 
        from stg_dag_run
        left join dim_dag on stg_dag_run.dag_id = dim_dag.dag_id
        left join util_days on stg_dag_run.run_date = util_days.date_day
    )
    , joined_with_sk as (
        select 
            {{ dbt_utils.surrogate_key([
                'dag_run_id'
                , 'execution_start_date'
                , 'execution_end_date'
                , 'run_id']) }} as dag_run_sk
            , dag_fk
            , date_day as generated_date
            , execution_start_date
            , execution_end_date
            , dag_state
            , external_trigger
            , run_type 
        from joined
    )
select *
from joined_with_sk
