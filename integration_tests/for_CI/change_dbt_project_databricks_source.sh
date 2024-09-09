#!/bin/bash

# Enable databricks sources in dbt_project.yml
sed -i '/raw_databricks_workflow_monitoring:/,/enabled:/s/enabled: false/enabled: true/' ./dbt_project.yml

# Disable airflow sources in dbt_project.yml
sed -i 's/\(raw_airflow_monitoring:\s*\n\s*+enabled:\s*\)true/\1false/' ./dbt_project.yml

# Disable airflow_workflow models in dbt_project.yml
sed -i '/airflow_sources:/,/enabled:/s/enabled: true/enabled: false/' ./dbt_project.yml

# Enable databricks_workflow models in dbt_project.yml
sed -i '/databricks_workflow_sources:/,/enabled:/s/enabled: false/enabled: true/' ./dbt_project.yml

# Update the enabled_sources in dbt_project.yml
sed -i "s/enabled_sources: \[.*\]/enabled_sources: \['databricks_workflow'\]/" ./dbt_project.yml