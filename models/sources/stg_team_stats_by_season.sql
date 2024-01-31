WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('NBA', 'TEAM_STATS_BY_SEASON') }}
),
renamed AS (
    SELECT 
        team_id,
        team_city,
        team_name,
        year AS season,
        gp AS games_played,
        wins,
        losses,
        conf_rank AS conference_rank,
        div_rank AS division_rank,
        po_wins AS playoff_wins,
        po_losses AS playoff_losses,
        nba_finals_appearance,
        fgm AS field_goals_made,
        fga AS field_goals_attempted,
        fg3m AS three_pointers_made,
        fg3a AS three_pointers_attempted,
        ftm AS free_throws_made,
        fta AS free_throws_attempted,
        oreb AS offensive_rebounds,
        dreb AS defensive_rebounds,
        reb AS total_rebounds,
        ast AS assists,
        pf AS personal_fouls,
        stl AS steals,
        tov AS turnovers,
        blk AS blocks,
        pts AS points
    FROM
        source
)

SELECT 
    *
FROM
    renamed