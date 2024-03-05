with info as (select * from {{ ref('stg_teams') }})

select team_id, full_name, team_name_abbreviation, nickname, city, state, year_founded
from info
