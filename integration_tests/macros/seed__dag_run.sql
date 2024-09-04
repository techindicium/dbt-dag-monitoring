{% macro seed__dag_run() -%}
    {{ return(adapter.dispatch('seed__dag_run')()) }}
{%- endmacro %}

{% macro default__seed__dag_run() %}
{% set create_table %}
create or replace table `{{ target.database }}`.{{ target.schema }}.dag_run (
    id INT64,
    dag_id STRING,
    execution_date TIMESTAMP,
    state STRING,
    run_id STRING,
    external_trigger BOOLEAN,
    conf STRING,
    end_date TIMESTAMP,
    start_date TIMESTAMP,
    run_type STRING,
    last_scheduling_decision TIMESTAMP,
    dag_hash STRING,
    creating_job_id INT64,
    queued_at TIMESTAMP,
    data_interval_start TIMESTAMP,
    data_interval_end TIMESTAMP,
    log_template_id INT64,
    updated_at TIMESTAMP
);

{% endset %}

{% set insert_table %}

INSERT INTO `{{ target.database }}`.{{ target.schema }}.dag_run VALUES
(
    87755,
    'airflow_status_monitoring', 
    TIMESTAMP('2024-07-04 10:56:00.000-03'), 
    'success', 
    'scheduled__2024-07-04T13:56:00+00:00', 
    false, 
    'ï¿½\u0004}ï¿½.', 
    TIMESTAMP('2024-07-04 10:57:15.119-03'), 
    TIMESTAMP('2024-07-04 10:57:00.256-03'), 
    'scheduled', 
    TIMESTAMP('2024-07-04 10:57:15.109-03'), 
    '2606cfccb8540961ee80c09fe32dcc8d', 
    110841, 
    TIMESTAMP('2024-07-04 10:57:00.210-03'), 
    TIMESTAMP('2024-07-04 10:56:00.000-03'), 
    TIMESTAMP('2024-07-04 10:57:00.000-03'), 
    1, 
    TIMESTAMP('2024-07-04 10:57:15.120-03')
),
(
    84260, 
    'dag_tags_rbac', 
    TIMESTAMP('2024-07-02 05:30:00.000-03'), 
    'success', 
    'scheduled__2024-07-02T08:30:00+00:00', 
    false, 
    'ï¿½\u0004}ï¿½.', 
    TIMESTAMP('2024-07-02 06:01:20.844-03'), 
    TIMESTAMP('2024-07-02 06:00:00.624-03'), 
    'scheduled', 
    TIMESTAMP('2024-07-02 06:01:20.836-03'), 
    '3616896069a7d5a3b40f4478372f03da', 
    110841, 
    TIMESTAMP('2024-07-02 06:00:00.550-03'),
    TIMESTAMP('2024-07-02 05:30:00.000-03'), 
    TIMESTAMP('2024-07-02 06:00:00.000-03'), 
    1, 
    TIMESTAMP('2024-07-02 06:01:20.848-03')
);

{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table dag_run", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table dag_run", info=true) %}


{% endmacro %}