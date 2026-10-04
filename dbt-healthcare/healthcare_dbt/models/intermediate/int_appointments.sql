{{ config(materialized='table') }}

select
    a.appointment_id,
    a.patient_id,
    p.patient_name,
    p.gender,
    a.doctor_id,
    d.doctor_name,
    d.specialty,
    a.appointment_date,
    a.appointment_time,
    a.status,
    a.reason

from {{ ref('stg_appointments') }} a

left join {{ ref('int_patients') }} p
    on a.patient_id = p.patient_id

left join {{ ref('stg_doctors') }} d
    on a.doctor_id = d.doctor_id