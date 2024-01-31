WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('NBA', 'COMMON_PLAYER_INFO') }}
),

renamed AS (
    SELECT 
        person_id AS player_id,
        first_name,
        last_name,
        display_first_last AS full_name,
        display_last_comma_first,
        display_fi_last,
        player_slug,
        birthdate,
        school,
        country,
        last_affiliation,
        height,
        weight,
        season_exp AS seasons_played,
        jersey,
        position,
        rosterstatus AS roster_status,
        games_played_current_season_flag,
        team_id,
        team_name,
        team_abbreviation,
        team_code,
        team_city,
        playercode,
        from_year AS first_year_played,
        to_year AS last_year_played,
        dleague_flag AS g_league_has_played,
        nba_flag AS nba_has_played,
        games_played_flag AS games_played,
        draft_year,
        draft_round,
        draft_number,
        greatest_75_flag AS greatest_75_member
    FROM 
        source
)

SELECT 
    *
FROM
    renamed