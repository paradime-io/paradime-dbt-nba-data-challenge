with games as (
select *
from {{ref('stg_games')}}
)

select *
, team_abbreviation||'-'||game_date as team_game_date
from games