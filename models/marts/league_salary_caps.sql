with caps as (
    select *
    from {{ref('stg_league_salary_caps')}}
)

, inflation as (
    select
        year
        , avg_inflation_since_year
    from {{ref('inflation')}} 
)

select *
, salary_cap * power((1 + inflation.avg_inflation_since_year),(2023 - caps.season_start_year)) as inflation_adjusted_salary_cap

from caps
left join inflation
on caps.season_start_year = inflation.year
