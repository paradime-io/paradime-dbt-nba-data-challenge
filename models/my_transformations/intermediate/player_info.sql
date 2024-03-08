with source as (
    select
    player_id
    , full_name
    , year(birthdate) as birth_year
    , country
    , height
    , CAST(SUBSTRING(height, 1, 1) AS INTEGER) AS height_ft
    , CAST(SUBSTRING(height, 3, 1) AS INTEGER) AS height_in
    , weight
    , seasons_played
    , roster_status
    , position
    , team_id
    , first_year_played
    , last_year_played
    , draft_year
    , draft_round
    , draft_number
    , CASE WHEN draft_year = 'Undrafted' OR draft_round = 'Undrafted' OR draft_number = 'Undrafted'
            THEN 'Undrafted' ELSE 'Drafted' END AS draft_status_flag
    , greatest_75_member
    from {{ref('stg_common_player_info')}}
    --where last_year_played >= 2010

)

, final as (
    select
    player_id
    , full_name
    , birth_year
    , country
    , height
    , height_ft
    , height_in
    , weight
    , seasons_played
    , roster_status
    , position
    , team_id
    , first_year_played
    , last_year_played
    , CASE WHEN draft_year = 'Undrafted' THEN NULL ELSE CAST(draft_year AS INTEGER) END AS draft_year
    , CASE WHEN draft_round = 'Undrafted' THEN NULL ELSE CAST(draft_round AS INTEGER) END AS draft_round
    , CASE WHEN draft_number = 'Undrafted' THEN NULL ELSE CAST(draft_number AS INTEGER) END AS draft_number
    , draft_status_flag
    , greatest_75_member
    from source

)

select * from final