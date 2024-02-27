{{ config(materialized='table')}}

WITH main_teams AS (
SELECT 
    team_id,
    full_name as team_name,
    team_name_abbreviation as team_abbreviation,
    city,
    state,
    year_founded
FROM {{ ref('stg_teams') }}
),

game_teams AS (
SELECT  
    team_id,
    team_name,
    team_abbreviation
FROM {{ ref('stg_games') }}
GROUP BY 1,2,3
),

final AS (
SELECT team_id,
    team_name,
    team_abbreviation
FROM main_teams 
UNION
SELECT *
FROM game_teams
)

SELECT final.*,
    m.city,
    m.state,
    m.year_founded
FROM final
LEFT JOIN main_teams m ON m.team_id=final.team_id
ORDER BY team_abbreviation