    SELECT 
        team_spend.team_id
      , team_spend.team_name
      , team_spend.season
      , team_stats.games_played
      , team_stats.wins
      , team_stats.losses
      , team_stats.wins / team_stats.games_played AS winning_percentage
      , team_stats.conference_rank
      , team_stats.division_rank
      , team_stats.playoff_wins
      , team_stats.playoff_losses
      , CASE WHEN team_stats.playoff_wins + team_stats.playoff_losses > 0 THEN TRUE
             ELSE FALSE
        END AS had_playoff_appearance
      , CASE WHEN team_stats.nba_finals_appearance = 'FINALS APPEARANCE' THEN TRUE 
             ELSE FALSE
        END AS had_finals_appearance
      , CASE WHEN team_stats.nba_finals_appearance = 'LEAGUE CHAMPION' THEN TRUE 
             ELSE FALSE
        END AS was_league_champion
      , team_stats.field_goals_made
      , team_stats.field_goals_attempted
      , team_stats.field_goals_made / team_stats.field_goals_attempted AS field_goal_percentage
      , team_stats.three_pointers_made
      , team_stats.three_pointers_attempted
      , team_stats.three_pointers_made / team_stats.three_pointers_attempted AS three_pointer_percentage
      , team_stats.free_throws_made
      , team_stats.free_throws_attempted
      , team_stats.free_throws_made / team_stats.free_throws_attempted AS free_throw_percentage
      , team_stats.offensive_rebounds
      , team_stats.defensive_rebounds
      , team_stats.total_rebounds
      , team_stats.assists
      , team_stats.personal_fouls
      , team_stats.steals
      , team_stats.turnovers
      , team_stats.blocks
      , team_stats.points
      , team_spend.team_payroll
      , team_spend.active_payroll
      , team_spend.dead_payroll
      , team_spend.luxury_tax_payroll
      , team_spend.luxury_tax_space
      , team_spend.luxury_tax_bill
    FROM 
        -- Reference to the source data table containing team stats and spend by season
        {{ ref('stg_team_spend_by_season') }} AS team_spend
        LEFT JOIN {{ ref('stg_team_stats_by_season') }} AS team_stats ON team_spend.team_id = team_stats.team_id
                                                                      AND team_spend.season = team_stats.season
    GROUP BY ALL