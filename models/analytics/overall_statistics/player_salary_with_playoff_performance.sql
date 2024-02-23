WITH player_playoff_performance AS (
    SELECT * FROM {{ ref ('fct_player_points_per_playoff_season_example')}} 
),

historic_salaries AS (
    SELECT 
        player_id,
        player_name,
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

player_playoff_performance_clean AS (
    SELECT 
        player_id,
        SUBSTRING(player_season, 1, CHARINDEX(' (', player_season) - 1) AS player_name,
        AVG(avg_points) as avg_points,
        SUM(total_points) as total_points
    FROM player_playoff_performance
    GROUP BY player_id, player_name
)


SELECT 
    h.player_id,
    h.player_name,
    h.avg_salary,
    h.avg_salary_rank,
    p.avg_points,
    p.total_points
FROM historic_salaries_clean h
INNER JOIN player_playoff_performance_clean p 
    ON h.player_id = p.player_id