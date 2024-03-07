select
  player_id,
  season,
  sum(points) as total_points,
  avg(points) as average_points,
  sum(assists) as total_assists,
  avg(assists) as average_assists,
  sum(rebounds) as total_rebounds,
  avg(rebounds) as average_rebounds,
  sum(steals) as total_steals,
  avg(steals) as average_steals,
  sum(blocks) as total_blocks,
  avg(blocks) as average_blocks,
  sum(turnovers) as total_turnovers,
  avg(turnovers) as average_turnovers,
  sum(minutes_played) as total_minutes_played,
  avg(minutes_played) as average_minutes_played
from {{ ref('stg_player_game_logs') }}
group by player_id, season
