select
    medication_id,
    patient_id,
    doctor_id,
    medicine_name,
    dosage,
    frequency,
    start_date,
    end_date
from {{ source('bronze', 'medications') }}