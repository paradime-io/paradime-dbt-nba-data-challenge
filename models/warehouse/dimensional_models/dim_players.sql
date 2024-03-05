with
    common_info as (select * from {{ ref('stg_common_player_info') }}),
    bmi as (select * from {{ ref('player_bmi') }})

select
    player_id,
    first_name,
    last_name,
    full_name,
    display_last_comma_first,
    display_fi_last,
    player_slug,
    birthdate,
    school,
    country,
    last_affiliation,
    bmi.height,
    bmi.weight,
    bmi.height_inches,
    bmi.bmi,
    bmi.bmi_category,
    seasons_played,
    jersey,
    position,
    roster_status,
    games_played_current_season_flag,
    playercode,
    first_year_played,
    last_year_played,
    g_league_has_played,
    nba_has_played,
    draft_year,
    draft_round,
    draft_number,
    greatest_75_member
from common_info
inner join bmi using (player_id)
