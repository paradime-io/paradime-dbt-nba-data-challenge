WITH final AS (
SELECT game_id,
    team_id,
    game_date,
    matchup,
    game_duration_mins,
    game_type,
    wl
FROM {{ ref('stg_games') }}
),

team_details AS (
SELECT game_id,
    game_date,
    CASE WHEN matchup LIKE '%@%' THEN SPLIT_PART(matchup,'@',1) ELSE NULL END as away_team_name,
    CASE WHEN matchup LIKE '%@%' THEN SPLIT_PART(matchup,'@',2) ELSE NULL END as home_team_name,
    CASE WHEN wl='W' THEN team_id ELSE NULL END AS winning_team_id,
    CASE WHEN wl='L' THEN team_id ELSE NULL END AS losing_team_id
FROM final
)

SELECT *
FROM team_details
