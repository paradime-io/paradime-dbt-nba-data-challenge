select 
    player_id,
    full_name as player_name,
    CASE
        when common.first_year_played between 1970 and 1980 then '1970s'
        when common.first_year_played between 1980 and 1990 then '1980s'
        when common.first_year_played between 1990 and 2000 then '1990s'
        when common.first_year_played between 2000 and 2010 then '2000s'
        when common.first_year_played between 2010 and 2020 then '2010s'
        else '2020s'
    end as first_year_decade
from {{ ref('stg_common_player_info') }} common