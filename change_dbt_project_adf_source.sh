#!/bin/bash

# Enable adf sources in dbt_project.yml
sed -i 's/raw_adf_monitoring:\n\(\s\+\)+enabled: false/raw_adf_monitoring:\n\1+enabled: true/' dbt_project.yml

# Disable databricks sources in dbt_project.yml
sed -i 's/raw_databricks_workflow_monitoring:\n\(\s\+\)+enabled: true/raw_databricks_workflow_monitoring:\n\1+enabled: false/' dbt_project.yml

# Disable databricks_workflow models in dbt_project.yml
sed -i 's/databricks_workflow_sources:\n\(\s\+\)+enabled: true/databricks_workflow_sources:\n\1+enabled: false/' dbt_project.yml

# Enable adf_sources in dbt_project.yml
sed -i 's/adf_sources:\n\(\s\+\)+enabled: false/adf_sources:\n\1+enabled: true/' dbt_project.yml

# Update the enabled_sources in dbt_project.yml
sed -i 's/enabled_sources: \[.*\]/enabled_sources: \[adf\]/' dbt_project.yml
