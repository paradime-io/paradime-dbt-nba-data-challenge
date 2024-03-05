with final as (select count(player_id) as num_player_debuts, country, first_year_played
from {{ ref('stg_common_player_info') }}
group by country, first_year_played
order by first_year_played asc)
--the above CTE counts the number of players from each country who made their NBA debut in a given year
select * from final;