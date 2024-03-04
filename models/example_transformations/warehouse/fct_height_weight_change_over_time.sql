with reformat as (

select first_year_played, position, (split_part(height, '-', 1)*12 + split_part(height, '-', 2)) as height_inch, weight
from {{ ref('stg_common_player_info') }})

, final as (

select first_year_played, position, min(height_inch) as min_height, max(height_inch) as max_height, min(weight) as min_weight, max(weight) as max_weight, stddev(height_inch) as height_dev, stddev(weight) as weight_dev 
from reformat
where position is not null
group by position, first_year_played
order by first_year_played asc
)

select * from final;