{%- macro adf_pipeline_runs() -%}
{% set create_table %}
create or replace table `{{ target.database }}`.{{ target.schema }}.adf_pipeline_runs(
    id STRING,
    runId STRING,
    debugRunId STRING,
    runGroupId STRING,
    pipelineName STRING,
    parameters STRUCT<
        ENVIRONMENT STRING,
        RESET_TYPE STRING,
        DAYS_BEFORE STRING
    >,
    invokedBy STRUCT<
        id STRING,
        name STRING,
        invokedByType STRING,
        pipelineName STRING,
        pipelineRunId STRING
    >,
    runStart TIMESTAMP,
    runEnd TIMESTAMP,
    durationInMs BIGINT,
    status STRING,
    message STRING,
    pipelineReturnValue MAP<STRING, STRING>,  -- Assuming an empty object can be represented as a map
    lastUpdated TIMESTAMP,
    annotations ARRAY<STRING>,
    runDimension MAP<STRING, STRING>,  -- Assuming an empty object can be represented as a map
    isLatest BOOLEAN
);
{% endset %}


{% set insert_table %}
INSERT INTO `{{ target.database }}`.{{ target.schema }}.adf_pipeline_runs
VALUES 
(
    '/SUBSCRIPTITLO-DATASTUDIO-ADF-D/pipe082b73db5',
    '9f81a5eb--833e-db6082b73db5',
    NULL,  -- debugRunId
    '9f81a5eb-833e-db6082b73db5',
    'PL-FEMFILingZone-N',
    NAMED_STRUCT(
        'ENVIRONMENT', 'FILESCSV',
        'RESET_TYPE', 'FULL',
        'DAYS_BEFORE', NULL
    ),
    NAMED_STRUCT(
        'id', 'cf613b7b-e0c4-431d-b272-e924dc0cfbe8',
        'name', 'cf613b7b-e0c4-431d-b272-e924dc0cfbe8',
        'invokedByType', 'PipelineActivity',
        'pipelineName', 'PL-OrquestradorSourceTOBronzeZeroLoadingControl',
        'pipelineRunId', '598ec8ee-604c-47c7-a3c0-e049c4b8c558'
    ),
    '2024-08-20T03:30:06.6061079Z',
    '2024-08-20T03:47:03.9865228Z',
    1017380,
    'Succeeded',
    NULL,
    MAP(),  -- Empty object as a map
    '2024-08-20T03:47:03.9879388Z',
    ARRAY(),  -- Empty array
    MAP(),  -- Empty object as a map
    true
),
(
    '/SUBSCRIPTIOTASTUDIO-ADF-D/pipelinerua1-9313-73fa5c0a3f0e',
    '64c7a8c7-30e2-4fa1-9313-73fa5c0a3f0e',
    NULL,  -- debugRunId
    '64c7a8c7-30e2-4fa1-9313-73fa5c0a3f0e',
    'NET_REC_DAILY_PRICE_UPDATE',
    NAMED_STRUCT(
        'ENVIRONMENT', NULL,
        'RESET_TYPE', NULL,
        'DAYS_BEFORE', '1'
    ),
    NAMED_STRUCT(
        'id', '08584774516819036014561066769CU22',
        'name', 'NET_REC_DAILY_UPDATE',
        'invokedByType', 'ScheduleTrigger',
        'pipelineName', NULL,
        'pipelineRunId', NULL
    ),
    '2024-08-20T12:00:31.2728264Z',
    '2024-08-20T13:15:52.6545498Z',
    4521381,
    'Succeeded',
    NULL,
    MAP(),  -- Empty object as a map
    '2024-08-20T13:15:52.6550273Z',
    ARRAY(
        'ted'
    ),
    MAP(),  -- Empty object as a map
    true
);
{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table adf_pipeline_runs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table adf_pipeline_runs", info=true) %}
{%- endmacro -%}