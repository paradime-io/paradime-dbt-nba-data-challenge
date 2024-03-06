with source as (
    select
    a.team_id
    , a.full_name as team_name
    , a.season
    , CAST(SUBSTRING(a.season, 1, 4) AS INTEGER) AS year
    , a.team_payroll as total_team_payroll
    , a.active_payroll
    , a.dead_payroll
    , a.luxury_tax_payroll
    , a.luxury_tax_space
    , a.luxury_tax_bill
    , b.cap_maximum as team_payroll_cap
    from {{ref('stg_team_spend_by_season')}} a
    left join {{ref('stg_salary_cap_by_season')}} b on a.season = b.season

)

select * from source
where year >= 2005