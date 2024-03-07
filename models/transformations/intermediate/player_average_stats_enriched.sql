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
        avg(pas.field_goal_pct) as field_goal_pct,
        avg(pas.three_point_pct) as three_point_pct,
        avg(pas.free_throw_pct) as free_throw_pct,
        avg(pas.offensive_rebounds) as offensive_rebounds,
        avg(pas.defensive_rebounds) as defensive_rebounds,
        avg(pas.total_rebounds) as total_rebounds,
        avg(pas.assists) as assists,
        avg(pas.turnovers) as turnovers,
        avg(pas.steals) as steals,
        avg(pas.blocks) as blocks,
        avg(pas.points) as points,
        avg(pas.effective_field_goal_percentage) as effective_field_goal_percentage,
        avg(pas.true_shooting_percentage) as true_shooting_percentage,
        avg(pas.rebound_percentage) as rebound_percentage,
        avg(pas.steal_percentage) as steal_percentage,
        avg(pas.block_percentage) as block_percentage,
        avg(pas.per) as per
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