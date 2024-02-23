WITH historic_salaries AS (
    SELECT 
        player_id,
        player_name,
        season,
        CAST(REPLACE(REPLACE(salary, '$', ''), ',', '') AS INT) AS salary,
        rank
    FROM 
        {{ ref('stg_player_salaries_by_season')}}
),

historic_salaries_clean AS (
    SELECT 
        player_id,
        player_name,
        AVG(salary) AS avg_salary,
        AVG(rank) AS avg_salary_rank
    FROM historic_salaries
    GROUP BY player_id, player_name
),

player_game_log AS (
    SELECT  
        player_id,
        player_name,    
        COUNT(CASE WHEN win_loss = 'W' THEN 1 END) AS win_count,
        COUNT(CASE WHEN win_loss = 'L' THEN 1 END) AS loss_count,
        AVG(mins_played) AS avg_mins_played,
        AVG(CASE WHEN field_goals_attempted > 0 THEN (field_goals_made / field_goals_attempted) * 100 END) AS avg_field_goal_percentage,
        AVG(CASE WHEN three_point_attempted > 0 THEN (three_point_made / three_point_attempted) * 100 END) AS avg_three_point_percentage,
        AVG(CASE WHEN free_throws_attempted > 0 THEN (free_throws_made / free_throws_attempted) * 100 END) AS avg_free_throw_percentage,
        COUNT(total_rebounds) as total_rebounds,
        COUNT(assists) as total_assists,
        COUNT(turnovers) as total_turnovers,
        COUNT(steals) as total_steals,
        COUNT(blocks) as total_blocks,
        COUNT(personal_fouls) as total_personal_fouls,
        AVG(points) as avg_points
    FROM {{ ref('stg_player_game_logs')}}
    GROUP BY player_id, player_name
)

SELECT 
    h.player_id,
    h.player_name,
    h.avg_salary,
    h.avg_salary_rank,
    p.win_count,
    p.loss_count,
    p.avg_mins_played,
    p.avg_field_goal_percentage,
    p.avg_three_point_percentage,
    p.avg_free_throw_percentage,
    p.total_rebounds,
    p.total_assists,
    p.total_turnovers,
    p.total_steals,
    p.total_blocks,
    p.total_personal_fouls,
    p.avg_points
FROM historic_salaries_clean h
INNER JOIN player_game_log p 
    ON h.player_id = p.player_id