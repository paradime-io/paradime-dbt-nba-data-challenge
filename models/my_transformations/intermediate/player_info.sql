with source as (
    select
    player_id
    , full_name
    , year(birthdate) as birth_year
    , country
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
    , greatest_75_member
    from {{ref('stg_common_player_info')}}
    --where last_year_played >= 2010

)

select * from source