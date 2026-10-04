{{ config(
    materialized='table'
) }}

SELECT
    patient_id,
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS patient_name,
    date_of_birth,
    gender,
    marital_status,
    race,
    ethnicity,
    language,
    city,
    state,
    zip_code,
    phone_number,
    email,
    emergency_contact,
    primary_physician_id,
    insurance_provider_id
FROM {{ ref('int_patients') }}