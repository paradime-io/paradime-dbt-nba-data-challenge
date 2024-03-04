SELECT 
    team_name,
    team_payroll,
    luxury_tax_payroll + luxury_tax_space AS salary_cap
FROM 
    {{ ref('stg_team_spend_by_season') }}
WHERE
    season = '2022-23'