with
    dim_dag as (
        select 
            dag_id
            , dag_sk as dag_fk
        from {{ ref('dim_dag_monitoring_dag') }}
    )
    , util_days as (
        select cast(date_day as date) as date_day
        from {{ ref('dbt_utils_day') }}
    )
    , stg_dag_run as (
        {% for src in var('enabled_sources') -%}
        select 
            dag_run_id
            , dag_id
            , run_id
            , run_date
            , execution_start_date
            , execution_end_date
            , duration
            , dag_state
            , external_trigger
            , run_type
            , '{{ src }}' as source_system
        from {{ ref('stg_dag_run_' + src) }}
        {% if not loop.last -%} union {% endif -%}
        {% endfor -%}
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
            , stg_dag_run.duration
            , stg_dag_run.source_system
        from stg_dag_run
        left join dim_dag on stg_dag_run.dag_id = dim_dag.dag_id
        left join util_days on {{ cast_as_date('stg_dag_run.run_date') }} = {{ cast_as_date('util_days.date_day') }}
    )
    , joined_with_sk as (
        select 
            {{ dbt_utils.generate_surrogate_key([
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
            , duration
            , source_system
        from joined
    )
select *
from joined_with_sk
