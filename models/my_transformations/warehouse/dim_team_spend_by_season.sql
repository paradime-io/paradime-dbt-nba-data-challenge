with source as (
    select
    team_id
    , team_name
    , season
    , total_team_payroll
    , active_payroll
    , dead_payroll
    , luxury_tax_payroll
    , luxury_tax_space
    , luxury_tax_bill
    , team_payroll_cap
    , case when luxury_tax_bill > 0 then 'Y' else 'N' end as paid_luxury_tax
    , dense_rank() over (partition by season order by total_team_payroll desc) as payroll_ranking
    from {{ref('team_spend_by_season')}}

)

select * from source