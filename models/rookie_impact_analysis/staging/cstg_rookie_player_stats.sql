WITH rookie_seasons AS (
    SELECT
        player_id,
        MIN(season) AS rookie_season
    FROM
        {{ ref('stg_player_game_logs') }}
    GROUP BY
        player_id
)

SELECT
    p.player_id,
    p.first_name,
    p.last_name,
    p.birthdate,
    p.country,
    p.school,
    p.draft_year,
    p.draft_round,
    p.draft_number,
    p.height,
    p.weight,
    p.position,
    r.rookie_season,
    g.game_id,
    g.game_date,
    g.matchup,
    g.win_loss,
    g.mins_played,
    g.field_goals_made,
    g.field_goals_attempted,
    g.three_point_made,
    g.three_point_attempted,
    g.free_throws_made,
    g.free_throws_attempted,
    g.offensive_rebounds,
    g.defensive_rebounds,
    g.total_rebounds,
    g.assists,
    g.steals,
    g.blocks,
    g.turnovers,
    g.personal_fouls,
    g.points,
    g.plus_minus
FROM
    {{ ref('stg_common_player_info') }} p
INNER JOIN
    rookie_seasons r ON p.player_id = r.player_id
LEFT JOIN
    {{ ref('stg_player_game_logs') }} g ON p.player_id = g.player_id AND g.season = r.rookie_season
