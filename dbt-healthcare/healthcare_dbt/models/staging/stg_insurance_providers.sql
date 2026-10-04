select
    insurance_provider_id,
    provider_name,
    plan_type,
    coverage_percent,
    contact_number
from {{ source('bronze', 'insurance_providers') }}