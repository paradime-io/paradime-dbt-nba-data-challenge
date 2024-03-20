select
    player_id,
    season,
    sum(points) as total_points,
    sum(assists) as total_assists,
    sum(total_rebounds) as total_rebounds
from {{ ref('stg_player_game_logs') }}
group by player_id, season
