{{ config(materialized='table') }}

select
    b.bill_id,
    b.patient_id,
    e.patient_name,
    e.gender,
    b.encounter_id,
    e.doctor_id,
    e.doctor_name,
    e.specialty,
    e.department_id,
    e.department_name,
    b.insurance_provider_id,
    ip.provider_name,
    ip.plan_type,
    ip.coverage_percent,
    b.billing_date,
    b.total_amount,
    b.insurance_paid,
    b.patient_paid,
    b.payment_status

from {{ ref('stg_billing') }} b

left join {{ ref('int_encounters') }} e
    on b.encounter_id = e.encounter_id

left join {{ ref('stg_insurance_providers') }} ip
    on b.insurance_provider_id = ip.insurance_provider_id