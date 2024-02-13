   SELECT 
        team_id
      , team_name
      , season
      , had_playoff_appearance
      , had_finals_appearance
      , was_league_champion
      , conference_rank
      , division_rank
      , previous_year_wins
      , wins
      , previous_year_winning_percentage
      , winning_percentage
      , dense_rank() over (partition by season order by previous_year_winning_percentage desc) as winning_pct_rank_previous_season
      , dense_rank() over (partition by season order by winning_percentage desc) as winning_pct_rank
      , field_goals_attempted
      , dense_rank() over (partition by season order by field_goals_attempted desc) as field_goals_attempted_rank
      , field_goals_made
      , dense_rank() over (partition by season order by field_goals_made desc) as field_goals_made_rank
      , field_goal_percentage
      , dense_rank() over (partition by season order by field_goal_percentage desc) as field_goal_percentage_rank
      , three_pointer_percentage
      , dense_rank() over (partition by season order by three_pointer_percentage desc) as three_pointer_percentage_rank
      , free_throw_percentage
      , dense_rank() over (partition by season order by free_throw_percentage desc) as free_throw_percentage_rank
      , offensive_rebounds
      , dense_rank() over (partition by season order by offensive_rebounds desc) as offensive_rebounds_rank
      , defensive_rebounds
      , dense_rank() over (partition by season order by defensive_rebounds desc) as defensive_rebounds_rank
      , assists
      , dense_rank() over (partition by season order by assists desc) as assists_rank
      , steals
      , dense_rank() over (partition by season order by steals desc) as steals_rank
      , turnovers
      , dense_rank() over (partition by season order by turnovers desc) as turnovers_rank
      , blocks
      , dense_rank() over (partition by season order by blocks desc) as blocks_rank
      , points
      , dense_rank() over (partition by season order by points desc) as points_rank
      , total_amount_spent
      , dense_rank() over (partition by season order by total_amount_spent desc) as total_amount_spent_rank      
    FROM 
        -- Reference to the source data table containing team stats and spend by season
        {{ ref('teams_by_season') }} AS teams_by_season