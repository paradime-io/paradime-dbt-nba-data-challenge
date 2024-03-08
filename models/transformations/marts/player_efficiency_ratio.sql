
with stg_player_games as (
    select * from {{ ref('stg_player_game_logs') }}
),

player_school as (
    select
        player_id,
        school,
        greatest_75_member
    from {{ ref('stg_common_player_info') }}
),

player_stats as (
    SELECT 
        stg_player_games.player_id,
        player_name,
        school,
        greatest_75_member,
        --  game_id,
        count(*) as total_games,
        sum(points) AS total_points,
        sum(total_rebounds) AS total_rebounds,
        sum(assists) AS assists,
        sum(steals) AS steals,
        sum(blocks) AS blocks,
        sum(field_goals_attempted) AS field_goals_attempted,
        sum(field_goals_made) AS field_goals_made,
        sum(free_throws_attempted) AS free_throws_attempted,
        sum(free_throws_made) AS free_throws_made,
        sum(turnovers) AS turnovers,
        sum(mins_played) as mins_played,
        div0(total_points, total_games) as points_per_game,

        -- Formula taken from our good friend, Mr. GPT
        -- Unfortunately it doesn't seem to be giving the expected results when checking with the actuals.
        (
            div0(SUM(points), SUM(field_goals_attempted)) * 85.910 +
            div0(SUM(steals), SUM(mins_played)) * 53.897 +
            (CASE WHEN MAX(season) >= '1979-80' THEN div0(SUM(three_point_made), SUM(field_goals_attempted)) * 51.757 ELSE 0 END) +
            div0(SUM(free_throws_made), SUM(free_throws_attempted)) * 46.845 +
            div0(SUM(blocks), SUM(mins_played)) * 39.190 +
            div0((CASE WHEN MAX(season) >= '1973-74' THEN (SUM(defensive_rebounds) + (0.3 * SUM(total_rebounds))) ELSE SUM(total_rebounds) END), SUM(mins_played)) * 14.707 +
            div0(SUM(assists), SUM(mins_played)) * 34.677 -
            div0(SUM(personal_fouls), SUM(mins_played)) * 17.174 -
            (CASE WHEN MAX(season) >= '1977-78' THEN (div0(SUM(turnovers), (SUM(field_goals_attempted) + 0.44 * SUM(free_throws_attempted) + SUM(turnovers))) * 53.897) ELSE 0 END)
        ) AS player_efficiency_ratio,

        (
            div0(SUM(points), SUM(field_goals_attempted)) * 85.910 +
            div0(SUM(steals), SUM(mins_played)) * 53.897 +
            (CASE WHEN MAX(season) >= '1979-80' THEN div0(SUM(three_point_made), SUM(mins_played)) * 51.757 ELSE 0 END) +
            div0(SUM(free_throws_made), SUM(free_throws_attempted)) * 46.845 +
            div0(SUM(blocks), SUM(mins_played)) * 39.190 +
            div0((CASE WHEN MAX(season) >= '1973-74' THEN (SUM(defensive_rebounds) + SUM(offensive_rebounds)) ELSE SUM(total_rebounds) END), SUM(mins_played)) * 14.707 +
            div0(SUM(assists), SUM(mins_played)) * 34.677 -
            div0(SUM(personal_fouls), SUM(mins_played)) * 17.174 -
            (CASE WHEN MAX(season) >= '1977-78' THEN div0(SUM(turnovers), SUM(mins_played)) * 53.897 ELSE 0 END)
        ) as player_efficiency_ratio_2
    FROM stg_player_games
    left join player_school
        on stg_player_games.player_id = player_school.player_id
    GROUP BY 1, 2, 3, 4
)

SELECT * FROM player_stats
