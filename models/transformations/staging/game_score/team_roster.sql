-- team rosters on a season level - so a player can show up on multiple rosters as long as they appeared in at least one game
select distinct
    teams.team_id,
    teams.full_name as team_name,
    l.season,
    l.player_id,
    l.player_name
from {{ ref('stg_teams') }} teams
join {{ ref('stg_player_game_logs') }} l
    on teams.team_id = l.team_id