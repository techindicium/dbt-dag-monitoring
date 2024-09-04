{% macro seed__dag() -%}
    {{ return(adapter.dispatch('seed__dag')()) }}
{%- endmacro %}

{% macro default__seed__dag() %}
{% set create_table %}
create or replace table `{{ target.database }}`.{{ target.schema }}.dag (
    dag_id STRING,
    is_paused BOOLEAN,
    is_subdag BOOLEAN,
    is_active BOOLEAN,
    last_parsed_time TIMESTAMP,
    last_pickled TIMESTAMP,
    last_expired TIMESTAMP,
    scheduler_lock STRING,
    pickle_id INT64,
    fileloc STRING,
    owners STRING,
    description STRING,
    default_view STRING,
    schedule_interval STRING,
    root_dag_id STRING,
    next_dagrun TIMESTAMP,
    next_dagrun_create_after TIMESTAMP,
    max_active_tasks INT64,
    has_task_concurrency_limits BOOLEAN,
    max_active_runs INT64,
    next_dagrun_data_interval_start TIMESTAMP,
    next_dagrun_data_interval_end TIMESTAMP,
    has_import_errors BOOLEAN,
    timetable_description STRING,
    processor_subdir STRING
);
{% endset %}

{% set insert_table %}

INSERT INTO `{{ target.database }}`.{{ target.schema }}.dag VALUES
(
    'test_docker', false, false, false, TIMESTAMP('2022-12-16 09:35:19.433-03'), NULL, NULL, '', NULL, 
    '/opt/airflow/dags/repo/airflow/dags/test_dag.py', 'Indicium', '', 'grid', '0 6 * * *', '', 
    TIMESTAMP('2022-12-16 03:00:00.000-03'), TIMESTAMP('2022-12-17 03:00:00.000-03'), 16, false, 16, 
    TIMESTAMP('2022-12-16 03:00:00.000-03'), TIMESTAMP('2022-12-17 03:00:00.000-03'), false, 'At 06:00', ''
),
(
    'dbt', true, false, false, TIMESTAMP('2022-11-25 16:12:51.922-03'), NULL, NULL, '', NULL, 
    '/opt/airflow/dags/repo/airflow/dags/all_dags.py', 'airflow', '', 'grid', '7/15 9-23 * * *', '', 
    TIMESTAMP('2022-02-01 06:07:00.000-03'), TIMESTAMP('2022-02-01 06:22:00.000-03'), 16, false, 1, 
    TIMESTAMP('2022-02-01 06:07:00.000-03'), TIMESTAMP('2022-02-01 06:22:00.000-03'), true, 
    'Every 15 minutes, starting at 7 minutes past the hour, between 09:00 and 23:59', ''
);

{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table dag", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table dag", info=true) %}


{% endmacro %}