with source as (
    select
    player_id
    , full_name
    , year(birthdate) as birth_year
    , country
    , height
    , weight
    , seasons_played
    , position
    , team_id
    , team_name
    , first_year_played
    , last_year_played
    , draft_year
    , draft_round
    , draft_number
    from {{ref('stg_common_player_info')}}
    --where last_year_played >= 2010

)

select * from source