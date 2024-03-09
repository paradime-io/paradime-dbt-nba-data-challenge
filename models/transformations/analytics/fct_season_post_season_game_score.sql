select
    player_id,
    player_name,
    season,
    count(*) as games_played,
    avg(game_score) as avg_game_score,
    stddev(game_score) as stddev_game_score,
    case
        when avg_game_score = 0 THEN NULL
        else stddev_game_score / avg_game_score
    end as normalized_game_score
from {{ ref('stg_game_score') }}
where game_type = 'Playoffs' 
group by all