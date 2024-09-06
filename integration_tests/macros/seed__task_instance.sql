{% macro seed__task_instance() %}
{% set create_table %}
  CREATE OR REPLACE TABLE `{{ target.database }}`.{{ target.schema }}.task_instance (
    TASK_ID STRING,
    DAG_ID STRING,
    RUN_ID STRING,
    START_DATE TIMESTAMP,
    END_DATE TIMESTAMP,
    DURATION FLOAT64,
    STATE STRING,
    TRY_NUMBER INT64,
    HOSTNAME STRING,
    UNIXNAME STRING,
    JOB_ID NUMERIC,
    POOL STRING,
    QUEUE STRING,
    PRIORITY_WEIGHT INT64,
    OPERATOR STRING,
    QUEUED_DTTM TIMESTAMP,
    PID INT64,
    MAX_TRIES INT64,
    EXECUTOR_CONFIG STRING,
    POOL_SLOTS INT64,
    QUEUED_BY_JOB_ID NUMERIC,
    EXTERNAL_EXECUTOR_ID NUMERIC,
    TRIGGER_ID NUMERIC,
    TRIGGER_TIMEOUT INT64,
    NEXT_METHOD INT64,
    NEXT_KWARGS INT64,
    MAP_INDEX INT64,
    UPDATED_AT TIMESTAMP
  );

{% endset %}

{% set insert_table %}

INSERT INTO `{{ target.database }}`.{{ target.schema }}.task_instance (
    TASK_ID,
    DAG_ID,
    RUN_ID,
    START_DATE,
    END_DATE,
    DURATION,
    STATE,
    TRY_NUMBER,
    HOSTNAME,
    UNIXNAME,
    JOB_ID,
    POOL,
    QUEUE,
    PRIORITY_WEIGHT,
    OPERATOR,
    QUEUED_DTTM,
    PID,
    MAX_TRIES,
    EXECUTOR_CONFIG,
    POOL_SLOTS,
    QUEUED_BY_JOB_ID,
    EXTERNAL_EXECUTOR_ID,
    TRIGGER_ID,
    TRIGGER_TIMEOUT,
    NEXT_METHOD,
    NEXT_KWARGS,
    MAP_INDEX,
    UPDATED_AT
)
VALUES
(
    'dbt_source_test',
    'dbt_bitrix',
    'scheduled__2023-01-12T06:00:00+00:00',
    TIMESTAMP('2023-12-27T02:30:16.714366Z'),
    TIMESTAMP('2023-12-21T09:01:57.631415Z'),
    20.207217,
    'success',
    1,
    'dbtbitrixdb1374e48913fad10b54fdd67',
    'root',
    332,
    'default_pool',
    'default',
    17,
    'DockerOperator',
    '2024-02-02T11:01:54.071588Z',
    21,
    2,
    '�\u0004}�.',
    1,
    201,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    -1,
    NULL
),
(
    'dump_table1_to_DL',
    'sample_fist',
    'scheduled__2022-02-03T00:00:00+00:00',
    TIMESTAMP('2023-12-21T09:01:57.631415Z'),
    TIMESTAMP('2023-12-23T08:30:25.791135Z'),
    0.700336,
    'success',
    1,
    'samplefistdumpa58b822dbb5f5c21bec',
    'root',
    20,
    'default_pool',
    'default',
    2,
    'BashOperator',
    '2024-02-02T11:02:10.162511Z',
    21,
    1,
    '�\u0004}�.',
    1,
    7,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    -1,
    NULL
);


{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table task_instance", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table task_instance", info=true) %}

{% endmacro %}