{{ config(materialized='table') }}

select
    pr.procedure_id,
    pr.encounter_id,
    pr.patient_id,
    e.patient_name,
    e.gender,
    pr.doctor_id,
    e.doctor_name,
    e.specialty,
    e.department_id,
    e.department_name,
    pr.procedure_name,
    pr.procedure_date,
    pr.cost

from {{ ref('stg_procedures') }} pr

left join {{ ref('int_encounters') }} e
    on pr.encounter_id = e.encounter_id