with dates as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2011-01-01' as date)",
        end_date="cast('2015-01-01' as date)"
    ) }}
)

select
    cast(date_day as date)                      as date_key,
    extract(year from date_day)                 as year_number,
    extract(month from date_day)                as month_number,
    extract(quarter from date_day)              as quarter_number,
    strftime(cast(date_day as date), '%Y-%m')   as year_month,
    strftime(cast(date_day as date), '%b')      as month_short_name
from dates
