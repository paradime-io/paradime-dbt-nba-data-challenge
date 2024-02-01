WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('NBA', 'GAMES') }}
)

SELECT 
    * 
SELECT 
    source