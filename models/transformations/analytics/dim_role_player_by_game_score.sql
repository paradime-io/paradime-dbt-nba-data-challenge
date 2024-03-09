select
    i.*
from {{ ref('fct_career_all_game_score') }} c
join {{ ref('stg_common_player_info') }} i
    on c.player_id = i.player_id
join {{ ref('stg_best_season_by_game_score') }} s
    on c.player_id = s.player_id
-- have to play at least 200 games to qualify
where c.games_played >= 200
    -- best season ever has to be less than 18
    and s.highest_game_score < 18 
    -- average game score for career between 8 and 15
    and c.avg_game_score between 8 and 15