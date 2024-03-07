with player_stats as (
    select 
        pas.player_id,
        pas.player_name,
        case 
            when left(cpi.position, 6) = 'Center'
            then 'Center'
            when left(cpi.position, 7) = 'Forward'
            then 'Forward'
            when left(cpi.position, 5) = 'Guard'
            then 'Guard'
            else cpi.position
        end as position,
        round(avg(pas.field_goal_pct), 3) as field_goal_pct,
        round(avg(pas.three_point_pct), 3) as three_point_pct,
        round(avg(pas.free_throw_pct), 3) as free_throw_pct,
        round(avg(pas.offensive_rebounds), 3) as offensive_rebounds,
        round(avg(pas.defensive_rebounds), 3) as defensive_rebounds,
        round(avg(pas.total_rebounds), 3) as total_rebounds,
        round(avg(pas.assists), 3) as assists,
        round(avg(pas.turnovers), 3) as turnovers,
        round(avg(pas.steals), 3) as steals,
        round(avg(pas.blocks), 3) as blocks,
        round(avg(pas.points), 3) as points,
        round(avg(pas.effective_field_goal_percentage), 3) as effective_field_goal_percentage,
        round(avg(pas.true_shooting_percentage), 3) as true_shooting_percentage,
        round(avg(pas.rebound_percentage), 3) as rebound_percentage,
        round(avg(pas.steal_percentage), 3) as steal_percentage,
        round(avg(pas.block_percentage), 3) as block_percentage,
        round(avg(pas.per), 3) as per
    from {{ ref('player_advanced_stats')}} as pas
    left join {{ ref('stg_common_player_info')}} as cpi
    on pas.player_id = cpi.player_id
    group by 
        pas.player_id,
        pas.player_name,
        case 
            when left(cpi.position, 6) = 'Center'
            then 'Center'
            when left(cpi.position, 7) = 'Forward'
            then 'Forward'
            when left(cpi.position, 5) = 'Guard'
            then 'Guard'
            else cpi.position
        end
        
)
select distinct
    ps.*,
    dc.body_fat,
    dc.hand_length_inches,
    dc.hand_width_inches,
    dc.height_wo_shoes,
    dc.height_wo_shoes_inches,
    dc.height_w_shoes,
    dc.height_w_shoes_inches,
    dc.standing_reach,
    dc.standing_reach_inches,
    dc.weight_lbs,
    dc.wingspan,
    dc.wingspan_inches,
    dc.height_wingspan_ratio
from player_stats as ps
left join staging.stg_draft_combine as dc
on replace(replace(replace(replace(lower(ps.player_name),' jr.',''),' sr.',''),'.',''),'?','\'') = replace(replace(replace(lower(dc.player),' jr.',''),' sr.',''),'.', '')