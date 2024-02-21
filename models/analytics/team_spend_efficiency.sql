WITH team_stats AS (
    SELECT 
        team_id, 
        team_name,
        AVG(games_played) as avg_games_played,
        AVG(wins) as avg_wins,
        AVG(losses) as avg_losses, 
        SUM(playoff_wins) as total_playoff_wins,
        SUM(playoff_losses) as total_playoff_losses,
        COUNT(nba_finals_appearance) as total_finals_played
    FROM {{ ref('stg_team_stats_by_season') }}
    GROUP BY team_id, team_name
),

team_spend AS (
    SELECT  
        team_id,
        AVG(team_payroll) as avg_active_spend
    FROM {{ ref('stg_team_spend_by_season')}}
    GROUP BY team_id
)

SELECT 
    team_stats.team_id,
    team_name,
    avg_games_played,
    avg_wins,
    avg_losses,
    total_playoff_wins,
    total_playoff_losses,
    total_finals_played,
    avg_active_spend
FROM team_stats
INNER JOIN team_spend ON team_stats.team_id = team_spend.team_id