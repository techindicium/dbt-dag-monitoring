{% macro adf_pipeline_runs() -%}
    {{ return(adapter.dispatch('adf_pipeline_runs')()) }}
{%- endmacro %}

{%- macro databricks__adf_pipeline_runs() -%}
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
    pipelineReturnValue MAP<STRING, STRING>,
    lastUpdated TIMESTAMP,
    annotations ARRAY<STRING>,
    runDimension MAP<STRING, STRING>,
    isLatest BOOLEAN
);
{% endset %}

{% set insert_table %}
INSERT INTO `{{ target.database }}`.{{ target.schema }}.adf_pipeline_runs
VALUES 
(
    '/SUBSCRIPTIONS/9F07555C-22AC-4CE8-9DEV-RG/PROVIDERS/MICROSOFT.DATAFACTORY/FACTORIES/TLO-DATASTUDIO-ADF-D/pipe082b73db5',
    '9f81a5eb-a7ca-482e-833e-db6082b73db5',
    NULL,
    '9f81a5eb-a7ca-482e-833e-db6082b73db5',
    'PL-FEMFILESCSVTODatalakeLandingZone-N',
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
    MAP(),
    '2024-08-20T03:47:03.9879388Z',
    ARRAY(),
    MAP(),
    true
),
(
    '/SUBSCRIPTIONS/9/PROVIDERS/MICROSOFT.DATAFACTORY/FACTORIES/TLO-DATASTUDIO-ADF-D/pipelinerua1-9313-73fa5c0a3f0e',
    '64c7a8c7-30e2-4fa1-9313-73fa5c0a3f0e',
    NULL,
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
    MAP(),
    '2024-08-20T13:15:52.6550273Z',
    ARRAY(
        'ted'
    ),
    MAP(),  
    true
);
{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table adf_pipeline_runs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table adf_pipeline_runs", info=true) %}
{%- endmacro -%}

{%- macro snowflake__adf_pipeline_runs() -%}
{% set create_table %}
CREATE OR REPLACE TABLE `{{ target.database }}`.{{ target.schema }}.adf_pipeline_runs (
    id VARCHAR,
    runId VARCHAR,
    debugRunId VARCHAR,
    runGroupId VARCHAR,
    pipelineName VARCHAR,
    parameters VARIANT,
    invokedBy VARIANT,
    runStart TIMESTAMP,
    runEnd TIMESTAMP,
    durationInMs BIGINT,
    status VARCHAR,
    message VARCHAR,
    pipelineReturnValue VARIANT,
    lastUpdated TIMESTAMP,
    annotations ARRAY,
    runDimension VARIANT,
    isLatest BOOLEAN
);
{% endset %}

{% set insert_table %}
INSERT INTO `{{ target.database }}`.{{ target.schema }}.adf_pipeline_runs
SELECT 
    '/SUBSCRIPTIONS/9F07555C-22AC-4CE8-9DEV-RG/PROVIDERS/MICROSOFT.DATAFACTORY/FACTORIES/TLO-DATASTUDIO-ADF-D/pipe082b73db5',
    '9f81a5eb-a7ca-482e-833e-db6082b73db5',
    NULL,
    '9f81a5eb-a7ca-482e-833e-db6082b73db5',
    'PL-FEMFILESCSVTODatalakeLandingZone-N',
    OBJECT_CONSTRUCT(
        'ENVIRONMENT', 'FILESCSV',
        'RESET_TYPE', 'FULL',
        'DAYS_BEFORE', NULL
    ),
    OBJECT_CONSTRUCT(
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
    OBJECT_CONSTRUCT(),
    '2024-08-20T03:47:03.9879388Z',
    ARRAY_CONSTRUCT(),
    OBJECT_CONSTRUCT(),
    TRUE
UNION ALL
    SELECT 
    '/SUBSCRIPTIONS/9/PROVIDERS/MICROSOFT.DATAFACTORY/FACTORIES/TLO-DATASTUDIO-ADF-D/pipelinerua1-9313-73fa5c0a3f0e',
    '64c7a8c7-30e2-4fa1-9313-73fa5c0a3f0e',
    NULL,
    '64c7a8c7-30e2-4fa1-9313-73fa5c0a3f0e',
    'NET_REC_DAILY_PRICE_UPDATE',
    OBJECT_CONSTRUCT(
        'ENVIRONMENT', NULL,
        'RESET_TYPE', NULL,
        'DAYS_BEFORE', '1'
    ),
    OBJECT_CONSTRUCT(
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
    OBJECT_CONSTRUCT(),
    '2024-08-20T13:15:52.6550273Z',
    ARRAY_CONSTRUCT(
        'ted'
    ),
    OBJECT_CONSTRUCT(),
    TRUE
;
{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table adf_pipeline_runs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table adf_pipeline_runs", info=true) %}
{%- endmacro -%}