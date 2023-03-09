# Airflow Monitoring

This package allows you to easily monitor your airflow DAGs, providing helpful info to improve your data pipeline.


# :running: Quickstart

New to dbt packages? Read more about them [here](https://docs.getdbt.com/docs/building-a-dbt-project/package-management/).

## Requirements
dbt version
* ```dbt version >= 1.0.0```

## Installation

1. Include this package in your `packages.yml` file.
```yaml
packages:
  - git: "git@github.com:techindicium/dbt-airflow-monitoring.git" # insert git SSH URL
```

2. Run `dbt deps` to install the package.



## Configuring models package

The package's models can be configured in your `dbt_project.yml` by specifying the package under `models`.

```
models:
    dbt_airflow_monitoring:
        staging:
            materialized: ephemeral
        marts:
            materialized: table
```
