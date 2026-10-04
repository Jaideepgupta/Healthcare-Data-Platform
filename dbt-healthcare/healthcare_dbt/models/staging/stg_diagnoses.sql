select
    diagnosis_id,
    encounter_id,
    patient_id,
    diagnosis_code,
    diagnosis_description,
    diagnosis_date,
    severity
from {{ source('bronze', 'diagnoses') }}