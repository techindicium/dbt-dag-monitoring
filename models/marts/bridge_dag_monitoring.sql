with
    fact_dag_run as (
        select
            dag_run_sk
            , dag_fk
            , generated_date
        from {{ ref('fact_dag_monitoring_dag_run') }}
    )
    , fact_task_fail as (
        select
            task_fail_sk
            , dag_fk
            , task_fk
            , generated_date
        from {{ ref('fact_dag_monitoring_task_fail') }}
    )
    , fact_task_instance as (
        select
            task_instance_sk
            , dag_fk
            , task_fk
            , generated_date
        from {{ ref('fact_dag_monitoring_task_instance') }}
    )
    , bridge as (
        select
            coalesce(fact_task_instance.generated_date, fact_dag_run.generated_date, fact_task_fail.generated_date) as generated_date
            , coalesce(fact_dag_run.dag_fk, fact_task_fail.dag_fk, fact_task_instance.dag_fk) as dag_fk
            , coalesce(fact_task_instance.task_fk, fact_task_fail.task_fk) as task_fk
            , fact_dag_run.dag_run_sk as dag_run_fk
            , fact_task_fail.task_fail_sk as task_fail_fk
            , fact_task_instance.task_instance_sk as task_instance_fk
        from fact_task_instance
        full outer join fact_task_fail
            on fact_task_instance.task_fk = fact_task_fail.task_fk
            and fact_task_instance.generated_date = fact_task_fail.generated_date
        full outer join fact_dag_run
            on coalesce(fact_task_instance.dag_fk, fact_task_fail.dag_fk) = fact_dag_run.dag_fk
            and fact_task_instance.generated_date = fact_dag_run.generated_date
    )
select *
from bridge