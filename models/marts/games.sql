with games as (
select *
from {{ref('stg_games')}}
)

select
SEASON_ID
, TEAM_ID
, TEAM_ABBREVIATION
, TEAM_NAME
, GAME_ID
, team_abbreviation||'-'||game_date as team_game_date
, GAME_DATE
--, MATCHUP
, right(matchup, 3)  as opponent
--, WL
, case when WL = 'W' then TRUE
    else FALSE
end as team_is_winner
, case when GAME_DURATION_MINS < 240 then null
    else GAME_DURATION_MINS 
end as game_time_minutes
, POINTS
, FIELD_GOALS_MADE
, FIELD_GOALS_ATTEMPTED
--, FIELD_GOAL_PCT
, THREE_POINT_MADE
, THREE_POINT_ATTEMPTED
--, THREE_POINT_PCT
, FREE_THROWS_MADE
, FREE_THROWS_ATTEMPTED
--, FREE_THROW_PCT
, OFFENSIVE_REBOUNDS
, DEFENSIVE_REBOUNDS
, TOTAL_REBOUNDS
, ASSISTS
, STEALS
, BLOCKS
, TURNOVERS
, PERSONAL_FOULS
, PLUS_MINUS
, SEASON
, GAME_TYPE

from games