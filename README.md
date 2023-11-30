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
    dbt_airflow_monitoring:
       airflow_monitoring_start_date: cast('2023-01-01' as date) # edit date here
```

To switch between Azure datafactory and Airflow simply change the models config,
example for running adf instead of airflow:
```
models:
  dbt_airflow_monitoring:
    marts:
      materialized: table
    staging:
      airflow_sources:
        enabled: false
      adf_sources:
        enabled: true
```

# Improvements

## Datafactory

- maybe we should change the unique key for pipelines instead of deduping here. etag is the pipeline version, we are using it for deduping
