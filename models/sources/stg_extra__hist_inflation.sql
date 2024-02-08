WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('EXTRA', 'HIST_INFLATION') }}
),


renamed AS (
    SELECT 
        year,
        amount as _1800_dollar_value,
        inflation_rate as inflation_vs_previous_year
    FROM 
        source
)

SELECT 
    *
FROM
    renamed
