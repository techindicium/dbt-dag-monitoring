{% macro jobs() -%}
    {{ return(adapter.dispatch('jobs')()) }}
{%- endmacro %}

{% macro databricks__jobs() %}
{% set create_table %}
create or replace table `{{ target.database }}`.{{ target.schema }}.jobs (
    created_time BIGINT,
    creator_user_name STRING,
    job_id BIGINT,
    settings STRUCT<
            email_notifications STRUCT<
            on_failure ARRAY<STRING>,
            no_alert_for_skipped_runs BOOLEAN
            >,
        format STRING,
        max_concurrent_runs BIGINT,
        name STRING,
        schedule STRUCT<
            pause_status STRING,
            quartz_cron_expression STRING,
            timezone_id STRING
        >,
        tags STRUCT<
            dev STRING,
            env STRING
        >,
        timeout_seconds bigint,
        trigger STRUCT<
            file_arrival STRUCT<
                url STRING
            >,
            pause_status STRING
        >
    >,
    insertedDate TIMESTAMP
);
{% endset %}

{% set insert_table %}

INSERT INTO `{{ target.database }}`.{{ target.schema }}.jobs VALUES
(
    CAST(1722606667504 AS BIGINT),
    CAST('13bc3f4b-d299-4b58-9d09-5444571518ae' AS STRING),
    CAST(466340877826952 AS BIGINT),
    NAMED_STRUCT(
        'email_notifications', NAMED_STRUCT(
            'on_failure',ARRAY('produtos_horizontais@indicium1.opsgenie.net'),
            'no_alert_for_skipped_runs', NULL
        ),
        'format', 'MULTI_TASK',
        'max_concurrent_runs', 1,
        'name', '[prod] core_dag_monitoring_data_transformation_dbt_job',
        'schedule', NAMED_STRUCT(
            'pause_status', NULL,
            'quartz_cron_expression', NULL,
            'timezone_id', NULL
        ),
        'tags',NAMED_STRUCT(
            'dev', NULL,
            'env','prod'
        ),
        'timeout_seconds', 0,
        'trigger',NAMED_STRUCT(
            'file_arrival',NAMED_STRUCT(
                'url',NULL
            ),
            'paused_status',NULL
        )
    ),
    CAST('2024-08-20T09:11:36.525Z' AS TIMESTAMP)
),
(
    CAST(1722544845800 AS BIGINT),
    CAST('13bc3f4b-d299-4b58-9d09-5444571518ae' AS STRING),
    CAST(823250232903490 AS BIGINT),
    NAMED_STRUCT(
        'email_notifications',NAMED_STRUCT(
            'on_failure', ARRAY('produtos_horizontais@indicium1.opsgenie.net'),
            'no_alert_for_skipped_runs', NULL
        ),
        'format','MULTI_TASK',
        'max_concurrent_runs',1,
        'name','[prod] core_dag_monitoring_extraction_meltano_job',
        'schedule',NAMED_STRUCT(
            'pause_status','UNPAUSED',
            'quartz_cron_expression','0 0 0/3 * * ? *',
            'timezone_id','UTC'
        ),
        'tags',NAMED_STRUCT(
            'dev', NULL,
            'env','prod'
        ),
        'timeout_seconds',0,
        'trigger',NAMED_STRUCT(
            'file_arrival',NAMED_STRUCT(
                'url',NULL
            ),
            'paused_status',NULL
        )
    ),
    CAST('2024-08-20T09:11:36.525Z' AS TIMESTAMP)
),
(
    CAST(1722538441265 AS BIGINT),
    CAST('13bc3f4b-d299-4b58-9d09-5444571518ae' AS STRING),
    CAST(790689006770532 AS BIGINT),
    NAMED_STRUCT(
        'email_notifications',NAMED_STRUCT(
            'on_failure',ARRAY('produtos_horizontais@indicium1.opsgenie.net'),
            'no_alert_for_skipped_runs',NULL
        ),
        'format','MULTI_TASK',
        'max_concurrent_runs',1,
        'name','[prod] investment_postgres_extraction_spark_job',
        'schedule',NAMED_STRUCT(
            'pause_status','UNPAUSED',
            'quartz_cron_expression','0 0 0/4 * * ? *',
            'timezone_id','UTC'
        ),
        'tags',NAMED_STRUCT(
            'dev', NULL,
            'env','prod'
        ),
        'timeout_seconds',0,
        'trigger',NAMED_STRUCT(
            'file_arrival',NAMED_STRUCT(
                'url',NULL
            ),
            'paused_status',NULL
        )
    ),
    CAST('2024-08-20T09:11:36.525Z' AS TIMESTAMP)
);

{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table jobs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table jobs ", info=true) %}


{% endmacro %}

{% macro bigquery__jobs() %}
{% set create_table %}
create or replace table `{{ target.database }}`.{{ target.schema }}.jobs (
    created_time BIGINT,
    creator_user_name STRING,
    job_id BIGINT,
    settings STRUCT<
            email_notifications STRUCT<
            on_failure ARRAY<STRING>,
            no_alert_for_skipped_runs BOOLEAN
            >,
        format STRING,
        max_concurrent_runs BIGINT,
        name STRING,
        schedule STRUCT<
            pause_status STRING,
            quartz_cron_expression STRING,
            timezone_id STRING
        >,
        tags STRUCT<
            dev STRING,
            env STRING
        >,
        timeout_seconds bigint,
        trigger STRUCT<
            file_arrival STRUCT<
                url STRING
            >,
            pause_status STRING
        >
    >,
    insertedDate TIMESTAMP
);
{% endset %}

{% set insert_table %}

INSERT INTO `{{ target.database }}`.{{ target.schema }}.jobs VALUES
(
    CAST(1722606667504 AS INT64),
    CAST('13bc3f4b-d299-4b58-9d09-5444571518ae' AS STRING),
    CAST(466340877826952 AS INT64),
    STRUCT(
        STRUCT(
            ARRAY['produtos_horizontais@indicium1.opsgenie.net'] AS on_failure,
            NULL AS no_alert_for_skipped_runs
        ) AS email_notifications,
        'MULTI_TASK' AS format,
        1 AS max_concurrent_runs,
        '[prod] core_dag_monitoring_data_transformation_dbt_job' AS name,
        STRUCT(
            NULL AS pause_status,
            NULL AS quartz_cron_expression,
            NULL AS timezone_id
        ) AS schedule,
        STRUCT(
            NULL AS dev,
            'prod' AS env
        ) AS tags,
        0 AS timeout_seconds,
        STRUCT(
            STRUCT(
                NULL AS url
            ) AS file_arrival,
            NULL AS paused_status
        ) AS trigger
    ),
    CAST('2024-08-20T09:11:36.525Z' AS TIMESTAMP)
),
(
    CAST(1722544845800 AS INT64),
    CAST('13bc3f4b-d299-4b58-9d09-5444571518ae' AS STRING),
    CAST(823250232903490 AS INT64),
    STRUCT(
        STRUCT(
            ARRAY['produtos_horizontais@indicium1.opsgenie.net'] AS on_failure,
            NULL AS no_alert_for_skipped_runs
        ) AS email_notifications,
        'MULTI_TASK' AS format,
        1 AS max_concurrent_runs,
        '[prod] core_dag_monitoring_extraction_meltano_job' AS name,
        STRUCT(
            'UNPAUSED' AS pause_status,
            '0 0 0/3 * * ? *' AS quartz_cron_expression,
            'UTC' AS timezone_id
        ) AS schedule,
        STRUCT(
            NULL AS dev,
            'prod' AS env
        ) AS tags,
        0 AS timeout_seconds,
        STRUCT(
            STRUCT(
                NULL AS url
            ) AS file_arrival,
            NULL AS paused_status
        ) AS trigger
    ),
    CAST('2024-08-20T09:11:36.525Z' AS TIMESTAMP)
),
(
    CAST(1722538441265 AS INT64),
    CAST('13bc3f4b-d299-4b58-9d09-5444571518ae' AS STRING),
    CAST(790689006770532 AS INT64),
    STRUCT(
        STRUCT(
            ARRAY['produtos_horizontais@indicium1.opsgenie.net'] AS on_failure,
            NULL AS no_alert_for_skipped_runs
        ) AS email_notifications,
        'MULTI_TASK' AS format,
        1 AS max_concurrent_runs,
        '[prod] investment_postgres_extraction_spark_job' AS name,
        STRUCT(
            'UNPAUSED' AS pause_status,
            '0 0 0/4 * * ? *' AS quartz_cron_expression,
            'UTC' AS timezone_id
        ) AS schedule,
        STRUCT(
            NULL AS dev,
            'prod' AS env
        ) AS tags,
        0 AS timeout_seconds,
        STRUCT(
            STRUCT(
                NULL AS url
            ) AS file_arrival,
            NULL AS paused_status
        ) AS trigger
    ),
    CAST('2024-08-20T09:11:36.525Z' AS TIMESTAMP)
);

{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table jobs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table jobs ", info=true) %}


{% endmacro %}

{% macro snowflake__jobs() %}
{% set create_table %}
CREATE OR REPLACE TABLE "{{ target.schema }}".jobs (
    created_time BIGINT,
    creator_user_name VARCHAR,
    job_id BIGINT,
    settings VARIANT,
    insertedDate TIMESTAMP
);
{% endset %}

{% set insert_table %}

INSERT INTO "{{ target.schema }}".jobs SELECT
    CAST(1722606667504 AS BIGINT),
    CAST('13bc3f4b-d299-4b58-9d09-5444571518ae' AS VARCHAR),
    CAST(466340877826952 AS BIGINT),
    OBJECT_CONSTRUCT(
        'email_notifications', OBJECT_CONSTRUCT(
            'on_failure', ARRAY_CONSTRUCT('produtosgenie.net'),
            'no_alert_for_skipped_runs', NULL
        ),
        'format', 'MULTI_TASK',
        'max_concurrent_runs', 1,
        'name', '[prod] coreion_dbt_job',
        'schedule', OBJECT_CONSTRUCT(
            'pause_status', NULL,
            'quartz_cron_expression', NULL,
            'timezone_id', NULL
        ),
        'tags', OBJECT_CONSTRUCT(
            'dev', NULL,
            'env', 'prod'
        ),
        'timeout_seconds', 0,
        'trigger', OBJECT_CONSTRUCT(
            'file_arrival', OBJECT_CONSTRUCT(
                'url', NULL
            ),
            'paused_status', NULL
        )
    ),
    CAST('2024-08-20T09:11:36.525Z' AS TIMESTAMP)
UNION ALL
    SELECT
    CAST(1722544845800 AS BIGINT),
    CAST('13bc3f4b44571518ae' AS VARCHAR),
    CAST(823250232903490 AS BIGINT),
    OBJECT_CONSTRUCT(
        'email_notifications', OBJECT_CONSTRUCT(
            'on_failure', ARRAY_CONSTRUCT('prod.opsgenie.net'),
            'no_alert_for_skipped_runs', NULL
        ),
        'format', 'MULTI_TASK',
        'max_concurrent_runs', 1,
        'name', '[prod] cltano_job',
        'schedule', OBJECT_CONSTRUCT(
            'pause_status', 'UNPAUSED',
            'quartz_cron_expression', '0 0 0/3 * * ? *',
            'timezone_id', 'UTC'
        ),
        'tags', OBJECT_CONSTRUCT(
            'dev', NULL,
            'env', 'prod'
        ),
        'timeout_seconds', 0,
        'trigger', OBJECT_CONSTRUCT(
            'file_arrival', OBJECT_CONSTRUCT(
                'url', NULL
            ),
            'paused_status', NULL
        )
    ),
    CAST('2024-08-20T09:11:36.525Z' AS TIMESTAMP)
UNION ALL
    SELECT
    CAST(1722538441265 AS BIGINT),
    CAST('13bc3f4b-d299-4b58-9d09-5444571518ae' AS VARCHAR),
    CAST(790689006770532 AS BIGINT),
    OBJECT_CONSTRUCT(
        'email_notifications', OBJECT_CONSTRUCT(
            'on_failure', ARRAY_CONSTRUCT('produtosopsgenie.net'),
            'no_alert_for_skipped_runs', NULL
        ),
        'format', 'MULTI_TASK',
        'max_concurrent_runs', 1,
        'name', '[prod] invspark_job',
        'schedule', OBJECT_CONSTRUCT(
            'pause_status', 'UNPAUSED',
            'quartz_cron_expression', '0 0 0/4 * * ? *',
            'timezone_id', 'UTC'
        ),
        'tags', OBJECT_CONSTRUCT(
            'dev', NULL,
            'env', 'prod'
        ),
        'timeout_seconds', 0,
        'trigger', OBJECT_CONSTRUCT(
            'file_arrival', OBJECT_CONSTRUCT(
                'url', NULL
            ),
            'paused_status', NULL
        )
    ),
    CAST('2024-08-20T09:11:36.525Z' AS TIMESTAMP)
;


{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table jobs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table jobs ", info=true) %}
{% endmacro %}