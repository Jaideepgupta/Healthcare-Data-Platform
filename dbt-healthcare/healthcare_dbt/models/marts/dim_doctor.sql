{{ config(
    materialized='table'
) }}

SELECT
    doctor_id,
    doctor_name,
    specialty,
    department_id,
    phone_number,
    email,
    hire_date
FROM {{ ref('stg_doctors') }}