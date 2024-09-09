#!/bin/bash

# Enable adf sources in dbt_project.yml
sed -i '/raw_adf_monitoring:/,/enabled:/s/enabled: false/enabled: true/' "$GITHUB_WORKSPACE/integration_tests/dbt_project.yml"

# Disable databricks sources in dbt_project.yml
sed -i 's/\(raw_databricks_workflow_monitoring:\s*\n\s*+enabled:\s*\)true/\1false/' "$GITHUB_WORKSPACE/integration_tests/dbt_project.yml"

# Enable adf models in dbt_project.yml
sed -i '/adf_sources:/,/enabled:/s/enabled: false/enabled: true/' "$GITHUB_WORKSPACE/integration_tests/dbt_project.yml"

# Disable databricks_workflow models in dbt_project.yml
sed -i '/databricks_workflow_sources:/,/enabled:/s/enabled: true/enabled: false/' "$GITHUB_WORKSPACE/integration_tests/dbt_project.yml"

# Update the enabled_sources in dbt_project.yml
sed -i "s/enabled_sources: \[.*\]/enabled_sources: \['adf'\]/" "$GITHUB_WORKSPACE/integration_tests/dbt_project.yml"
