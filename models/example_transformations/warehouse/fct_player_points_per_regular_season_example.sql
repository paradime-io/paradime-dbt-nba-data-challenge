-- Define a Common Table Expression (CTE) to select player game log details
with
    source as (
        -- Selecting specific columns from the player game logs aggregated example table
        select
            player_id,  -- Unique identifier for each player
            player_name,  -- Name of the player
            season,  -- NBA season
            total_points,  -- Total Points scored by the player
            avg_points,  -- Average Points scored by the player
            game_type  -- Type of the game (e.g., "Regular Season", "Playoffs")
        from {{ ref('player_game_logs_agg_example') }}  -- Reference to the aggregated player game logs table
    ),

    -- Define a second CTE to select players with the most points per regular season
    most_points_per_regular_season as (
        select
            player_id,
            -- Concatenate player name with season, extracting the last two digits of
            -- the season start year
            -- and removing any spaces, then wrapping the season in parentheses
            concat(
                player_name, ' (', replace(substring(season, 3, 6), ' ', ''), ')'
            ) as player_season,
            total_points,
            avg_points
        from source
        where game_type = 'Regular Season'  -- Filter the data to include only regular season games
    )

select *
from most_points_per_regular_season
order by total_points desc
