# Airflow Monitoring
This package allows you to easily monitor your airflow DAGs, providing helpful info to improve your data pipeline.

# :running: Quickstart

New to dbt packages? Read more about them [here](https://docs.getdbt.com/docs/building-a-dbt-project/package-management/).

## Requirements
dbt version
* ```dbt version >= 1.0.0```

dbt_utils package. Read more about them [here](https://hub.getdbt.com/dbt-labs/dbt_utils/latest/).
* ```dbt-labs/dbt_utils version: 0.8.0``` 

## Installation

1. Include this package in your `packages.yml` file.
```yaml
packages:
  - git: "https://github.com/techindicium/dbt-airflow-monitoring.git" # insert git URL
```

2. Run `dbt deps` to install the package.



## Configuring models package

The package's models can be configured in your `dbt_project.yml` by specifying the package under `models` and the start date of the airflow monitoring data must be declared in vars.

You should also populate a variable with the enabled dags metadata sources. This variable is named `enabled_sources`

```
models:
    dbt_airflow_monitoring:
        staging:
            materialized: ephemeral
        marts:
            materialized: table
```
...

```
vars:
    enabled_sources: ['airflow', 'adf'] # Possible values airflow, adf and databricks_workflow.
    dbt_airflow_monitoring:
       airflow_monitoring_start_date: cast('2023-01-01' as date) # edit date here
```

It's also necessary to switch on/off the models from dags sources you have data from.
example for running for adf and airflow:
```
models:
  dbt_airflow_monitoring:
    marts:
      materialized: table
    staging:
      airflow_sources:
        enabled: true
      adf_sources:
        enabled: true
      databricks_workflow_sources:
        enabled: false
```

To set the package`s source you can add/modify the following variables inside dbt_project.yml
```
vars:
  airflow_monitoring_airflow_database: landing_zone
  airflow_monitoring_airflow_schema: airflow_metadata
  airflow_monitoring_databricks_database: raw_catalog
  airflow_monitoring_databricks_schema: databricks_metadata
  airflow_monitoring_adf_database: raw
  airflow_monitoring_adf_schema: adf_metadata
```

## Airflow metadata

The airflow sources are based on the Airflow metadata database, any form of extraction from it should suffice

## ADF Metadata

The adf models rely on sources extracted by our adf tap:

https://bitbucket.org/indiciumtech/platform_meltano_el/src/6b9c9e970518db1e21086ec75a7442d1b6978c93/plugins/custom/tap-azuredatafactory/?at=featuer%2Fadd_adf_extractor

## Databricks Workflow Data
The databricks workflow models rely on sources extracted by our adf tap:

https://bitbucket.org/indiciumtech/platform_meltano_el/src/main/plugins/custom/tap-databricksops/

specifically the streams:

- jobs
- job_runs

# Improvements

## ADF

- maybe we should change the unique key for pipelines instead of deduping here. etag is the pipeline version, we are using it for deduping



