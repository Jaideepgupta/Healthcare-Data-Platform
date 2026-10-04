{{ config(materialized='table') }}

select
    e.encounter_id,
    e.patient_id,
    p.patient_name,
    p.gender,
    p.date_of_birth,
    e.doctor_id,
    d.doctor_name,
    d.specialty,
    e.department_id,
    dept.department_name,
    e.encounter_type,
    e.encounter_date,
    e.admission_source,
    e.discharge_status

from {{ ref('stg_encounters') }} e

left join {{ ref('int_patients') }} p
    on e.patient_id = p.patient_id

left join {{ ref('stg_doctors') }} d
    on e.doctor_id = d.doctor_id

left join {{ ref('stg_departments') }} dept
    on e.department_id = dept.department_id