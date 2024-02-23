-- Aggregate league stats by season
WITH league_stats_by_season_agg as (
    SELECT
        season,
        SUM(games_played) AS games_played,
        SUM(wins) AS wins,
        SUM(losses) AS losses,
        SUM(playoff_wins) AS playoff_wins,
        SUM(playoff_losses) AS playoff_losses,
        SUM(field_goals_made) AS field_goals_made,
        NULLIF(SUM(field_goals_attempted), 0) AS field_goals_attempted,
        NULLIF(SUM(three_pointers_made), 0) AS three_pointers_made,
        NULLIF(SUM(three_pointers_attempted), 0) AS three_pointers_attempted,
        NULLIF(SUM(free_throws_made), 0) AS free_throws_made,
        SUM(free_throws_attempted) AS free_throws_attempted,
        NULLIF(SUM(offensive_rebounds), 0) AS offensive_rebounds,
        NULLIF(SUM(defensive_rebounds), 0) AS defensive_rebounds,
        NULLIF(SUM(total_rebounds), 0) AS total_rebounds,
        SUM(assists) AS assists,
        SUM(personal_fouls) AS personal_fouls,
        NULLIF(SUM(steals), 0) AS steals,
        NULLIF(SUM(turnovers), 0) AS turnovers,
        NULLIF(SUM(blocks), 0) AS blocks,
        SUM(points) AS points
    FROM
        {{ ref('stg_team_stats_by_season') }}
    GROUP BY
        season
    ORDER BY
        season
)

-- Select all aggregated league stats by season
SELECT
    *
FROM league_stats_by_season_agg
