{%- macro teste() -%}
{% set create_table %}
create or replace table `{{ target.database }}`.{{ target.schema }}.databricks_job_runs(
    run_id BIGINT,
    job_id BIGINT,
    trigger STRING,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    execution_duration INT,
    run_type STRING,
    tasks ARRAY<STRUCT<
        attempt_number INT,
        cleanup_duration INT,
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
        depends_on ARRAY<STRUCT<
            task_key STRING
        >>,
        end_time TIMESTAMP,
        execution_duration INT,
        existing_cluster_id STRING,
        git_source STRUCT<
            git_branch STRING,
            git_provider STRING,
            git_snapshot STRUCT<
                used_commit STRING
            >,
            git_tag STRING,
            git_url STRING
        >,
        libraries ARRAY<STRUCT<
            pypi STRUCT<
                package STRING
            >
        >>,
        notebook_task STRUCT<
            notebook_path STRING,
            source STRING
        >,
        run_id BIGINT,
        setup_duration INT,
        start_time TIMESTAMP,
        state STRUCT<
            life_cycle_state STRING,
            result_state STRING,
            state_message STRING,
            user_cancelled_or_timedout BOOLEAN
        >,
        task_key STRING
    >>
);
{% endset %}

{% set insert_table %}

INSERT INTO `{{ target.database }}`.{{ target.schema }}.databricks_job_runs VALUES
(
    984645491483676,
    823250232903490,
    'PERIODIC',
    TIMESTAMP '1970-01-01 00:00:00.000',
    TIMESTAMP '1970-01-01 00:00:00.000',
    0,
    'JOB_RUN',
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
            'end_time', TIMESTAMP '1970-01-01 00:00:00.000',
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
            'start_time', TIMESTAMP '1970-01-01 00:00:00.000',
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
            'end_time', TIMESTAMP '1970-01-01 00:00:00.000',
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
            'start_time', TIMESTAMP '1970-01-01 00:00:00.000',
            'state', NAMED_STRUCT(
                'life_cycle_state', 'RUNNING',
                'result_state', NULL,
                'state_message', 'In run',
                'user_cancelled_or_timedout', FALSE
            ),
            'task_key', 'meltano_databricks_ops'
        )
    )
),
(
    499818295245560,
    641280523209372,
    'RUN_JOB_TASK',
    TIMESTAMP '1970-01-01 00:00:00.000', -- replace with correct timestamp
    TIMESTAMP '1970-01-01 00:00:00.000', -- replace with correct timestamp
    0,
    'JOB_RUN',
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
            'end_time', TIMESTAMP '1970-01-01 00:00:00.000', -- replace with correct timestamp
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
            'start_time', TIMESTAMP '1970-01-01 00:00:00.000', -- replace with correct timestamp
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
            'end_time', TIMESTAMP '1970-01-01 00:00:00.000', -- replace with correct timestamp
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
            'start_time', TIMESTAMP '1970-01-01 00:00:00.000', -- replace with correct timestamp
            'state', NAMED_STRUCT(
                'life_cycle_state', 'TERMINATED',
                'result_state', 'SUCCESS',
                'state_message', '',
                'user_cancelled_or_timedout', FALSE
            ),
            'task_key', 'execute_elementary_dbt_monitoring'
        )
    )
);
{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating tables", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert tables", info=true) %}

{%- endmacro -%}