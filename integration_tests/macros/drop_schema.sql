{% macro drop_schema(schema_name) %}

    {% set drop_schema_query %}
        DROP SCHEMA IF EXISTS {{ schema_name }} CASCADE;
    {% endset %}

    {% if execute %}
        {{ run_query(drop_schema_query) }}
    {% endif %}

    {% do log("Dropped schema " ~ schema_name, info = true) %}

{% endmacro %}