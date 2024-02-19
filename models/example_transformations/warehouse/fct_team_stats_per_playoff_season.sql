-- Define a Common Table Expression (CTE) to select team game log details
WITH source AS (
    -- Selecting specific columns from the team game logs aggregated example table
    SELECT 
        team_id,       -- Unique identifier for each team
        team_name,     -- Name of the team
        season,          -- NBA season
        win_counter,     -- Number of wins
        loss_counter,    -- Number of losses
        total_points,    -- Total Points scored by the team
        avg_points,      -- Average Points scored by the team
        total_assists,    -- 
        avg_assists,      -- 
        total_rebounds,    -- 
        avg_rebounds,      -- 
        total_steals,    -- 
        avg_steals,      --
        total_blocks,   
        avg_blocks,      
        assist_to_turnover_ratio,
        game_type        -- Type of the game (e.g., "Regular Season", "Playoffs")
    FROM
        {{ ref('team_game_logs_agg') }} -- Reference to the aggregated team game logs table
),

-- Define a second CTE to select teams with the most points per regular season
most_wins_per_regular_season as (
    SELECT
        team_id,
        -- Concatenate team name with season, extracting the last two digits of the season start year
        -- and removing any spaces, then wrapping the season in parentheses
        CONCAT(team_name, ' (', REPLACE(SUBSTRING(season, 3, 6), ' ', ''), ')') AS player_season,
        win_counter, 
        total_points,
        avg_points
    FROM 
        source
    WHERE
        game_type = 'Playoffs' -- Filter the data to include only regular season games
),

salary_data AS (
    -- Selecting specific columns from the stg_team_spend_by_season for salary info
    SELECT 
        team_id,
        season,
        team_payroll,
        active_payroll,
        dead_payroll,
        luxury_tax_bill
    FROM
        {{ ref('stg_team_spend_by_season') }} -- Reference to the team spend table
)

SELECT 
    *
FROM 
    most_wins_per_regular_season wins
LEFT JOIN salary_data salary
    ON wins.team_id = salary.team_id AND wins.season = salary.season
ORDER BY 
    win_counter DESC
