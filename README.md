# Dag Monitoring
This package allows you to easily monitor your DAGs from well known orchestration tools, providing helpful info to improve your data pipeline.

## Tools supported:

- Azure Datafactory
- Apache Airflow
- Databricks Workflows

If you are cloning this repository, we recommend that the clone happens via SSH key. 

# :running: Quickstart

New to dbt packages? Read more about them [here](https://docs.getdbt.com/docs/building-a-dbt-project/package-management/).

## Requirements
dbt version
* ```dbt version >= 1.3.0```

dbt_utils package. Read more about them [here](https://hub.getdbt.com/dbt-labs/dbt_utils/latest/).
* ```dbt-labs/dbt_utils version: 1.1.0``` 

This package works for most of EL processes and depends on the metadata generated by the respective platform.

## Installation

1. Include this package in your `packages.yml` file.
```yaml
packages:
  - git: "https://github.com/techindicium/dbt-dag-monitoring.git" # insert git URL
```

2. Run `dbt deps` to install the package.

## Configuring models package

### Models:
The functioning of the package on the desired platform depends on the configuration of dbt_project.yml. To define which platform we are transforming the data to, the enabled field must be "true", for the desired platform, and "false" for all others.

### Vars:
Then, we define the variables: in the first line we determine which platform dbt should consider the variables for. In the third line we define which data the monitoring will be based on, and in the following lines we define which database and data schema will be used, according to the platform defined above.
```
models:
  dbt_dag_monitoring:
    marts:
      materialized: table
    staging:
      airflow_sources:
        enabled: #true or false
      adf_sources:
        enabled: #true or false
      databricks_workflow_sources:
        enabled: #true or false
```
...
```
vars:
  dbt_dag_monitoring:
    enabled_sources: ['airflow'] #Possible values: 'airflow', 'adf' or 'databricks_workflow'
    dag_monitoring_start_date: cast('2023-01-01' as date)
    dag_monitoring_airflow_database: #landing_zone
    dag_monitoring_airflow_schema: #airflow_metadata
    dag_monitoring_databricks_database: #raw_catalog
    dag_monitoring_databricks_schema: #databricks_metadata
    dag_monitoring_adf_database: #raw
    dag_monitoring_adf_schema: #adf_metadata
```

## Airflow metadata

The airflow sources are based on the Airflow metadata database, any form of extraction from it should suffice.

The package is consistent with any type of EL process, and the data warehouse must have the following tables:
- dag_run
- task_instance
- task_fail
- dag

## ADF Metadata

The adf models rely on sources extracted by our adf tap:

https://bitbucket.org/indiciumtech/platform_meltano_el/src/6b9c9e970518db1e21086ec75a7442d1b6978c93/plugins/custom/tap-azuredatafactory/?at=featuer%2Fadd_adf_extractor

## Databricks Workflow Data
The databricks workflow models rely on sources extracted by our adf tap:

https://bitbucket.org/indiciumtech/platform_meltano_el/src/main/plugins/custom/tap-databricksops/

specifically the streams:

- jobs
- job_runs


