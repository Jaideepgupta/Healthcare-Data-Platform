select
    bill_id,
    patient_id,
    encounter_id,
    insurance_provider_id,
    billing_date,
    total_amount,
    insurance_paid,
    patient_paid,
    payment_status
from {{ source('bronze', 'billing') }}