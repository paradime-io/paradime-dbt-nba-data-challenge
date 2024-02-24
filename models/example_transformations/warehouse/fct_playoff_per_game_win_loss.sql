with win as (
select *
from 
{{ ref('fct_playoff_win_loss_team') }}
where winning_team is not null
),

lost as (
select *
from 
{{ ref('fct_playoff_win_loss_team') }}
where loosing_team is not null
)


select 
win.season,
win.game_id,
win.game_date,
win.playoff_match_up_unique_str,
win.team_abbreviation winning_team,
lost.team_abbreviation losing_team,
win.team_match_won winning_score,
lost.team_match_won losing_score,
ROW_NUMBER() OVER (PARTITION BY win.season, win.playoff_match_up_unique_str order by win.game_date desc) as reverse_rk
from win
join lost on win.game_id = lost.game_id
