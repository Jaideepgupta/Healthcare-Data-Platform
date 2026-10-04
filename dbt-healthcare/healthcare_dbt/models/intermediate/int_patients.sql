{{ config(materialized='table') }}

select
    patient_id,

    first_name,
    last_name,

    concat(first_name, ' ', last_name) as patient_name,

    cast(date_of_birth as date) as date_of_birth,

    gender,
    marital_status,
    race,
    ethnicity,
    language,

    trim(address) as address,
    trim(city) as city,
    upper(trim(state)) as state,
    zip_code,

    phone_number,
    lower(trim(email)) as email,

    emergency_contact,
    primary_physician_id,
    insurance_provider_id,

    cast(admission_date as date) as admission_date,
    cast(discharge_date as date) as discharge_date,

    datediff(
        coalesce(cast(discharge_date as date), current_date()),
        cast(admission_date as date)
    ) as length_of_stay_days,

    current_timestamp() as _processed_timestamp

from {{ ref('stg_patients') }}