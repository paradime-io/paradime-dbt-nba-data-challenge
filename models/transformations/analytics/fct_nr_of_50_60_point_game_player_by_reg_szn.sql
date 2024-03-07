select
    season,
    sum(
        case 
            when points >= 50
            then 1
            else 0
        end
    ) as nr_of_50_point_games,
    sum(
        case 
            when points >= 60
            then 1
            else 0
        end
    ) as nr_of_60_point_games
from {{ ref('player_advanced_stats')}}
where game_type = 'Regular Season'
--since 3pt-line was introduced
and left(season,4) >= 1979
group by 
    season