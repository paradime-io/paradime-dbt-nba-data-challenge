SELECT
    player_id,
    season,
    SUM(points) AS total_points,
    SUM(field_goals_attempted) AS total_field_goals_attempted,
    SUM(assists) AS total_assists,
    SUM(total_rebounds) AS total_rebounds,
    SUM(steals) AS total_steals,
    SUM(blocks) AS total_blocks,
    AVG(plus_minus) AS average_plus_minus,
    COUNT(game_id) AS games_played
FROM
    {{ ref('stg_player_game_logs') }}
GROUP BY
    player_id,
    season
