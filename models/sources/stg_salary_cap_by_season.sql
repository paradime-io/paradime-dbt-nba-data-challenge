WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('CAHUGHES95', 'SALARY_CAP_BY_SEASON') }}
)

SELECT 
    *
FROM
    source