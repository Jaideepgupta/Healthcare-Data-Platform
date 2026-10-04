select
    doctor_id,
    doctor_name,
    specialty,
    department_id,
    phone_number,
    email,
    hire_date
from {{ source('bronze', 'doctors') }}