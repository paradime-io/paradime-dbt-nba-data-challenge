    SELECT 
        team_stats.team_id
      , team_stats.team_name
      , team_stats.season
      , team_stats.games_played
      , team_stats.wins
      , LAG(wins,1) OVER (ORDER BY team_stats.team_id, team_stats.season) AS previous_year_wins
      , team_stats.losses
      , DIV0NULL(team_stats.wins, team_stats.games_played) AS winning_percentage
      , LAG(winning_percentage,1) OVER (ORDER BY team_stats.team_id, team_stats.season) AS previous_year_winning_percentage
      , team_stats.conference_rank
      , team_stats.division_rank
      , team_stats.playoff_wins
      , team_stats.playoff_losses
      , CASE WHEN team_stats.playoff_wins + team_stats.playoff_losses > 0 THEN TRUE
             ELSE FALSE
        END AS had_playoff_appearance
      , CASE WHEN team_stats.nba_finals_appearance = 'FINALS APPEARANCE' OR team_stats.nba_finals_appearance = 'LEAGUE CHAMPION' THEN TRUE
             ELSE FALSE
        END AS had_finals_appearance
      , CASE WHEN team_stats.nba_finals_appearance = 'LEAGUE CHAMPION' THEN TRUE 
             ELSE FALSE
        END AS was_league_champion
      , CASE WHEN was_league_champion = TRUE THEN 'League champion'
             WHEN had_finals_appearance = TRUE THEN 'Finals appearance'
             WHEN had_playoff_appearance = TRUE THEN 'Playoff appearance'
             ELSE 'Did not make playoffs' 
        END AS playoff_result
      , team_stats.field_goals_made
      , team_stats.field_goals_attempted
      , DIV0NULL(team_stats.field_goals_made, team_stats.field_goals_attempted) AS field_goal_percentage
      , team_stats.three_pointers_made
      , team_stats.three_pointers_attempted
      , DIV0NULL(team_stats.three_pointers_made, team_stats.three_pointers_attempted) AS three_pointer_percentage
      , team_stats.free_throws_made
      , team_stats.free_throws_attempted
      , DIV0NULL(team_stats.free_throws_made, team_stats.free_throws_attempted) AS free_throw_percentage
      , team_stats.offensive_rebounds
      , team_stats.defensive_rebounds
      , team_stats.total_rebounds
      , team_stats.assists
      , team_stats.personal_fouls
      , team_stats.steals
      , team_stats.turnovers
      , team_stats.blocks
      , team_stats.points
      , team_spend.team_payroll + team_spend.luxury_tax_bill AS total_amount_spent
      , LAG(total_amount_spent,1) OVER (ORDER BY team_stats.team_id, team_stats.season) AS previous_year_total_amount_spent
      , team_spend.team_payroll
      , team_spend.active_payroll
      , team_spend.dead_payroll
      , team_spend.luxury_tax_payroll
      , team_spend.luxury_tax_space
      , team_spend.luxury_tax_bill
    FROM 
        -- Reference to the source data table containing team stats and spend by season
        {{ ref('stg_team_stats_by_season') }} AS team_stats        
        LEFT JOIN  {{ ref('stg_team_spend_by_season') }} AS team_spend ON team_spend.team_id = team_stats.team_id
                                                                      AND team_spend.season = team_stats.season
    GROUP BY  team_stats.team_id
            , team_stats.team_name
            , team_stats.season
            , team_stats.games_played
            , team_stats.wins
            , team_stats.losses
            , winning_percentage
            , team_stats.conference_rank
            , team_stats.division_rank
            , team_stats.playoff_wins
            , team_stats.playoff_losses
            , had_playoff_appearance
            , had_finals_appearance
            , was_league_champion
            , team_stats.field_goals_made
            , team_stats.field_goals_attempted
            , field_goal_percentage
            , team_stats.three_pointers_made
            , team_stats.three_pointers_attempted
            , three_pointer_percentage
            , team_stats.free_throws_made
            , team_stats.free_throws_attempted
            , free_throw_percentage
            , team_stats.offensive_rebounds
            , team_stats.defensive_rebounds
            , team_stats.total_rebounds
            , team_stats.assists
            , team_stats.personal_fouls
            , team_stats.steals
            , team_stats.turnovers
            , team_stats.blocks
            , team_stats.points
            , total_amount_spent
            , team_spend.team_payroll
            , team_spend.active_payroll
            , team_spend.dead_payroll
            , team_spend.luxury_tax_payroll
            , team_spend.luxury_tax_space
            , team_spend.luxury_tax_bill