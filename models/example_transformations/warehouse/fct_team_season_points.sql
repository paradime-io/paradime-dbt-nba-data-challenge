with home_away as (
    SELECT
        team_abbreviation,
        team_name,
        season,
        case when  matchup like '%vs%' then 'home' ELSE 'away' END as dim_home_away,
        points
    FROM 
    {{ ref('stg_games') }}
)

SELECT
    team_abbreviation,
    team_name,
    season,
    dim_home_away,
    SUM(points) as points_scored,
    COUNT(1) as matches_played
FROM home_away
    GROUP by 1,2,3,4