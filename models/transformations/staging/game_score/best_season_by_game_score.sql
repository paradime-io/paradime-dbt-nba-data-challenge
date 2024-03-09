select 
    player_id,
    player_name,
    season,
    avg_game_score as highest_game_score,
    RANK() OVER (PARTITION BY player_id ORDER BY avg_game_score DESC) as rnk
from {{ ref('fct_season_all_game_score') }}
qualify rnk = 1