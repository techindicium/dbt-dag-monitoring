#!/bin/bash

source=$1

sed -i "s/dag_monitoring_${source}_database: $2/dag_monitoring_${source}_database: $3/" ./dbt_project.yml