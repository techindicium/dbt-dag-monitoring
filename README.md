# Dag Monitoring
This package allows you to easily monitor your DAGs from well known orchestration tools, providing helpful info to improve your data pipeline.

# Table of Contents

- [Before creating a branch](#Before-creating-a-branch)
- [Revisions](#revisions)
  - [Tools supported](#tools-supported)
- [Quickstart](#quickstart)
  - [requirements](#requirements)
  - [Profiles](#profiles)
  - [Installation](#installation)
  - [Configuring models package](#dbt-project-structure)
  - [Airflow metadata](#Airflow-metadata)
  - [ADF metadata](#ADF-metadata)
  - [Databricks Workflow Data](#Databricks-Workflow-Data)
  - [Integration tests](#Integration-tests)

# Before creating a branch

Pay attention, it is very important to know if your modification to this repository is a release/major (breaking changes), a feature/minor (functionalities) or a patch(to fix bugs). With that information, create your branch name like this:

- `release/<branch-name>` or `major/<branch-name>` or `Release/<branch-name>` or `Major/<branch-name>`
- `feature/<branch-name>` or `minor/<branch-name>` with capitalised letters work as well
- `patch/<branch-name>` or `fix/<branch-name>` or `hotfix/<branch-name>` with capitalised letters work as well

# Revisions
0.3.0 - For Snowflake warehouses
0.3.1 - For Redshift warehouses

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
* ```dbt-labs/dbt_utils version: 1.1.1``` 

This package works for most of EL processes and depends on the metadata generated by the respective platform.

## Profiles
Using as example a profile for Databricks workflows, when testing the repository, it is necessary to fill the profiles information below by changing the `example.env` to `.env`, and filling its variables with the adequate values.

```
dbt_dag_monitoring:
    target: "{{ env_var('DBT_DEFAULT_TARGET', 'dev')}}"
    outputs:
        dev: 
            type: databricks
            catalog: "{{ env_var('DEV_CATALOG_NAME')}}"
            schema: "{{ env_var('DEV_SCHEMA_NAME')}}"
            host: "{{ env_var('DEV_HOST') }}"
            http_path: "{{ env_var('DEV_HTTP_PATH') }}"
            token: "{{ env_var('DEV_TOKEN') }}"
            threads: 16
            ansi_mode: false
```

When it is done, there are two necessary commands for working locally without difficulties:

`chmod +x setup.sh`

and 

`source setup.sh`

## Installation

1. Include this package in your `packages.yml` file.
```yaml
packages:
  - git: "https://github.com/techindicium/dbt-dag-monitoring.git"
    revision: # 0.3.0 or 0.3.1
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
      +materialized: table
    staging:
      +materialized: view
      airflow_sources:
        +enabled: true
      adf_sources:
        +enabled: false
      databricks_workflow_sources:
        +enabled: false

sources:
  dbt_dag_monitoring:
    staging:
      adf_sources:
        raw_adf_monitoring:
          +enabled: false
      databricks_workflow_sources:
        raw_databricks_workflow_monitoring:
          +enabled: false
      airflow_sources:
        raw_airflow_monitoring:
          +enabled: true
```
...

When the vars are added to the dbt_project, it suppresses dbt compilation errors.
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

## Integration tests

> [!IMPORTANT]  
> When using the integration tests folder, for the sake of the continuous integration code run seamlessly, you can NOT change in your pull request the default value of the vars, models and sources being Databricks inside the integration_tests/dbt_project.yml. Following the source pattern is important.

More information on the README.md in .github folder.

