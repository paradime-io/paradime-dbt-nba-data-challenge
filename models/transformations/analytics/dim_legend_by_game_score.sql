-- our own version of the nba top 75
select top 75
    row_number() over (order by f.avg_game_score desc) as player_rank,
    s.*
from {{ ref('fct_career_all_game_score') }} f
join {{ ref('stg_common_player_info') }} s
    on f.player_id = s.player_id
join {{ ref('stg_best_season_by_game_score') }} b
    on f.player_id = b.player_id
-- have to play at least 200 games to qualify
where f.games_played >= 200
-- have to have had an elite season, defined as over 20 avg game score
    and b.highest_game_score >= 20
order by f.avg_game_score desc
