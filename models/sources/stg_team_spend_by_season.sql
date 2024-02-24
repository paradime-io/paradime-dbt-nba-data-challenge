with
    source as (select * from {{ source('NBA', 'TEAM_SPEND_BY_SEASON') }}),

    renamed as (
        select
            team_id,
            team_city,
            team_name,
            full_name,
            year as season,
            total_spend as team_payroll,
            active_payroll,
            dead_payroll,
            luxury_tax_payroll,
            luxury_tax_space,
            luxury_tax_bill
        from source
    )

select *
from renamed
