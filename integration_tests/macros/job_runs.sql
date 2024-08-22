{%- macro job_runs() -%}
{% set create_table %}
create or replace table {{ var('dag_monitoring_databricks_database')}}.{{ var('dag_monitoring_databricks_schema') }}.job_runs(
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

INSERT INTO {{ var('dag_monitoring_databricks_database')}}.{{ var('dag_monitoring_databricks_schema') }}.job_runs VALUES
(
    0,
    'marcus.canto@indicium.tech',
    1720785705439,
    0,
    NULL,
    724712624070673,
    539935187772655,
    539935187772655,
    524911,
    539935187772655,
    '[dev marcus_canto] dag_monitoring_notebook_job',
    'https://adb-124029731635903.3.azuredatabricks.net/?o=124029731635903#job/724712624070673/run/539935187772655',
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
                'git_url', 'https://bitbucket.org/indiciumtech/platform_meltano_on_databricks'
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
                'git_url', 'https://bitbucket.org/indiciumtech/platform_meltano_on_databricks'
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
    'marcus.canto@indicium.tech',
    1720781204456,
    0,
    NULL,
    388879741463141,
    1104206444717471,
    1104206444717471,
    114044,
    1104206444717471,
    '[dev marcus_canto] dag_monitoring_notebook_job',
    'https://adb-124029731635903.3.azuredatabricks.net/?o=124029731635903#job/388879741463141/run/1104206444717471',
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
                    'used_commit', '527373ab887ba768d1949e110fc19cac9f763fe9'
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
                    'used_commit', '527373ab887ba768d1949e110fc19cac9f763fe9'
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