   SELECT 
        season
      , SUM(field_goals_made) AS field_goals_made
      , SUM(field_goals_attempted) AS field_goals_attempted
      , AVG(field_goals_made / field_goals_attempted) AS avg_field_goal_percentage
      , SUM(three_pointers_made) AS three_point_made
      , SUM(three_pointers_attempted) AS three_point_attempted
      , AVG(three_pointers_made / three_pointers_attempted) AS avg_three_pointer_percentage
      , SUM(free_throws_made) AS free_throws_made
      , SUM(free_throws_attempted) AS free_throws_attempted
      , AVG(free_throws_made / free_throws_attempted) AS avg_free_throw_percentage
      , SUM(offensive_rebounds) AS offensive_rebounds
      , SUM(defensive_rebounds) AS defensive_rebounds
      , SUM(total_rebounds) AS total_rebounds
      , SUM(assists) AS assists
      , SUM(personal_fouls) AS personal_fouls
      , SUM(steals) AS steals
      , SUM(turnovers) AS turnovers
      , SUM(blocks) AS blocks
      , SUM(points) AS points
      , SUM(team_payroll + luxury_tax_bill) AS total_amount_spent
      , SUM(team_payroll) AS team_payroll
      , SUM(luxury_tax_bill) AS luxury_tax_bill
    FROM 
        -- Reference to the source data table containing team stats and spend by season
        {{ ref('teams_by_season') }} AS teams_by_season
    GROUP BY ALL