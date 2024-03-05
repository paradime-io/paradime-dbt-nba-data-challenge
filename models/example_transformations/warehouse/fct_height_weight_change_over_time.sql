with reformat as (

select first_year_played, position, (split_part(height, '-', 1)*12 + split_part(height, '-', 2)) as height_inch, weight
from {{ ref('stg_common_player_info') }})
--the above CTE reformats player heights from feet and inches to inches in order to more easily produce a data viz
, final as (

select first_year_played, position, min(height_inch) as min_height, max(height_inch) as max_height, min(weight) as min_weight, max(weight) as max_weight, stddev(height_inch) as height_SD, stddev(weight) as weight_SD 
from reformat
where position is not null
group by position, first_year_played
order by first_year_played asc
)
--the above CTE the minimum/maximum/standard deviation of height and weight per position for those players making their NBA debut in a given year
select * from final;