with

play_by_play as (

    select * from {{ ref('fct_play_by_play') }}

),

clutch_shooting as (

    select
        player_id, 
        player_name, 
        birthdate,
        school,
        height,
        weight,
        position,
        games_played,
        greatest_75_member,
        SUM(case when is_field_goal = TRUE THEN 1 ELSE 0 END) as shot_attempts,
        SUM(case when shot_result = 'Made' THEN 1 ELSE 0 END) as shot_makes,
        ROUND(SUM(case when shot_result = 'Made' THEN 1 ELSE 0 END) / NULLIF(SUM(case when is_field_goal = TRUE THEN 1 ELSE 0 END),0)*100,0) as field_goal_pct,
        SUM(case when go_ahead_shot = TRUE THEN 1 ELSE 0 END) as go_ahead_shot,
        SUM(case when is_clutch_time = TRUE AND go_ahead_shot = TRUE THEN 1 ELSE 0 END) as clutch_go_ahead_shot,
        SUM(case when is_clutch_squared_time = TRUE and go_ahead_shot = TRUE THEN 1 ELSE 0 END) as clutch_squared_go_ahead_shot,
        SUM(case when is_game_winner = TRUE THEN 1 ELSE 0 END) as game_winner, 
        AVG(case when is_game_winner = TRUE then game_clock ELSE NULL END) as avg_seconds_remaining_game_winner,
        AVG(case when is_game_winner = TRUE then shot_distance ELSE NULL END) as avg_shot_distance_game_winner
    from play_by_play
    group by player_id, player_name, birthdate, school, height, weight, position, games_played, greatest_75_member
    having SUM(case when is_clutch_time = TRUE AND go_ahead_shot = TRUE THEN 1 ELSE 0 END) > 0

)

select * from clutch_shooting
