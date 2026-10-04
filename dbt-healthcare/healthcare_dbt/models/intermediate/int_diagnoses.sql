{{ config(materialized='table') }}

select
    dg.diagnosis_id,
    dg.encounter_id,
    dg.patient_id,
    e.patient_name,
    e.gender,
    e.doctor_id,
    e.doctor_name,
    e.specialty,
    e.department_id,
    e.department_name,
    dg.diagnosis_code,
    dg.diagnosis_description,
    dg.diagnosis_date,
    dg.severity

from {{ ref('stg_diagnoses') }} dg

left join {{ ref('int_encounters') }} e
    on dg.encounter_id = e.encounter_id