{{ config(materialized='table') }}

select
    g.*,
    -- game score formula
    points + (.4 * field_goals_made) - (.7 * field_goals_attempted) - (.4 * (free_throws_attempted - free_throws_made)) + (.7 * offensive_rebounds) + (.3 * defensive_rebounds) + steals + (.7 * assists) + (.7 * blocks) - (.4 * personal_fouls) - turnovers as game_score
from {{ ref('stg_player_game_logs') }}  g
where game_score is not null