with teams_stats_by_season as (
    select *
    from {{ref('stg_team_stats_by_season')}}
)

select 
    md5(season || team_id) as team_season_id,
    team_id,
    team_city,
    team_name,
    season,
    games_played,
    wins,
    losses,
    conference_rank,
    division_rank,
    playoff_wins,
    playoff_losses,
    nba_finals_appearance,
    field_goals_made,
    field_goals_attempted,
    three_pointers_made,
    three_pointers_attempted,
    free_throws_made,
    free_throws_attempted,
    offensive_rebounds,
    defensive_rebounds,
    total_rebounds,
    assists,
    personal_fouls,
    steals,
    turnovers,
    blocks,
    points,
    case 
        when nba_finals_appearance = 'LEAGUE CHAMPION' then TRUE 
        else FALSE 
    end is_championship_winning_season,
    case when nba_finals_appearance = 'FINALS APPEARANCE' then TRUE 
        else FALSE 
    end is_finals_appearance_season
from teams_stats_by_season