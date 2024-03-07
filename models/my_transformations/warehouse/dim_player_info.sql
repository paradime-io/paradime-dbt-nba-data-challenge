with source as (
    select * 
    from {{ref('player_info')}}

)

, ppg_count as (
    select
    p.player_id
    , sum(case when avg_points > 20 then 1 else 0 end) as star_ppg_count
    from {{ref('player_game_logs_agg')}} p
    group by 1

)

, final as (
    select
    s.*
    , case when greatest_75_member = TRUE then 'Legend'
           when star_ppg_count < 3 then 'Role Player'
           when star_ppg_count >= 3 and star_ppg_count < 6 then 'Star Player'
           when star_ppg_count >= 6 then 'Superstar'
           end as star_player_flag
    from source s
    left join ppg_count pc on pc.player_id = s.player_id

)

select * from final