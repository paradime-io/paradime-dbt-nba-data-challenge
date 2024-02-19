with source as (
    select
    player_id
    , player_name
    , season
    , salary as salary_original 
    , salary_inflation_adj as salary_adjusted_for_inflation
    , salary_inflation_and_cap_adj as salary_adjusted_for_inflation_and_cap
    from {{ref('player_salaries_by_season_adj')}}
)

select * from source