import os
from databricks import sql

# Set up the connection to Databricks
connection = sql.connect(
    server_hostname=os.getenv("DATABRICKS_SERVER_HOSTNAME"),
    http_path=os.getenv("DATABRICKS_HTTP_PATH"),
    access_token=os.getenv("DATABRICKS_ACCESS_TOKEN")
)

# Drop the schema
schema_name = "ci_dbt_dag_monitoring"
query = f"DROP SCHEMA IF EXISTS {schema_name} CASCADE"

with connection.cursor() as cursor:
    cursor.execute(query)

print(f"Schema {schema_name} dropped successfully.")