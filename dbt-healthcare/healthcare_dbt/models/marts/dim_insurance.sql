{{ config(
    materialized='table'
) }}

SELECT
    insurance_provider_id,
    provider_name,
    plan_type,
    coverage_percent,
    contact_number
FROM {{ ref('stg_insurance_providers') }}