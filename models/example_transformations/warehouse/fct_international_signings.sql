with final as (select count(player_id), country, first_year_played
from {{ ref('stg_common_player_info') }}
group by country, first_year_played
order by first_year_played asc)

select * from final;