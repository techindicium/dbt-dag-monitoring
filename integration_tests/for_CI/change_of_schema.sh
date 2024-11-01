#!/bin/bash

source=$1

sed -i "s/dag_monitoring_${source}_database: $2/dag_monitoring_${source}_schema: $3/" "$GITHUB_WORKSPACE/integration_tests/dbt_project.yml"
