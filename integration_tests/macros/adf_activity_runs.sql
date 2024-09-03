{% macro adf_activity_runs() %}
{% set create_table %}
    create or replace table `{{ target.database }}`.{{ target.schema }}.adf_activity_runs (
        activityRunEnd TIMESTAMP,
        activityName STRING,
        activityRunStart TIMESTAMP,
        activityType STRING,
        durationInMs INT,
        retryAttempt INT,
        error_errorCode STRING,
        error_message STRING,
        error_failureType STRING,
        error_target STRING,
        activityRunId STRING,
        linkedServiceName STRING,
        pipelineName STRING,
        pipelineRunId STRING,
        status STRING,
        output_effectiveIntegrationRuntime STRING,
        input_source_type STRING
    );
{% endset %}

{% set insert_table %}
INSERT INTO `{{ target.database }}`.{{ target.schema }}.adf_activity_runs VALUES 
(
    CAST('2024-08-20T03:30:10.973554Z' AS TIMESTAMP),
    CAST('Set CurrentDate' AS STRING),
    CAST('2024-08-20T03:30:10.742531Z' AS TIMESTAMP),
    CAST('SetVariable' AS STRING),
    CAST(231 AS INT),
    NULL,
    NULL,
    NULL,
    NULL,
    CAST('Set CurrentDate' AS STRING),
    CAST('f653c43a-6508-42f8-8467-0e10152aa3f9' AS STRING),
    NULL,
    CAST('PL-FEMFILESCSVTODatalakeLandingZone-N' AS STRING),
    CAST('9f81a5eb-a7ca-482e-833e-db6082b73db5' AS STRING),
    CAST('Succeeded' AS STRING),
    NULL,
    NULL
),
(
    CAST('2024-08-20T03:30:11.538784Z' AS TIMESTAMP),
    CAST('Set Timestamp' AS STRING),
    CAST('2024-08-20T03:30:11.274576Z' AS TIMESTAMP),
    CAST('SetVariable' AS STRING),
    CAST(264 AS INT),
    NULL,
    NULL,
    NULL,
    NULL,
    CAST('Set Timestamp' AS STRING),
    CAST('b8c48c2f-b0e6-45f0-a502-cee31dffba2e' AS STRING),
    NULL,
    CAST('PL-FEMFILESCSVTODatalakeLandingZone-N' AS STRING),
    CAST('9f81a5eb-a7ca-482e-833e-db6082b73db5' AS STRING),
    CAST('Succeeded' AS STRING),
    NULL,
    NULL
);

{% endset %}

{% do run_query(create_table) %}
{% do log("finished creating table adf_activity_runs", info=true) %}

{% do run_query(insert_table) %}
{% do log("finished insert table adf_activity_runs", info=true) %}
{% endmacro %}