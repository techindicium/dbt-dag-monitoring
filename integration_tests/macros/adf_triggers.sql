{%- macro adf_triggers() -%}
{% set create_table %}
create or replace table `{{ target.database }}`.{{ target.schema }}.adf_triggers (
    id STRING,
    name STRING,
    type STRING,
    properties STRUCT<
        annotations ARRAY<STRING>,
        pipelines ARRAY<
            STRUCT<
                pipelineReference STRUCT<
                    referenceName STRING,
                    type STRING
                >,
                parameters STRUCT<
                    days_before STRING,
                    environment STRING,
                    reset_type STRING,
                    Job_ID STRING,
                    DatabricksWorkspaceID STRING,
                    WaitRecheckSeconds INT
                >
            >
        >,
        type STRING,
        typeProperties STRUCT<
            recurrence STRUCT<
                frequency STRING,
                interval INT,
                startTime STRING,
                timeZone STRING,
                schedule STRUCT<
                    minutes ARRAY<INT>,
                    hours ARRAY<INT>,
                    weekDays ARRAY<STRING>,
                    monthDays ARRAY<INT>
                >
            >,
            parentTrigger STRING,
            requestedStartTime STRING,
            requestedEndTime STRING,
            rerunConcurrency INT
        >,
        runtimeState STRING
    >
);
{% endset %}

{% set insert_table %}
insert into `{{ target.database }}`.{{ target.schema }}.adf_triggers VALUES 
(
    '/subscriptions/9f07555crvices-dev-rg/providers/Microsoft.DataFactory/factories/tlo-datastudio-adf-d/triggers/TR-fd-prod-duration_estimation-monthly',
    'TR-fd-prod-duration_estimation-monthly',
    'Microsoft.DataFactory/factories/triggers',
    NAMED_STRUCT(
        'annotations', ARRAY('fraud-detection', 'prod', 'duration-estimation'),
        'pipelines', ARRAY(
            NAMED_STRUCT(
                'pipelineReference', NAMED_STRUCT(
                    'referenceName', 'fd-prod-duration_estimation',
                    'type', 'PipelineReference'
                ),
                'parameters', NAMED_STRUCT(
                    'days_before', NULL,
                    'environment', NULL,
                    'reset_type', NULL,
                    'Job_ID', NULL,
                    'DatabricksWorkspaceID', NULL,
                    'WaitRecheckSeconds', NULL
                )
            )
        ),
        'type', 'ScheduleTrigger',
        'typeProperties', NAMED_STRUCT(
            'recurrence', NAMED_STRUCT(
                'frequency', 'Month',
                'interval', 1,
                'startTime', '2020-10-14T04:30:00',
                'timeZone', 'E. South America Standard Time',
                'schedule', NAMED_STRUCT(
                    'minutes', ARRAY(30),
                    'hours', ARRAY(4),
                    'weekDays', NULL,
                    'monthDays', ARRAY(14)
                )
            ),
            'parentTrigger', NULL,
            'requestedStartTime', NULL,
            'requestedEndTime', NULL,
            'rerunConcurrency', NULL
        ),
        'runtimeState', NULL
    )
),
(
    '/subscriptions/9f07555crvices-dev-rg/providers/Microsoft.DataFactory/factories/tlo-datastudio-adf-d/triggers/TR-fd-dev-predict-main',
    'TR-fd-dev-predict-main',
    'Microsoft.DataFactory/factories/triggers',
    NAMED_STRUCT(
        'annotations', ARRAY('fraud-detection', 'dev', 'predict'),
        'pipelines', ARRAY(
            NAMED_STRUCT(
                'pipelineReference', NAMED_STRUCT(
                    'referenceName', 'fd-dev-predict-main',
                    'type', 'PipelineReference'
                ),
                'parameters', NAMED_STRUCT(
                    'days_before', NULL,
                    'environment', NULL,
                    'reset_type', NULL,
                    'Job_ID', NULL,
                    'DatabricksWorkspaceID', NULL,
                    'WaitRecheckSeconds', NULL
                )
            )
        ),
        'type', 'ScheduleTrigger',
        'typeProperties', NAMED_STRUCT(
            'recurrence', NAMED_STRUCT(
                'frequency', 'Week',
                'interval', 1,
                'startTime', '2021-01-26T21:50:00',
                'timeZone', 'E. South America Standard Time',
                'schedule', NAMED_STRUCT(
                    'minutes', ARRAY(0),
                    'hours', ARRAY(5),
                    'weekDays', ARRAY('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'),
                    'monthDays', NULL
                )
            ),
            'parentTrigger', NULL,
            'requestedStartTime', NULL,
            'requestedEndTime', NULL,
            'rerunConcurrency', NULL
        ),
        'runtimeState', 'Stopped'
    )
);
{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table adf_triggers", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table adf_triggers", info=true) %}
{%- endmacro -%}