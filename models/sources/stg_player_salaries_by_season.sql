WITH source AS (
    SELECT *
    FROM
        {{ source('NBA', 'PLAYER_SALARIES_BY_SEASON') }}
),


renamed AS (
    SELECT
        player_id,
        player_name,
        rank,
        season,
        CAST(REPLACE(REPLACE(salary, '$', ''), ',', '') AS INT) AS salary_usd
    FROM
        source
)

SELECT *
FROM
    renamed
