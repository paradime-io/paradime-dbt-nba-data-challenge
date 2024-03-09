select
    mvp.season,
    game_score.player_id,
    game_score.player_name,
    mvp.player_slug,
    count(*) as games_played,
    avg(game_score) as avg_game_score,
    stddev(game_score) as stddev_game_score,
    case
        when avg_game_score = 0 THEN NULL
        else stddev_game_score / avg_game_score
    end as normalized_game_score
from {{ ref('stg_game_score') }} game_score
join {{ ref('stg_common_player_info') }} common
    on game_score.player_id = common.player_id
join {{ ref('mvp') }} mvp
    on common.player_slug = mvp.player_slug
group by all
order by mvp.season
