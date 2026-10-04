{{ config(
    materialized='table'
) }}

WITH encounters AS (

    SELECT
        encounter_id,
        patient_id,
        doctor_id,
        department_id,
        encounter_type,
        encounter_date,
        admission_source,
        discharge_status
    FROM {{ ref('int_encounters') }}

),

diagnosis_summary AS (

    SELECT
        encounter_id,

        COUNT(DISTINCT diagnosis_id) AS diagnosis_count,

        COUNT(
            DISTINCT CASE
                WHEN UPPER(severity) IN ('HIGH', 'SEVERE', 'CRITICAL')
                THEN diagnosis_id
            END
        ) AS high_severity_diagnosis_count

    FROM {{ ref('int_diagnoses') }}

    GROUP BY encounter_id

),

procedure_summary AS (

    SELECT
        encounter_id,

        COUNT(DISTINCT procedure_id) AS procedure_count,

        SUM(COALESCE(cost, 0)) AS procedure_cost

    FROM {{ ref('int_procedures') }}

    GROUP BY encounter_id

),

billing_summary AS (

    SELECT
        encounter_id,

        COUNT(DISTINCT bill_id) AS bill_count,

        SUM(COALESCE(total_amount, 0)) AS total_billed_amount,

        SUM(COALESCE(insurance_paid, 0)) AS insurance_paid_amount,

        SUM(COALESCE(patient_paid, 0)) AS patient_paid_amount,

        SUM(
            COALESCE(total_amount, 0)
            - COALESCE(insurance_paid, 0)
            - COALESCE(patient_paid, 0)
        ) AS outstanding_amount

    FROM {{ ref('int_billing') }}

    GROUP BY encounter_id

)

SELECT

    e.encounter_id,

    e.patient_id,

    e.doctor_id,

    e.department_id,

    CAST(
        date_format(e.encounter_date, 'yyyyMMdd')
        AS INT
    ) AS date_key,

    e.encounter_type,

    e.encounter_date,

    e.admission_source,

    e.discharge_status,

    COALESCE(d.diagnosis_count, 0) AS diagnosis_count,

    COALESCE(
        d.high_severity_diagnosis_count,
        0
    ) AS high_severity_diagnosis_count,

    COALESCE(p.procedure_count, 0) AS procedure_count,

    COALESCE(p.procedure_cost, 0) AS procedure_cost,

    COALESCE(b.bill_count, 0) AS bill_count,

    COALESCE(
        b.total_billed_amount,
        0
    ) AS total_billed_amount,

    COALESCE(
        b.insurance_paid_amount,
        0
    ) AS insurance_paid_amount,

    COALESCE(
        b.patient_paid_amount,
        0
    ) AS patient_paid_amount,

    COALESCE(
        b.outstanding_amount,
        0
    ) AS outstanding_amount

FROM encounters e

LEFT JOIN diagnosis_summary d
    ON e.encounter_id = d.encounter_id

LEFT JOIN procedure_summary p
    ON e.encounter_id = p.encounter_id

LEFT JOIN billing_summary b
    ON e.encounter_id = b.encounter_id