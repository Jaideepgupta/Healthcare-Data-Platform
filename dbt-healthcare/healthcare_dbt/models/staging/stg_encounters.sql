select
    encounter_id,
    patient_id,
    doctor_id,
    department_id,
    encounter_type,
    encounter_date,
    admission_source,
    discharge_status
from {{ source('bronze', 'encounters') }}