WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('CAHUGHES95', 'PREDICTED_SALARIES') }}
)

select * from source