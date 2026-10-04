select
    department_id,
    department_name,
    floor_number,
    manager_name
from {{ source('bronze', 'departments') }}