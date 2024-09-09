#!/bin/bash

# Enable adf sources in dbt_project.yml
sed -i '/raw_adf_monitoring:/,/enabled:/s/enabled: true/enabled: false/' dbt_project.yml

# Disable databricks sources in dbt_project.yml
sed -i 's/\(raw_airflow_monitoring:\s*\n\s*+enabled:\s*\)false/\1true/' dbt_project.yml

# Enable adf models in dbt_project.yml
sed -i '/adf_sources:/,/enabled:/s/enabled: true/enabled: false/' dbt_project.yml

# Disable databricks_workflow models in dbt_project.yml
sed -i '/airflow_sources:/,/enabled:/s/enabled: false/enabled: true/' dbt_project.yml

# Update the enabled_sources in dbt_project.yml
sed -i "s/enabled_sources: \[.*\]/enabled_sources: \['airflow'\]/" dbt_project.yml
