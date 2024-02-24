with match_up_array_details as (
select 
* ,
case when matchup 
like '%@%' then array_sort(split(matchup, ' @ ')) 
else array_sort(split(matchup, ' vs. '))  end as match_up_array

FROM
{{ ref('stg_games') }}
where lower(game_type) like '%playoff%'
)

select
* ,
ARRAY_TO_STRING(match_up_array, ',') as playoff_match_up_unique_str
from 
match_up_array_details