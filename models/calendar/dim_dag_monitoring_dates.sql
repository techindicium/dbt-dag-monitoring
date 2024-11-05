{% set end_date_query %}
select {{ date_add("year", "100", "current_date()") }} 
{% endset %}

{% if execute %}
    {%set end_date = run_query(end_date_query).columns[0].values()[0] %}
    {% else %}
    {% set end_date = ' ' %}
{% endif %}

/* generating dates using a dbt-utils macro */
with
    dates_raw as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('1970-01-01' as date)",
        end_date="cast('" ~ end_date ~ "' as date)"
        )
    }}
)

/* extracting some date information*/
    , days_info as (
        select
            cast(date_day as date) as date_day
            , extract(DAYOFWEEK from date_day) as week_day
            , extract(month from date_day) as month_number
            , extract(quarter from date_day) as quarter_number
            , {{ day_of_year("date_day") }} as day_of_year
            , extract(year from date_day) as year_date
            , {{ month_day('date_day') }} as month_day
        from dates_raw
    )

/**/
    , days_named as (
        select
            *
            , {{ day_of_week('week_day') }}
            , case
                when month_number = 1 then 'January'
                when month_number = 2 then 'February'
                when month_number = 3 then 'March'
                when month_number = 4 then 'April'
                when month_number = 5 then 'May'
                when month_number = 6 then 'June'
                when month_number = 7 then 'July'
                when month_number = 8 then 'August'
                when month_number = 9 then 'September'
                when month_number = 10 then 'October'
                when month_number = 11 then 'November'
                else 'December'
            end as month_name
            , case
                when month_number = 1 then 'Jan'
                when month_number = 2 then 'Feb'
                when month_number = 3 then 'Mar'
                when month_number = 4 then 'Apr'
                when month_number = 5 then 'May'
                when month_number = 6 then 'Jun'
                when month_number = 7 then 'Jul'
                when month_number = 8 then 'Aug'
                when month_number = 9 then 'Sep'
                when month_number = 10 then 'Oct'
                when month_number = 11 then 'Nov'
                else 'Dec'
            end as month_short
            , case
                when quarter_number = 1 then '1º quarter'
                when quarter_number = 2 then '2º quarter'
                when quarter_number = 3 then '3º quarter'
                else '4º quarter'
            end as quarter_name
            , case
                when quarter_number in(1,2) then 1
                else 2
            end as semester
            , case
                when quarter_number in(1,2) then '1º Semester'
                else '2º Semester'
            end as semester_name
        from days_info
    )

    , flags_cte as (
        /*flags related to holidays and business days*/
        select
            *
            , case
                when month_day = '01-01' then true
                when month_day = '21-04' then true
                when month_day = '01-05' then true
                when month_day = '07-09' then true
                when month_day = '12-10' then true
                when month_day = '02-11' then true
                when month_day = '15-11' then true
                when month_day = '25-12' then true
                else false
            end as fl_holiday
            , case
                when week_day in(6, 0) then false
                when month_day = '01-01' then false
                when month_day = '21-04' then false
                when month_day = '01-05' then false
                when month_day = '07-09' then false
                when month_day = '12-10' then false
                when month_day = '02-11' then false
                when month_day = '15-11' then false
                when month_day = '25-12' then false
                else true
            end as fl_business_day
            , coalesce(week_day in(6, 0), false) as fl_weekends
        from days_named
    )

/* reorganizing the columns */
    , final_cte as (
        select
            date_day
            , week_day
            , name_of_day
            , month_number
            , month_name
            , month_short
            , quarter_number
            , quarter_name
            , semester
            , semester_name
            , fl_holiday
            , fl_business_day
            , fl_weekends
            , day_of_year
            , year_date
        from flags_cte
    )

select *
from final_cte