{% macro job_runs() -%}
    {{ return(adapter.dispatch('job_runs')()) }}
{%- endmacro %}

{%- macro databricks__job_runs() -%}
{% set create_table %}
create or replace table `{{ target.database }}`.{{ target.schema }}.job_runs(
    cleanup_duration BIGINT,
    creator_user_name STRING,
    end_time BIGINT,
    execution_duration BIGINT,
    job_clusters ARRAY<STRUCT<
        job_cluster_key string,
        new_cluster STRUCT<
            cluster_name string,
            data_security_mode string,
            driver_node_type_id string,
            enable_elastic_disk boolean,
            node_type_id string,
            num_workers bigint,
            runtime_engine string,
            spark_version string
        >
    >>,
    job_id BIGINT,
    number_in_job BIGINT,
    original_attempt_run_id BIGINT,
    run_duration BIGINT,
    run_id BIGINT,
    run_name STRING,
    run_page_url STRING,
    run_type STRING,
    schedule STRUCT<
        pause_status STRING,
        quartz_cron_expression STRING,
        timezone_id STRING
    >,
    setup_duration BIGINT,
    start_time BIGINT,
    state STRUCT<
        life_cycle_state STRING,
        result_state STRING,
        state_message STRING,
        user_cancelled_or_timedout BOOLEAN
    >,
    tasks array<struct<
        attempt_number bigint,
        cleanup_duration bigint,
        cluster_instance struct<
            cluster_id string,
            spark_context_id string
        >,
        dbt_task struct<
            commands array<string>,
            project_directory string,
            schema string,
            warehouse_id string
        >,
        depends_on array<struct<
            task_key string
        >>,
        end_time bigint,
        execution_duration bigint,
        existing_cluster_id string,
        git_source struct<
            git_branch string,
            git_provider string,
            git_snapshot struct<
                used_commit string
            >,
            git_tag string,
            git_url string
        >,
        libraries array<struct<
            pypi struct<
                package string
            >
        >>,
        notebook_task struct<
            notebook_path string,
            source string
        >,
        run_id bigint,
        setup_duration bigint,
        start_time bigint,
        state struct<
            life_cycle_state string,
            result_state string,
            state_message string,
            user_cancelled_or_timedout boolean
        >,
        task_key string
    >>,
    trigger STRING,
    insertedDate TIMESTAMP
);
{% endset %}

{% set insert_table %}

INSERT INTO `{{ target.database }}`.{{ target.schema }}.job_runs VALUES
(
    0,
    'marcutech',
    1720785705439,
    0,
    NULL,
    724712624070673,
    539935187772655,
    539935187772655,
    524911,
    539935187772655,
    '[devook_job',
    'https://adb-124029731635b/724712624070673/run/539935187772655',
    'JOB_RUN',
    NAMED_STRUCT(
        "pause_status", NULL,
        "quartz_cron_expression", NULL,
        "timezone_id", NULL
        ),
    0,
    1720785180528,
    NAMED_STRUCT( 
        "life_cycle_state", "TERMINATED",
        "result_state", "SUCCESS", 
        "state_message", NULL,
        "user_cancelled_or_timedout", FALSE
        ),
    ARRAY(
        NAMED_STRUCT(
            'attempt_number', 0,
            'cleanup_duration', 0,
            'cluster_instance', NAMED_STRUCT(
                'cluster_id', '0726-190025-l9rjt3er',
                'spark_context_id', NULL
            ),
            'dbt_task', NULL,
            'depends_on', ARRAY(
                NAMED_STRUCT('task_key', 'meltano_databricks_ops')
            ),
            'end_time', 172115372793563,
            'execution_duration', 0,
            'existing_cluster_id', '0726-190025-l9rjt3er',
            'git_source', NAMED_STRUCT(
                'git_branch', 'git_task',
                'git_provider', 'bitbucketCloud',
                'git_snapshot', NULL,
                'git_tag', NULL,
                'git_url', 'https://bitbucket.org/inno_on_databricks'
            ),
            'libraries', NULL,
            'notebook_task', NAMED_STRUCT(
                'notebook_path', 'src/execute_table_dbr',
                'source', 'GIT'
            ),
            'run_id', 703673872655804,
            'setup_duration', 0,
            'start_time', 172115150810239,
            'state', NAMED_STRUCT(
                'life_cycle_state', 'BLOCKED',
                'result_state', NULL,
                'state_message', '',
                'user_cancelled_or_timedout', FALSE
            ),
            'task_key', 'execute_table_dbr'
        ),
        NAMED_STRUCT(
            'attempt_number', 0,
            'cleanup_duration', 0,
            'cluster_instance', NAMED_STRUCT(
                'cluster_id', '0726-190025-l9rjt3er',
                'spark_context_id', '2280680787151510917'
            ),
            'dbt_task', NULL,
            'depends_on', ARRAY(
                NAMED_STRUCT('task_key', 'meltano_init')
            ),
            'end_time', 172078572305439,
            'execution_duration', 0,
            'existing_cluster_id', '0726-190025-l9rjt3er',
            'git_source', NAMED_STRUCT(
                'git_branch', 'git_task',
                'git_provider', 'bitbucketCloud',
                'git_snapshot', NAMED_STRUCT(
                    'used_commit', '2fc709b03d0059a18a9b994504e270c9114c1b07'
                ),
                'git_tag', NULL,
                'git_url', 'https://bitbucabricks'
            ),
            'libraries', ARRAY(
                NAMED_STRUCT('pypi', NAMED_STRUCT('package', 'meltano==3.3.2'))
            ),
            'notebook_task', NAMED_STRUCT(
                'notebook_path', 'src/meltano_databricks_ops',
                'source', 'GIT'
            ),
            'run_id', 79128842213838,
            'setup_duration', 1000,
            'start_time', 172115372792333,
            'state', NAMED_STRUCT(
                'life_cycle_state', 'RUNNING',
                'result_state', NULL,
                'state_message', 'In run',
                'user_cancelled_or_timedout', FALSE
            ),
            'task_key', 'meltano_databricks_ops'
        )
    )
    ,
    'ONE_TIME',
    '2024-08-11T07:12:47.784Z'
),
(
    0,
    'marcu.tech',
    1720781204456,
    0,
    NULL,
    388879741463141,
    1104206444717471,
    1104206444717471,
    114044,
    1104206444717471,
    '[dev matebook_job',
    'https://adb-124029731635903.03#job/388879741463141/run/1104206444717471',
    'JOB_RUN',
    NAMED_STRUCT( 
        "pause_status", NULL, 
        "quartz_cron_expression", NULL, 
        "timezone_id", NULL
        ),
    0,
    1720781090412,
    NAMED_STRUCT(
        "life_cycle_state", "TERMINATED",
        "result_state", "SUCCESS", 
        "state_message", NULL,
        "user_cancelled_or_timedout", FALSE
        ),
    ARRAY(
        NAMED_STRUCT(
            'attempt_number', 0,
            'cleanup_duration', 0,
            'cluster_instance', NAMED_STRUCT(
                'cluster_id', '0726-130251-aj7rmr0x',
                'spark_context_id', '1302841573581174040'
            ),
            'dbt_task', NAMED_STRUCT(
                'commands', ARRAY(
                    'dbt debug --target prod',
                    'dbt deps',
                    'dbt build --target prod --exclude databricks_monitoring dbt_dag_monitoring extraction_monitoring elementary_dbt_monitoring'
                ),
                'project_directory', 'dbt',
                'schema', 'default',
                'warehouse_id', NULL
            ),
            'depends_on', NULL,
            'end_time', 172115060802344, 
            'execution_duration', 3765000,
            'existing_cluster_id', '0726-130251-aj7rmr0x',
            'git_source', NAMED_STRUCT(
                'git_branch', NULL,
                'git_provider', 'bitbucketCloud',
                'git_snapshot', NAMED_STRUCT(
                    'used_commit', '527373ab887ac9f763fe9'
                ),
                'git_tag', 'production',
                'git_url', 'https://bitbucket.org/indiciumtech/caixa_dbt_core'
            ),
            'libraries', ARRAY(
                NAMED_STRUCT('pypi', NAMED_STRUCT('package', 'dbt-databricks==1.7')),
                NAMED_STRUCT('pypi', NAMED_STRUCT('package', 'databricks-sdk==0.28.0')),
                NAMED_STRUCT('pypi', NAMED_STRUCT('package', 'dbt-core==1.7.10'))
            ),
            'notebook_task', NULL,
            'run_id', 26793638330567,
            'setup_duration', 284000,
            'start_time', 172374563302374,
            'state', NAMED_STRUCT(
                'life_cycle_state', 'TERMINATED',
                'result_state', 'SUCCESS',
                'state_message', '',
                'user_cancelled_or_timedout', FALSE
            ),
            'task_key', 'execute_dbt_build'
        ),
        NAMED_STRUCT(
            'attempt_number', 0,
            'cleanup_duration', 0,
            'cluster_instance', NAMED_STRUCT(
                'cluster_id', '0726-130251-aj7rmr0x',
                'spark_context_id', '1302841573581174040'
            ),
            'dbt_task', NAMED_STRUCT(
                'commands', ARRAY(
                    'dbt debug --target prod',
                    'dbt deps',
                    'dbt build --target prod --select elementary_dbt_monitoring'
                ),
                'project_directory', 'dbt',
                'schema', 'default',
                'warehouse_id', NULL
            ),
            'depends_on', ARRAY(
                NAMED_STRUCT('task_key', 'execute_dbt_build')
            ),
            'end_time', 172374563302374, 
            'execution_duration', 247000,
            'existing_cluster_id', '0726-130251-aj7rmr0x',
            'git_source', NAMED_STRUCT(
                'git_branch', NULL,
                'git_provider', 'bitbucketCloud',
                'git_snapshot', NAMED_STRUCT(
                    'used_commit', '527373ab887ba7ac9f763fe9'
                ),
                'git_tag', 'production',
                'git_url', 'https:///ccore'
            ),
            'libraries', ARRAY(
                NAMED_STRUCT('pypi', NAMED_STRUCT('package', 'dbt-databricks==1.7')),
                NAMED_STRUCT('pypi', NAMED_STRUCT('package', 'databricks-sdk==0.28.0')),
                NAMED_STRUCT('pypi', NAMED_STRUCT('package', 'dbt-core==1.7.10'))
            ),
            'notebook_task', NULL,
            'run_id', 276320404580646,
            'setup_duration', 2000,
            'start_time', 172374563302374, 
            'state', NAMED_STRUCT(
                'life_cycle_state', 'TERMINATED',
                'result_state', 'SUCCESS',
                'state_message', '',
                'user_cancelled_or_timedout', FALSE
            ),
            'task_key', 'execute_elementary_dbt_monitoring'
        )
    ),
    'ONE_TIME',
    '2024-08-11T07:12:47.784Z'
);
{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table job_runs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table job_runs", info=true) %}

{%- endmacro -%}

{%- macro bigquery__job_runs() -%}
{% set create_table %}
CREATE OR REPLACE TABLE `{{ target.database }}`.{{ target.schema }}.job_runs (
    cleanup_duration BIGINT,
    creator_user_name STRING,
    end_time BIGINT,
    execution_duration BIGINT,
    job_clusters ARRAY<STRUCT<
        job_cluster_key string,
        new_cluster STRUCT<
            cluster_name string,
            data_security_mode string,
            driver_node_type_id string,
            enable_elastic_disk boolean,
            node_type_id string,
            num_workers bigint,
            runtime_engine string,
            spark_version string
        >
    >>,
    job_id BIGINT,
    number_in_job BIGINT,
    original_attempt_run_id BIGINT,
    run_duration BIGINT,
    run_id BIGINT,
    run_name STRING,
    run_page_url STRING,
    run_type STRING,
    schedule STRUCT<
        pause_status STRING,
        quartz_cron_expression STRING,
        timezone_id STRING
    >,
    setup_duration BIGINT,
    start_time BIGINT,
    state STRUCT<
        life_cycle_state STRING,
        result_state STRING,
        state_message STRING,
        user_cancelled_or_timedout BOOLEAN
    >,
    tasks array<struct<
        attempt_number bigint,
        cleanup_duration bigint,
        cluster_instance struct<
            cluster_id string,
            spark_context_id string
        >,
        dbt_task struct<
            commands array<string>,
            project_directory string,
            schema string,
            warehouse_id string
        >,
        depends_on array<struct<
            task_key string
        >>,
        end_time bigint,
        execution_duration bigint,
        existing_cluster_id string,
        git_source struct<
            git_branch string,
            git_provider string,
            git_snapshot struct<
                used_commit string
            >,
            git_tag string,
            git_url string
        >,
        libraries array<struct<
            pypi struct<
                package string
            >
        >>,
        notebook_task struct<
            notebook_path string,
            source string
        >,
        run_id bigint,
        setup_duration bigint,
        start_time bigint,
        state struct<
            life_cycle_state string,
            result_state string,
            state_message string,
            user_cancelled_or_timedout boolean
        >,
        task_key string
    >>,
    trigger STRING,
    insertedDate TIMESTAMP
);

{% endset %}

{% set insert_table %}

INSERT INTO `{{ target.database }}`.{{ target.schema }}.job_runs VALUES
(
    0,
    'marcum.tech',
    1720785705439,
    0,
    NULL,
    724712624070673,
    539935187772655,
    539935187772655,
    524911,
    539935187772655,
    '[dev marg_notebook_job',
    'https://adb-124029734070673/run/539935187772655',
    'JOB_RUN',
    STRUCT(
        NULL AS pause_status,
        NULL AS quartz_cron_expression,
        NULL AS timezone_id
    ),
    0,
    1720785180528,
    STRUCT(
        'TERMINATED' AS life_cycle_state,
        'SUCCESS' AS result_state,
        NULL AS state_message,
        FALSE AS user_cancelled_or_timedout
    ),
    ARRAY<
        STRUCT<
            attempt_number BIGINT,
            cleanup_duration BIGINT,
            cluster_instance STRUCT<
                cluster_id STRING,
                spark_context_id STRING
            >,
            dbt_task STRUCT<
                commands ARRAY<STRING>,
                project_directory STRING,
                schema STRING,
                warehouse_id STRING
            >,
            depends_on ARRAY<STRUCT<task_key STRING>>,
            end_time BIGINT,
            execution_duration BIGINT,
            existing_cluster_id STRING,
            git_source STRUCT<
                git_branch STRING,
                git_provider STRING,
                git_snapshot STRUCT<used_commit STRING>,
                git_tag STRING,
                git_url STRING
            >,
            libraries ARRAY<STRUCT<pypi STRUCT<package STRING>>>,
            notebook_task STRUCT<
                notebook_path STRING,
                source STRING
            >,
            run_id BIGINT,
            setup_duration BIGINT,
            start_time BIGINT,
            state STRUCT<
                life_cycle_state STRING,
                result_state STRING,
                state_message STRING,
                user_cancelled_or_timedout BOOLEAN
            >,
            task_key STRING
        >
    >[
        STRUCT(
            0 AS attempt_number,
            0 AS cleanup_duration,
            STRUCT(
                '0726-190025-l9rjt3er' AS cluster_id,
                NULL AS spark_context_id
            ) AS cluster_instance,
            NULL AS dbt_task,
            ARRAY<STRUCT<task_key STRING>>[
                STRUCT('meltano_databricks_ops' AS task_key)
            ] AS depends_on,
            172115372793563 AS end_time,
            0 AS execution_duration,
            '0726-190025-l9rjt3er' AS existing_cluster_id,
            STRUCT(
                'git_branch_value' AS git_branch,
                'bitbucketCloud' AS git_provider,
                NULL AS git_snapshot,
                NULL AS git_tag,
                'https://bitbucket.oo_on_databricks' AS git_url
            ) AS git_source,
            NULL AS libraries,
            STRUCT(
                'src/execute_table_dbr' AS notebook_path,
                'GIT' AS source
            ) AS notebook_task,
            703673872655804 AS run_id,
            0 AS setup_duration,
            172115150810239 AS start_time,
            STRUCT(
                'BLOCKED' AS life_cycle_state,
                NULL AS result_state,
                '' AS state_message,
                FALSE AS user_cancelled_or_timedout
            ) AS state,
            'execute_table_dbr' AS task_key
        ),
        STRUCT(
            0 AS attempt_number,
            0 AS cleanup_duration,
            STRUCT(
                '0726-190025-l9rjt3er' AS cluster_id,
                '2280680787151510917' AS spark_context_id
            ) AS cluster_instance,
            NULL AS dbt_task,
            ARRAY<STRUCT<task_key STRING>>[
                STRUCT('meltano_init' AS task_key)
            ] AS depends_on,
            172078572305439 AS end_time,
            0 AS execution_duration,
            '0726-190025-l9rjt3er' AS existing_cluster_id,
            STRUCT(
                'git_branch_value' AS git_branch,
                'bitbucketCloud' AS git_provider,
                STRUCT(
                    '2fc709b03d0059a18a9b994504e270c9114c1b07' AS used_commit
                ) AS git_snapshot,
                NULL AS git_tag,
                'https://bitbucket.or_databricks' AS git_url
            ) AS git_source,
            ARRAY<STRUCT<pypi STRUCT<package STRING>>>[
                STRUCT(STRUCT('meltano==3.3.2' AS package) AS pypi)
            ] AS libraries,
            STRUCT(
                'src/meltano_databricks_ops' AS notebook_path,
                'GIT' AS source
            ) AS notebook_task,
            79128842213838 AS run_id,
            1000 AS setup_duration,
            172115372792333 AS start_time,
            STRUCT(
                'RUNNING' AS life_cycle_state,
                NULL AS result_state,
                'In run' AS state_message,
                FALSE AS user_cancelled_or_timedout
            ) AS state,
            'meltano_databricks_ops' AS task_key
        )
    ] ,
    'ONE_TIME',
    '2024-08-11T07:12:47.784Z'
),
(
    0,
    'marcus.tech',
    1720781204456,
    0,
    NULL,
    388879741463141,
    1104206444717471,
    1104206444717471,
    114044,
    1104206444717471,
    '[dev notebook_job',
    'https://adb-1288879741463141/run/1104206444717471',
    'JOB_RUN',
    STRUCT(
        NULL AS pause_status,
        NULL AS quartz_cron_expression,
        NULL AS timezone_id
    ),
    0,NSERT TABLE 
    1720781090412,
    STRUCT(
        'TERMINATED' AS life_cycle_state,
        'SUCCESS' AS result_state,
        NULL AS state_message,
        FALSE AS user_cancelled_or_timedout
    ),
    ARRAY<
        STRUCT<
            attempt_number BIGINT,
            cleanup_duration BIGINT,
            cluster_instance STRUCT<
                cluster_id STRING,
                spark_context_id STRING
            >,
            dbt_task STRUCT<
                commands ARRAY<STRING>,
                project_directory STRING,
                schema STRING,
                warehouse_id STRING
            >,
            depends_on ARRAY<STRUCT<task_key STRING>>,
            end_time BIGINT,
            execution_duration BIGINT,
            existing_cluster_id STRING,
            git_source STRUCT<
                git_branch STRING,
                git_provider STRING,
                git_snapshot STRUCT<used_commit STRING>,
                git_tag STRING,
                git_url STRING
            >,
            libraries ARRAY<STRUCT<pypi STRUCT<package STRING>>>,
            notebook_task STRUCT<
                notebook_path STRING,
                source STRING
            >,
            run_id BIGINT,
            setup_duration BIGINT,
            start_time BIGINT,
            state STRUCT<
                life_cycle_state STRING,
                result_state STRING,
                state_message STRING,
                user_cancelled_or_timedout BOOLEAN
            >,
            task_key STRING
        >
    >[
        STRUCT(
            0 AS attempt_number,
            0 AS cleanup_duration,
            STRUCT(
                '0726-130251-aj7rmr0x' AS cluster_id,
                '1302841573581174040' AS spark_context_id
            ) AS cluster_instance,
            STRUCT(
                ARRAY<STRING>[
                    'dbt debug --target prod',
                    'dbt deps',
                    'dbt build --target prod --exclude databricks_monitoring dbt_dag_monitoring extraction_monitoring elementary_dbt_monitoring'
                ] AS commands,
                'dbt' AS project_directory,
                'default' AS schema,
                NULL AS warehouse_id
            ) AS dbt_task,
            NULL AS depends_on,
            172115060802344 AS end_time,
            3765000 AS execution_duration,
            '0726-130251-aj7rmr0x' AS existing_cluster_id,
            STRUCT(
                NULL AS git_branch,
                'bitbucketCloud' AS git_provider,
                STRUCT(
                    '527373ab887ba768d1949e110fc19cac9f763fe9' AS used_commit
                ) AS git_snapshot,
                'production' AS git_tag,
                'https://bita_dbt_core' AS git_url
            ) AS git_source,
            ARRAY<STRUCT<pypi STRUCT<package STRING>>>[
                STRUCT(STRUCT('dbt-databricks==1.7' AS package) AS pypi),
                STRUCT(STRUCT('databricks-sdk==0.28.0' AS package) AS pypi),
                STRUCT(STRUCT('dbt-core==1.7.10' AS package) AS pypi)
            ] AS libraries,
            NULL AS notebook_task,
            26793638330567 AS run_id,
            284000 AS setup_duration,
            172374563302374 AS start_time,
            STRUCT(
                'TERMINATED' AS life_cycle_state,
                'SUCCESS' AS result_state,
                '' AS state_message,
                FALSE AS user_cancelled_or_timedout
            ) AS state,
            'execute_dbt_build' AS task_key
        ),
        STRUCT(
            0 AS attempt_number,
            0 AS cleanup_duration,
            STRUCT(
                '0726-130251-aj7rmr0x' AS cluster_id,
                '1302841573581174040' AS spark_context_id
            ) AS cluster_instance,
            STRUCT(
                ARRAY<STRING>[
                    'dbt debug --target prod',
                    'dbt deps',
                    'dbt build --target prod --select elementary_dbt_monitoring'
                ] AS commands,
                'dbt' AS project_directory,
                'default' AS schema,
                NULL AS warehouse_id
            ) AS dbt_task,
            ARRAY<STRUCT<task_key STRING>>[
                STRUCT('execute_dbt_build' AS task_key)
            ] AS depends_on,
            172374563302374 AS end_time,
            247000 AS execution_duration,
            '0726-130251-aj7rmr0x' AS existing_cluster_id,
            STRUCT(
                NULL AS git_branch,
                'bitbucketCloud' AS git_provider,
                STRUCT(
                    '527373ab887ba768d1949e110fc19cac9f763fe9' AS used_commit
                ) AS git_snapshot,
                'production' AS git_tag,
                'https://bitbucket._core' AS git_url
            ) AS git_source,
            ARRAY<STRUCT<pypi STRUCT<package STRING>>>[
                STRUCT(STRUCT('dbt-databricks==1.7' AS package) AS pypi),
                STRUCT(STRUCT('databricks-sdk==0.28.0' AS package) AS pypi),
                STRUCT(STRUCT('dbt-core==1.7.10' AS package) AS pypi)
            ] AS libraries,
            NULL AS notebook_task,
            276320404580646 AS run_id,
            2000 AS setup_duration,
            172374563302374 AS start_time,
            STRUCT(
                'TERMINATED' AS life_cycle_state,
                'SUCCESS' AS result_state,
                '' AS state_message,
                FALSE AS user_cancelled_or_timedout
            ) AS state,
            'execute_elementary_dbt_monitoring' AS task_key
        )
    ],
    'ONE_TIME',
    '2024-08-11T07:12:47.784Z'
);

{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table job_runs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table job_runs", info=true) %}

{%- endmacro -%}

{%- macro snowflake__job_runs() -%}
{% set create_table %}
CREATE OR REPLACE TABLE {{ target.database }}.{{ target.schema }}.job_runs (
    cleanup_duration BIGINT,
    creator_user_name STRING,
    end_time BIGINT,
    execution_duration BIGINT,
    job_clusters VARIANT,
    job_id BIGINT,
    number_in_job BIGINT,
    original_attempt_run_id BIGINT,
    run_duration BIGINT,
    run_id BIGINT,
    run_name STRING,
    run_page_url STRING,
    run_type STRING,
    schedule VARIANT,
    setup_duration BIGINT,
    start_time BIGINT,
    state VARIANT,
    "tasks" VARIANT,
    "trigger" STRING,
    insertedDate TIMESTAMP
);

{% endset %}

{% set insert_table %}

INSERT INTO {{ target.database }}.{{ target.schema }}.job_runs 
SELECT
    0,
    'marm.tech',
    1720785705439,
    0,
    ARRAY_CONSTRUCT(
        OBJECT_CONSTRUCT(
            'job_cluster_key', NULL,
            'new_cluster', OBJECT_CONSTRUCT(
                'cluster_name', NULL,
                'data_security_mode', NULL,
                'driver_node_type_id', NULL,
                'enable_elastic_disk', NULL,
                'node_type_id', NULL,
                'num_workers', NULL,
                'runtime_engine', NULL,
                'spark_version', NULL
            )
        )
    ),
    724712624070673,
    539935187772655,
    539935187772655,
    524911,
    539935187772655,
    '[dev marcu_notebook_job',
    'https://adb-124029?o=124029731635903#job/724712624070673/run/539935187772655',
    'JOB_RUN',
    OBJECT_CONSTRUCT(
        'pause_status', NULL,
        'quartz_cron_expression', NULL,
        'timezone_id', NULL
    ),
    0,
    1720785180528,
    OBJECT_CONSTRUCT(
        'life_cycle_state', 'TERMINATED',
        'result_state', 'SUCCESS',
        'state_message', NULL,
        'user_cancelled_or_timedout', FALSE
    ),
    ARRAY_CONSTRUCT(
        OBJECT_CONSTRUCT(
            'attempt_number', 0,
            'cleanup_duration', 0,
            'cluster_instance', OBJECT_CONSTRUCT(
                'cluster_id', '0726-190025-l9rjt3er',
                'spark_context_id', NULL
            ),
            'dbt_task', NULL,
            'depends_on', ARRAY_CONSTRUCT(
                OBJECT_CONSTRUCT('task_key', 'meltano_databricks_ops')
            ),
            'end_time', 172115372793563,
            'execution_duration', 0,
            'existing_cluster_id', '0726-190025-l9rjt3er',
            'git_source', OBJECT_CONSTRUCT(
                'git_branch', 'git_task',
                'git_provider', 'bitbucketCloud',
                'git_snapshot', NULL,
                'git_tag', NULL,
                'git_url', 'https://bitbucket.org/indiciumtech/platform_meltano_on_databricks'
            ),
            'libraries', NULL,
            'notebook_task', OBJECT_CONSTRUCT(
                'notebook_path', 'src/execute_table_dbr',
                'source', 'GIT'
            ),
            'run_id', 703673872655804,
            'setup_duration', 0,
            'start_time', 172115150810239,
            'state', OBJECT_CONSTRUCT(
                'life_cycle_state', 'BLOCKED',
                'result_state', NULL,
                'state_message', '',
                'user_cancelled_or_timedout', FALSE
            ),
            'task_key', 'execute_table_dbr'
        ),
        OBJECT_CONSTRUCT(
            'attempt_number', 0,
            'cleanup_duration', 0,
            'cluster_instance', OBJECT_CONSTRUCT(
                'cluster_id', '0726-190025-l9rjt3er',
                'spark_context_id', '2280680787151510917'
            ),
            'dbt_task', NULL,
            'depends_on', ARRAY_CONSTRUCT(
                OBJECT_CONSTRUCT('task_key', 'meltano_init')
            ),
            'end_time', 172078572305439,
            'execution_duration', 0,
            'existing_cluster_id', '0726-190025-l9rjt3er',
            'git_source', OBJECT_CONSTRUCT(
                'git_branch', 'git_task',
                'git_provider', 'bitbucketCloud',
                'git_snapshot', OBJECT_CONSTRUCT(
                    'used_commit', '2fc709b03d0059a18a9b994504e270c9114c1b07'
                ),
                'git_tag', NULL,
                'git_url', 'https://bitbucket.org/indiciumtech/platform_meltano_on_databricks'
            ),
            'libraries', ARRAY_CONSTRUCT(
                OBJECT_CONSTRUCT('pypi', OBJECT_CONSTRUCT('package', 'meltano==3.3.2'))
            ),
            'notebook_task', OBJECT_CONSTRUCT(
                'notebook_path', 'src/meltano_databricks_ops',
                'source', 'GIT'
            ),
            'run_id', 79128842213838,
            'setup_duration', 1000,
            'start_time', 172115372792333,
            'state', OBJECT_CONSTRUCT(
                'life_cycle_state', 'RUNNING',
                'result_state', NULL,
                'state_message', 'In run',
                'user_cancelled_or_timedout', FALSE
            ),
            'task_key', 'meltano_databricks_ops'
        )
    ),
    'ONE_TIME',
    '2024-08-11T07:12:47.784Z'
UNION ALL
SELECT
    0,
    'marm.tech',
    1720781204456,
    0,
    ARRAY_CONSTRUCT(
        OBJECT_CONSTRUCT(
            'job_cluster_key', NULL,
            'new_cluster', OBJECT_CONSTRUCT(
                'cluster_name', NULL,
                'data_security_mode', NULL,
                'driver_node_type_id', NULL,
                'enable_elastic_disk', NULL,
                'node_type_id', NULL,
                'num_workers', NULL,
              'runtime_engine', NULL,
                'spark_version', NULL
            )
        )
    ),
    388879741463141,
    1104206444717471,
    1104206444717471,
    114044,
    1104206444717471,
    '[dev mbook_job',
    'https://adb-12402973463141/run/1104206444717471',
    'JOB_RUN',
    OBJECT_CONSTRUCT(
        'pause_status', NULL,
        'quartz_cron_expression', NULL,
        'timezone_id', NULL
    ),
    0,
    1720781090412,
    OBJECT_CONSTRUCT(
        'life_cycle_state', 'TERMINATED',
        'result_state', 'SUCCESS',
        'state_message', NULL,
        'user_cancelled_or_timedout', FALSE
    ),
    ARRAY_CONSTRUCT(
        OBJECT_CONSTRUCT(
            'attempt_number', 0,
            'cleanup_duration', 0,
            'cluster_instance', OBJECT_CONSTRUCT(
                'cluster_id', '0726-130mr0x',
                'spark_context_id', '13028414040'
            ),
            'dbt_task', OBJECT_CONSTRUCT(
                'commands', ARRAY_CONSTRUCT(
                    'dbt debug --target prod',
                    'dbt deps',
                    'dbt build --target prod --exclude databricks_monitoring dbt_dag_monitoring extraction_monitoring elementary_dbt_monitoring'
                ),
                'project_directory', 'dbt',
                'schema', 'default',
                'warehouse_id', NULL
            ),
            'depends_on', NULL,
            'end_time', 172115060802344,
            'execution_duration', 3765000,
            'existing_cluster_id', '0726-130rmr0x',
            'git_source', OBJECT_CONSTRUCT(
                'git_branch', NULL,
                'git_provider', 'bitbucketCloud',
                'git_snapshot', OBJECT_CONSTRUCT(
                    'used_commit', '527373abac9f763fe9'
                ),
                'git_tag', 'production',
                'git_url', 'https://bitbucketixa_dbt_core'
            ),
            'libraries', ARRAY_CONSTRUCT(
                OBJECT_CONSTRUCT('pypi', OBJECT_CONSTRUCT('package', 'dbt-databricks==1.7')),
                OBJECT_CONSTRUCT('pypi', OBJECT_CONSTRUCT('package', 'databricks-sdk==0.28.0')),
                OBJECT_CONSTRUCT('pypi', OBJECT_CONSTRUCT('package', 'dbt-core==1.7.10'))
            ),
            'notebook_task', NULL,
            'run_id', 26793638330567,
            'setup_duration', 284000,
            'start_time', 172374563302374,
            'state', OBJECT_CONSTRUCT(
                'life_cycle_state', 'TERMINATED',
                'result_state', 'SUCCESS',
                'state_message', '',
                'user_cancelled_or_timedout', FALSE
            ),
            'task_key', 'execute_dbt_build'
        ),
        OBJECT_CONSTRUCT(
            'attempt_number', 0,
            'cleanup_duration', 0,
            'cluster_instance', OBJECT_CONSTRUCT(
                'cluster_id', '0726-130251-aj7rmr0x',
                'spark_context_id', '1302841573581174040'
            ),
           'dbt_task', OBJECT_CONSTRUCT(
                'commands', ARRAY_CONSTRUCT(
                    'dbt debug --target prod',
                    'dbt deps',
                    'dbt build --target prod --select elementary_dbt_monitoring'
                ),
                'project_directory', 'dbt',
                'schema', 'default',
                'warehouse_id', NULL
            ),
            'depends_on', ARRAY_CONSTRUCT(
                OBJECT_CONSTRUCT('task_key', 'execute_dbt_build')
            ),
            'end_time', 172374563302374,
            'execution_duration', 247000,
            'existing_cluster_id', '0726-r0x',
            'git_source', OBJECT_CONSTRUCT(
                'git_branch', NULL,
                'git_provider', 'bitbucketCloud',
                'git_snapshot', OBJECT_CONSTRUCT(
                    'used_commit', '527373ab8c9f763fe9'
                ),
                'git_tag', 'production',
                'git_url', 'https://bitbucixa_dbt_core'
            ),
            'libraries', ARRAY_CONSTRUCT(
                OBJECT_CONSTRUCT('pypi', OBJECT_CONSTRUCT('package', 'dbt-databricks==1.7')),
                OBJECT_CONSTRUCT('pypi', OBJECT_CONSTRUCT('package', 'databricks-sdk==0.28.0')),
                OBJECT_CONSTRUCT('pypi', OBJECT_CONSTRUCT('package', 'dbt-core==1.7.10'))
            ),
           'notebook_task', NULL,
            'run_id', 276320404580646,
            'setup_duration', 2000,
            'start_time', 172374563302374,
            'state', OBJECT_CONSTRUCT(
                'life_cycle_state', 'TERMINATED',
                'result_state', 'SUCCESS',
                'state_message', '',
                'user_cancelled_or_timedout', FALSE
           ),
            'task_key', 'execute_elementary_dbt_monitoring'
        )
    ),
    'ONE_TIME',
    '2024-08-11T07:12:47.784Z'
;

{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table job_runs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table job_runs", info=true) %}

{%- endmacro -%}