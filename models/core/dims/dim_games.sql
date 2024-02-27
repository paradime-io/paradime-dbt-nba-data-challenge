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
    game_duration_mins,
    game_type,
    CASE WHEN matchup LIKE '%@%' THEN REPLACE(SPLIT_PART(matchup,'@',1),' ','') ELSE NULL END as away_team_name,
    CASE WHEN matchup LIKE '%@%' THEN REPLACE(SPLIT_PART(matchup,'@',2),' ','') ELSE NULL END as home_team_name,
    CASE WHEN wl='W' THEN team_id ELSE NULL END AS winning_team_id,
    CASE WHEN wl='L' THEN team_id ELSE NULL END AS losing_team_id
FROM final
),

team_id_details AS (
SELECT game_id,
    game_date,
    game_type,
    game_duration_mins,
    t1.team_id as away_team_id,
    t2.team_id as home_team_id,
    winning_team_id,
    losing_team_id
FROM team_details
LEFT JOIN {{ ref('dim_teams')}} t1 ON t1.team_abbreviation=team_details.away_team_name
LEFT JOIN {{ ref('dim_teams')}} t2 ON t2.team_abbreviation=team_details.home_team_name
)

SELECT game_id,
    game_date,
    game_type,
    MAX(game_duration_mins) as game_duration,
    MAX(away_team_id) as away_team_id,
    MAX(home_team_id) as home_team_id,
    MAX(winning_team_id) as winning_team_id,
    MAX(losing_team_id) as losing_team_id
FROM team_id_details
GROUP BY 1,2,3
ORDER BY 1
