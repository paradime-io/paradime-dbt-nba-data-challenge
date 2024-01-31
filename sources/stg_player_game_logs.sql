WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('NBA', 'PLAYER_GAME_LOGS') }}
),


renamed AS (
    SELECT
        player_id,
        player_name,
        nickname,
        team_id,
        team_abbreviation,
        team_name,
        game_id,
        game_date,
        matchup,
        wl as win_loss,
        min AS mins_played,
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
        tov AS turnovers,
        stl AS steals,
        blk AS blocks,
        pf AS personal_fouls,
        pts AS points,
        plus_minus AS plus_minus,
        season,
        game_type
    FROM 
        source
)

SELECT
    *
FROM
    renamed
