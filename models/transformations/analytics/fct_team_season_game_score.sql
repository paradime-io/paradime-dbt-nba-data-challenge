select
    r.team_id,
    r.team_name,
    r.season,
    s.wins,
    s.losses,
    s.wins/s.games_played        as winning_percentage,
    -- find average consistency (normalized game score) for all players on a team
    avg(g.normalized_game_score) as avg_consistency
from {{ ref('fct_season_reg_season_game_score') }} g
join {{ ref('stg_team_roster') }} r
    on g.player_id = r.player_id and g.season = r.season
join {{ ref('stg_team_stats_by_season') }} s
    on r.team_id = s.team_id and r.season = s.season
where g.normalized_game_score > 0 and g.games_played > 40
group by all
