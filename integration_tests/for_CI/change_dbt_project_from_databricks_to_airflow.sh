#!/bin/bash

# Disable databricks sources in dbt_project.yml
sed -i 's/\(raw_databricks_workflow_monitoring:\s*\n\s*+enabled:\s*\)true/\1false/' ./dbt_project.yml

# Enable airflow sources in dbt_project.yml
sed -i '/raw_airflow_monitoring:/,/enabled:/s/enabled: false/enabled: true/' ./dbt_project.yml

# Enable airflow models in dbt_project.yml
sed -i '/airflow_sources:/,/enabled:/s/enabled: false/enabled: true/' ./dbt_project.yml

# Disable databricks_workflow models in dbt_project.yml
sed -i '/databricks_workflow_sources:/,/enabled:/s/enabled: true/enabled: false/' ./dbt_project.yml

# Update the enabled_sources in dbt_project.yml
sed -i "s/enabled_sources: \[.*\]/enabled_sources: \['airflow'\]/" ./dbt_project.yml