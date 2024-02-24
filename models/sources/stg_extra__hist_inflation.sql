with
    source as (select * from {{ source('EXTRA', 'HIST_INFLATION') }}),

    renamed as (
        select
            year,
            amount as _1800_dollar_value,
            inflation_rate as inflation_vs_previous_year
        from source
    )

select *
from renamed
