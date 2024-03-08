with source as (
    select
    team_id,
    full_name as team_name,
    team_name_abbreviation,
    nickname,
    city,
    state,
    year_founded
    from {{ref('stg_teams')}}

)

select * from source