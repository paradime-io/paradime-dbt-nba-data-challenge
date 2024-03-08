with salaries_by_season as(
    select *
    from {{ref('stg_player_salaries_by_season')}}
)

, salary_cap as(
    select *
    from {{ref('stg_league_salary_caps')}}
)

, inflation as (
    select
        year
        , avg_inflation_since_year
    from {{ref('inflation')}} 
)

, cap as (
    select *
    from {{ref('stg_league_salary_caps')}}
)


select 
    salaries_by_season.*
    -- quick and dirty 
    -- future_value = present_value * (1 + avg_inflation_rate) ^ number_of_years
    , salary * power((1 + inflation.avg_inflation_since_year),(2023 - salaries_by_season.season_start_year)) as inflation_adjusted_salary
    , 1.0 * salary / salary_cap as percentage_of_salary_cap
from salaries_by_season
left join inflation
on salaries_by_season.season_start_year = inflation.year
left join salary_cap
on salaries_by_season.season_start_year = salary_cap.season_start_year
