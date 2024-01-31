WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('NBA', 'GAMES') }}
),


renamed AS (
    SELECT 
        season_id,
        team_id,
        team_abbreviation,
        team_name,
        game_id,
        game_date,
        matchup,
        wl,
        min AS game_duration_mins,
        pts AS points,
        fgm AS field_goals_made,
        fga AS field_goals_attempted,
        fg_pct AS field_goal_pct,
        fg3m AS three_point_made,
        fg3a AS three_point_attempted,
        fg3_pct AS three_point_pct,
        ftm AS free_throws_made,
        fta AS free_throws_attempted,
        ft_pct AS free_throw_pct,
        oreb AS offensive_rebounds,
        dreb AS defensive_rebounds,
        reb AS total_rebounds,
        ast AS assists,
        stl AS steals,
        blk AS blocks,
        tov AS turnovers,
        pf AS personal_fouls,
        plus_minus,
        season,
        game_type
    FROM 
        source
)

SELECT 
    *
FROM
    renamed
