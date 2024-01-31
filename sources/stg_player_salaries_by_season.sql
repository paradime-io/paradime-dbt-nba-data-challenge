WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('NBA', 'PLAYER_SALARIES_BY_SEASON') }}
),


renamed AS (
    SELECT
        player_id,
        player_name,
        salary, 
        rank,
        season
    FROM
        source
)
SELECT
    *
FROM
    renamed