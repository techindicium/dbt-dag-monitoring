{% macro adf_pipelines_name(column) -%}
    {{ return(adapter.dispatch('adf_pipelines_name')(column)) }}
{%- endmacro %}


{% macro default__adf_pipelines_name(column) -%}
   {{ column }}
{%- endmacro %}

{% macro bigquery__adf_pipelines_name(column) -%}
    {% if column ==  'pipelines.pipelineReference.referenceName' -%}
        {{ 'pipelineReference.referenceName' }}
    {% endif %}
{%- endmacro %} 