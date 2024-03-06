with source as (
    select 
    * 
    , CAST(SUBSTRING(season, 1, 4) AS INTEGER) AS year

    from {{ref('stg_team_stats_by_season')}}

)

select * from source
where year >= 2005 and year < 2023