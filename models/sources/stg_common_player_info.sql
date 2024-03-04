with
    source as (select * from {{ source('NBA', 'COMMON_PLAYER_INFO') }}),

    renamed as (
        select
            person_id as player_id,
            first_name,
            last_name,
            display_first_last as full_name,
            display_last_comma_first,
            display_fi_last,
            player_slug,
            birthdate::date as birthdate,
            school,
            country,
            last_affiliation,
            height,
            weight,
            season_exp as seasons_played,
            jersey,
            position,
            rosterstatus as roster_status,
            games_played_current_season_flag,
            team_id,
            team_name,
            team_abbreviation,
            team_code,
            team_city,
            playercode,
            from_year as first_year_played,
            to_year as last_year_played,
            dleague_flag as g_league_has_played,
            nba_flag as nba_has_played,
            games_played_flag as games_played,
            draft_year,
            draft_round,
            draft_number,
            greatest_75_flag as greatest_75_member
        from source
    )

select *
from renamed
