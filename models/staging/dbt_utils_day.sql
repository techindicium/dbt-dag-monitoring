{{ dbt_utils.date_spine(
    datepart="day",
    start_date="'2016-01-01'",
    end_date="dateadd(month, 1, date_trunc('month', getdate()))"
   )
}}