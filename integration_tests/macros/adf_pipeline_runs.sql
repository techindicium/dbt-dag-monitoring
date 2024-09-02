{% macro adf_pipeline_runs() -%}
    {{ return(adapter.dispatch('adf_pipeline_runs')()) }}
{%- endmacro %}

{%- macro databricks__adf_pipeline_runs() -%}
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
    pipelineReturnValue MAP<STRING, STRING>,
    lastUpdated TIMESTAMP,
    annotations ARRAY<STRING>,
    runDimension MAP<STRING, STRING>,
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
    MAP(),
    '2024-08-20T03:47:03.9879388Z',
    ARRAY(),
    MAP(),
    ARRAY(),
    MAP(),
    true
),
(
    '/SUBSCRIPTIONS/9/PROVIDERS/MICROSOFT.DATAFACTORY/FACTORIES/TLO-DATASTUDIO-ADF-D/pipelinerua1-9313-73fa5c0a3f0e',
    '/SUBSCRIPTIONS/9/PROVIDERS/MICROSOFT.DATAFACTORY/FACTORIES/TLO-DATASTUDIO-ADF-D/pipelinerua1-9313-73fa5c0a3f0e',
    '64c7a8c7-30e2-4fa1-9313-73fa5c0a3f0e',
    NULL,
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
    MAP(),
    '2024-08-20T13:15:52.6550273Z',
    ARRAY(
        'ted'
    ),
    MAP(),  
    MAP(),  
    true
);
{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table adf_pipeline_runs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table adf_pipeline_runs", info=true) %}
{%- endmacro -%}


{%- macro bigquery__adf_pipeline_runs() -%}
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
    pipelineReturnValue ARRAY<STRUCT<key STRING, value STRING>>,
    lastUpdated TIMESTAMP,
    annotations ARRAY<STRING>,
    runDimension ARRAY<STRUCT<key STRING, value STRING>>,
    isLatest BOOLEAN
);

{% endset %}

{% set insert_table %}
INSERT INTO `{{ target.database }}.{{ target.schema }}.adf_pipeline_runs`
VALUES 
(
    '/SUBSCRIPTIONS/9F07555C-22AC-4CE8-9DEV-RG/PROVIDERS/MICROSOFT.DATAFACTORY/FACTORIES/TLO-DATASTUDIO-ADF-D/pipe082b73db5',
    '9f81a5eb-a7ca-482e-833e-db6082b73db5',
    NULL,
    '9f81a5eb-a7ca-482e-833e-db6082b73db5',
    'PL-FEMFILESCSVTODatalakeLandingZone-N',
    STRUCT(
        'FILESCSV' AS ENVIRONMENT,
        'FULL' AS RESET_TYPE,
        NULL AS DAYS_BEFORE
    ),
    STRUCT(
        'cf613b7b-e0c4-431d-b272-e924dc0cfbe8' AS id,
        'cf613b7b-e0c4-431d-b272-e924dc0cfbe8' AS name,
        'PipelineActivity' AS invokedByType,
        'PL-OrquestradorSourceTOBronzeZeroLoadingControl' AS pipelineName,
        '598ec8ee-604c-47c7-a3c0-e049c4b8c558' AS pipelineRunId
    ),
    TIMESTAMP('2024-08-20T03:30:06.606107Z'),
    TIMESTAMP('2024-08-20T03:47:03.986522Z'),
    1017380,
    'Succeeded',
    NULL,
    ARRAY<STRUCT<key STRING, value STRING>>[],
    TIMESTAMP('2024-08-20T03:47:03.987938Z'),
    ARRAY<STRING>[],
    ARRAY<STRUCT<key STRING, value STRING>>[],
    TRUE
),
(
    '/SUBSCRIPTIONS/9/PROVIDERS/MICROSOFT.DATAFACTORY/FACTORIES/TLO-DATASTUDIO-ADF-D/pipelinerua1-9313-73fa5c0a3f0e',
    '64c7a8c7-30e2-4fa1-9313-73fa5c0a3f0e',
    NULL,
    '64c7a8c7-30e2-4fa1-9313-73fa5c0a3f0e',
    'NET_REC_DAILY_PRICE_UPDATE',
    STRUCT(
        NULL AS ENVIRONMENT,
        NULL AS RESET_TYPE,
        '1' AS DAYS_BEFORE
    ),
    STRUCT(
        '08584774516819036014561066769CU22' AS id,
        'NET_REC_DAILY_UPDATE' AS name,
        'ScheduleTrigger' AS invokedByType,
        NULL AS pipelineName,
        NULL AS pipelineRunId
    ),
    TIMESTAMP('2024-08-20T12:00:31.272826Z'),
    TIMESTAMP('2024-08-20T13:15:52.654549Z'),
    4521381,
    'Succeeded',
    NULL,
    ARRAY<STRUCT<key STRING, value STRING>>[],
    TIMESTAMP('2024-08-20T13:15:52.655027Z'),
    ARRAY<STRING>['ted'],
    ARRAY<STRUCT<key STRING, value STRING>>[],
    TRUE
);


{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table adf_pipeline_runs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table adf_pipeline_runs", info=true) %}
{%- endmacro -%}
