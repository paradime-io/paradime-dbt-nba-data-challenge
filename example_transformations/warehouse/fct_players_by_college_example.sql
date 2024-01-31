-- The initial Common Table Expression (CTE) aggregates player game logs. It identifies players who have played more than 0 minutes, essentially filtering out players who have no playing time recorded.
WITH players_by_college AS (
    SELECT 
        school,
        count(*) as player_count
    FROM 
        {{ ref('stg_common_player_info') }}
    WHERE
        school is not null -- This ensures that only rows with a non-null school are included
    GROUP BY
        school
    ORDER BY
        player_count DESC -- This orders the results by the number of players, from highest to lowest
)

SELECT 
    *
FROM 
    players_by_college
