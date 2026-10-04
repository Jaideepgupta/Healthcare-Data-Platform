{{ config(
    materialized='table'
) }}

SELECT
    department_id,
    department_name,
    floor_number,
    manager_name
FROM {{ ref('stg_departments') }}