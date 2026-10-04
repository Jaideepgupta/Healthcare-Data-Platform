{{ config(materialized='table') }}

select
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    cast(appointment_time as string) as appointment_time,
    status,
    reason
from {{ source('bronze', 'appointments') }}