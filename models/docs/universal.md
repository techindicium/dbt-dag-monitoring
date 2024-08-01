[comment]: < Universal >

{% docs state_doc %}
Json with state property of the pipeline execution in the following format:
              {
                  "life_cycle_state": "TERMINATED",
                  "result_state": "SUCCESS",
                  "state_message": "",
                  "user_cancelled_or_timedout": false
              }
{% enddocs %}


{% docs tasks_doc %}
List of objects with information about the tasks. Example of a task in json:
              {
                "attempt_number": "0",
                "cleanup_duration": "0",
                "cluster_instance": {
                    "cluster_id": "0426-123-kq2r1tew",
                    "spark_context_id": "123"
                },
                "dbt_task": null,
                "depends_on": null,
                "description": null,
                "end_time": "1701855074931",
                "execution_duration": "110000",
                "existing_cluster_id": "0426-123-kq2r1tew",
                "git_source": null,
                "libraries": null,
                "notebook_task": {
                    "notebook_path": "/notebook",
                    "source": "WORKSPACE"
                },
                "run_id": "123",
                "setup_duration": "1000",
                "start_time": "1701854963851",
                "state": {
                    "life_cycle_state": "TERMINATED",
                    "result_state": "SUCCESS",
                    "state_message": "",
                    "user_cancelled_or_timedout": false
                },
                "task_key": "ADFafb-123"
              }
{% enddocs %}

{% docs settings_doc %}
Job configuration json like the following:
            {
                "email_notifications": {
                    "no_alert_for_skipped_runs": false,
                    "on_failure": null,
                    "on_start": null,
                    "on_success": null
                },
                "format": "MULTI_TASK",
                "max_concurrent_runs": "1",
                "name": "Fact_TransactionProtected_V2",
                "notification_settings": null,
                "schedule": {
                    "pause_status": "UNPAUSED",
                    "quartz_cron_expression": "19 0 9 * * ?",
                    "timezone_id": "America/Sao_Paulo"
                },
                "timeout_seconds": "0"
              }
{% enddocs %}
