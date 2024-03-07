WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('NBA', 'PLAYER_SALARIES_BY_SEASON') }}
),


renamed AS (
    SELECT
        player_id
        , player_name
        , replace(replace(salary, '$', ''), ',', '')::int as salary 
        , rank
        , season
        , left(season, 4)::integer as season_start_year
    FROM
        source
)
SELECT
    *
FROM
    renamed