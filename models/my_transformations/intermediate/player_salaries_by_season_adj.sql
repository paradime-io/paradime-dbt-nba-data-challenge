with cur_cpi as (
    select avg_annual_cpi as current_cpi
    from {{ref('stg_inflation_data')}} 
    where year = 2023

)

, cur_salary_cap as (
    select cap_maximum as current_sal_cap
    from {{ref('stg_salary_cap_by_season')}} 
    where season = '2022-23'
)

, historical_cpi as (
    Select
    a.year
    , a.season_format as season
    , a.avg_annual_cpi as historical_cpi
    , o.current_cpi
    from {{ref('stg_inflation_data')}} a, cur_cpi o
)

, historical_sal_cap as (
    Select
    a.season
    , a.cap_maximum as historical_sal_cap
    , s.current_sal_cap
    from {{ref('stg_salary_cap_by_season')}} a, cur_salary_cap s
)

, player_sal_adj as (
    select
    sal.player_id
    , sal.player_name
    , sal.season
    , CAST(REPLACE(REPLACE(sal.salary, '$', ''), ',', '') AS INT) AS converted_salary
    from {{ref('stg_player_salaries_by_season')}} sal

)

, inflation_adjustment as (
    select
    sal.player_id
    , sal.player_name
    , sal.season
    , sal.converted_salary as salary 
    , CAST((sal.converted_salary * (hc.current_cpi/hc.historical_cpi)) AS INT) as salary_inflation_adj

    from player_sal_adj sal
    join historical_cpi hc on hc.season = sal.season
)

, salary_cap_adjustment as (
    select
    ia.player_id
    , ia.player_name
    , ia.season
    , ia.salary 
    , ia.salary_inflation_adj
    , CAST(((ia.salary_inflation_adj /hs.historical_sal_cap)*hs.current_sal_cap) AS INT) as salary_inflation_and_cap_adj
    from inflation_adjustment ia
    join historical_sal_cap hs on hs.season = ia.season
)

select * from salary_cap_adjustment