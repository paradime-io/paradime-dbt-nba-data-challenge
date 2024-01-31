-- Define a Common Table Expression (CTE) to select player game log details
WITH source AS (
    -- Selecting specific columns from the player game logs aggregated example table
    SELECT 
        player_id,       -- Unique identifier for each player
        player_name,     -- Name of the player
        season,          -- NBA season
        total_points,    -- Total Points scored by the player
        avg_points,      -- Average Points scored by the player
        game_type        -- Type of the game (e.g., "Regular Season", "Playoffs")
    FROM
        {{ ref('player_game_logs_agg_example') }} -- Reference to the aggregated player game logs table
),

-- Define a second CTE to select players with the most points per regular season
most_points_per_regular_season as (
    SELECT
        player_id,
        -- Concatenate player name with season, extracting the last two digits of the season start year
        -- and removing any spaces, then wrapping the season in parentheses
        CONCAT(player_name, ' (', REPLACE(SUBSTRING(season, 3, 6), ' ', ''), ')') AS player_season,
        total_points,
        avg_points
    FROM 
        source
    WHERE
        game_type = 'Regular Season' -- Filter the data to include only regular season games
)

SELECT 
    *
FROM 
    most_points_per_regular_season
ORDER BY 
    total_points DESC
