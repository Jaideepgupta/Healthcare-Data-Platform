{{ config(
    materialized='table'
) }}

SELECT

    -- Billing key
    bill_id,

    -- Encounter relationship
    encounter_id,

    -- Source patient ID
    -- Kept for data-quality investigation
    patient_id AS billing_patient_id,

    -- Insurance relationship
    insurance_provider_id,

    -- Billing attributes
    provider_name,
    plan_type,
    payment_status,

    -- Financial metrics
    COALESCE(total_amount, 0) AS total_amount,

    COALESCE(insurance_paid, 0) AS insurance_paid,

    COALESCE(patient_paid, 0) AS patient_paid,

    COALESCE(total_amount, 0)
        - COALESCE(insurance_paid, 0)
        - COALESCE(patient_paid, 0)
        AS outstanding_amount

FROM {{ ref('int_billing') }}