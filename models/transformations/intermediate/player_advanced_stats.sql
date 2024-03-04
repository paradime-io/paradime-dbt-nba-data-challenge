with player_game_logs as (
    select 
        player_id,
        player_name,
        team_id,
        game_id,
        game_date,
        matchup,
        win_loss,
        mins_played,
        field_goals_made as field_goals_made,
        field_goals_attempted as field_goals_attempted,
        round(div0(field_goals_made, field_goals_attempted), 2) as field_goal_pct,
        three_point_made as three_point_made,
        three_point_attempted as three_point_attempted,
        round(div0(three_point_made, three_point_attempted), 2) as three_point_pct,
        free_throws_made as free_throws_made,
        free_throws_attempted as free_throws_attempted,
        round(div0(free_throws_made , free_throws_attempted), 2) as free_throw_pct,
        offensive_rebounds,
        defensive_rebounds,
        offensive_rebounds + defensive_rebounds as total_rebounds,
        assists,
        turnovers,
        steals,
        blocks,
        personal_fouls,
        points,
        plus_minus,
        season,
        game_type,
        36*div0(points,mins_played) as points_36_mins,
        36*div0(assists,mins_played) as assists_36_mins,
        36*div0(total_rebounds,mins_played) as total_rebounds_36_mins,
        36*div0(steals,mins_played) as steals_36_mins,
        36*div0(blocks,mins_played) as blocks_36_mins
    from {{ ref('stg_player_game_logs') }}
),
player_game_logs_joined as (
    select 
        pgl.*,
        tas.game_duration_mins as team_minutes_played,
        tas.total_rebounds as team_total_rebounds,
        tas.opponent_defensive_rebounds,
        tas.opponent_offensive_rebounds,
        tas.opponent_defensive_rebounds + tas.opponent_offensive_rebounds as opponent_total_rebound,
        tas.opponent_possessions,
        tas.opponent_field_goals_attempted,
        tas.opponent_three_point_attempted
    from player_game_logs as pgl
    left join intermediate.team_advanced_stats as tas
    on pgl.game_id = tas.game_id
    and pgl.team_id = tas.team_id
)
select 
    *,
    round(DIV0(field_goals_made + 0.5 * three_point_made, field_goals_attempted), 2) as effective_field_goal_percentage,
    round(div0(0.5 * points, field_goals_attempted + 0.44 * free_throws_attempted), 2) as true_shooting_percentage,
    --Total Rebound Percentage=100*(Total Rebounds*(Team Minutes Played/5))/(Minutes Played*(Team Total Rebounds + Opponent Team’s Total Rebounds))
    round(div0(100 * (offensive_rebounds + defensive_rebounds) * (team_minutes_played / 5), (mins_played * (team_total_rebounds + opponent_total_rebound))),2) as rebound_percentage,
    --Steal Percentage=100*(Steals*(Team Minuted Played/5))/(Minuted Played*Opponent’s Possessions)
    round(div0(100 * steals * (team_minutes_played / 5), mins_played * opponent_possessions), 2) as steal_percentage,
    --BLK% - Block Percentage: 100 * (BLK * (Tm MP / 5)) / (MP * (Opp FGA - Opp 3PA))
    round(div0(100 * blocks * (team_minutes_played / 5), mins_played * (opponent_field_goals_attempted - opponent_three_point_attempted)),2) as block_percentage,
    --simplified PER
    round(div0((field_goals_made * 85.91 + steals * 53.897 + three_point_made * 46.845 + blocks * 39.190 + offensive_rebounds * 39.19 + assists * 34.677 + defensive_rebounds * 14.707 + personal_fouls * 17.174 + (free_throws_attempted - free_throws_made) * 20.091 + (field_goals_attempted - field_goals_made) * 39.190 + turnovers * 53.897) , mins_played), 2) as PER
from player_game_logs_joined