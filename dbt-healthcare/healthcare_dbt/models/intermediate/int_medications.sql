{{ config(materialized='table') }}

select
    m.patient_id,
    p.patient_name,
    p.gender,
    m.doctor_id,
    d.doctor_name,
    d.specialty,
    m.medicine_name,
    m.dosage,
    m.frequency,
    m.start_date,
    m.end_date

from {{ ref('stg_medications') }} m

left join {{ ref('int_patients') }} p
    on m.patient_id = p.patient_id

left join {{ ref('stg_doctors') }} d
    on m.doctor_id = d.doctor_id