{% macro seed__task_fail() %}
{% set create_table %}
  CREATE OR REPLACE TABLE `{{ target.database }}`.{{ target.schema }}.task_fail (
    id INT64,
    task_id STRING,
    dag_id STRING,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    duration INT64,
    map_index INT64,
    run_id STRING
  );
{% endset %}

{% set insert_table %}

  INSERT INTO `{{ target.database }}`.{{ target.schema }}.task_fail (
    id, task_id, dag_id, start_date, end_date, duration, map_index, run_id
  ) VALUES
    (1, 'dbt_freshness', 'dbt_bitrix', TIMESTAMP('2023-12-27T02:30:16.714366Z'), TIMESTAMP('2023-12-21T09:01:57.631415Z'), 1, -1, 'scheduled__2022-12-11T06:00:00+00:00'),
    (2, 'dbt_source_test', 'dbt_bitrix', TIMESTAMP('2023-12-21T09:01:57.073097Z'), TIMESTAMP('2023-12-23T08:30:25.791135Z'), 1, -1, 'scheduled__2022-12-11T06:00:00+00:00');

{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table task_fail", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table task_fail", info=true) %}

{% endmacro %}