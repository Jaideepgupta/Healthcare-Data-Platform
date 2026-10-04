select
    procedure_id,
    encounter_id,
    patient_id,
    doctor_id,
    procedure_name,
    procedure_date,
    cost
from {{ source('bronze', 'procedures') }}