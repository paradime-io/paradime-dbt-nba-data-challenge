-- helper model for viz purposes only
select 
    common.player_id,
    common.full_name as player_name,
    common.position,
    CASE
        when common.first_year_played between 1980 and 1990 then '1980s'
        when common.first_year_played between 1990 and 2000 then '1990s'
        when common.first_year_played between 1990 and 2000 then '1990s'
        when common.first_year_played between 2000 and 2010 then '2000s'
        when common.first_year_played between 2010 and 2020 then '2010s'
        else '2020s'
    end as first_year_decade,
    avg(three_point_attempted) as avg_three_point_attempts,
    avg(three_point_made) as avg_three_point_makes
from {{ ref('stg_common_player_info') }} common
join {{ ref('stg_player_game_logs') }} stats
    on common.player_id = stats.player_id
where common.position in ('Forward-Center', 'Center-Forward', 'Center')
and common.first_year_played >= 1980
group by all