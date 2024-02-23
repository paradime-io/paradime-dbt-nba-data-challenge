-- Aggregate league spending by season
WITH league_spend_by_season_agg as (
    SELECT
        season,
        SUM(team_payroll) AS league_payroll,
        SUM(active_payroll) AS active_payroll,
        SUM(dead_payroll) AS dead_payroll,
        SUM(luxury_tax_payroll) AS luxury_tax_payroll,
        SUM(luxury_tax_bill) AS luxury_tax_bill
    FROM
        {{ ref('stg_team_spend_by_season') }}
    GROUP BY
        season
    ORDER BY
        season
)

-- Select all aggregated league spending by season
SELECT
    *
FROM league_spend_by_season_agg
