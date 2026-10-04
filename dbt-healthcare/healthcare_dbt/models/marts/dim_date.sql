{{ config(
    materialized='table'
) }}

WITH date_bounds AS (

    SELECT
        MIN(encounter_date) AS min_date,
        MAX(encounter_date) AS max_date
    FROM {{ ref('int_encounters') }}

),

date_spine AS (

    SELECT
        EXPLODE(
            SEQUENCE(
                min_date,
                max_date,
                INTERVAL 1 DAY
            )
        ) AS date_day

    FROM date_bounds

)

SELECT
    CAST(date_format(date_day, 'yyyyMMdd') AS INT) AS date_key,

    date_day AS date,

    YEAR(date_day) AS year,

    QUARTER(date_day) AS quarter,

    MONTH(date_day) AS month,

    date_format(date_day, 'MMMM') AS month_name,

    DAY(date_day) AS day,

    DAYOFWEEK(date_day) AS day_of_week,

    date_format(date_day, 'EEEE') AS day_name,

    WEEKOFYEAR(date_day) AS week_of_year,

    CASE
        WHEN DAYOFWEEK(date_day) IN (1, 7)
        THEN TRUE
        ELSE FALSE
    END AS is_weekend,

    CASE
        WHEN MONTH(date_day) >= 4
        THEN YEAR(date_day)
        ELSE YEAR(date_day) - 1
    END AS fiscal_year,

    CASE
        WHEN MONTH(date_day) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH(date_day) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH(date_day) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END AS fiscal_quarter

FROM date_spine