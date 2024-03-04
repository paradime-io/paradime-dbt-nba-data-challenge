WITH info AS (SELECT * FROM {{ref('int_player_common_info')}}),
info_by_season AS (SELECT * FROM {{ref('int_player_common_info_by_season')}}),
stats_by_season AS (SELECT * FROM {{ref('int_player_stats_by_season')}}),

joined AS (
    SELECT
        info_by_season.player_id,
        info_by_season.season,
        info_by_season.age,
        info_by_season.nba_tenure,
        info_by_season.is_rookie_year,
        info_by_season.is_last_year,
        info_by_season.salary,

        stats_by_season.* EXCLUDE(season,player_id),

        info.full_name,
        info.birthdate,
        info.school,
        info.last_affiliation_before_nba,
        info.height_in_cm,
        info.weight,
        info.position,
        info.draft_year,
        info.draft_round,
        info.draft_number,
        info.draft_segment,
        info.first_year_played,
        info.last_year_played,
        info.g_league_has_played,
        info.debut_age
    FROM
        info_by_season
    LEFT JOIN
        stats_by_season ON info_by_season.player_id=stats_by_season.player_id AND info_by_season.season=stats_by_season.season
    LEFT JOIN
        info ON info_by_season.player_id=info.player_id)

SELECT * FROM joined
