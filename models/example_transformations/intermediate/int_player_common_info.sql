WITH info AS (SELECT * FROM {{ref('stg_common_player_info')}}),

player_metadata AS (
    SELECT
        player_id,
        full_name,
        birthdate,
        school,
        last_affiliation AS last_affiliation_before_nba,
        {{convert_inch_to_cm('height')}} AS height_in_cm,
        weight,
        position,
        draft_year,
        draft_round,
        draft_number,
        {{draft_segmentation('draft_number','draft_round')}} draft_segment,
        first_year_played,
        last_year_played,
        g_league_has_played,
        first_year_played-YEAR(birthdate) AS debut_age
    FROM
        info)
    
SELECT * FROM player_metadata