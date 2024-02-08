with player_info as (
    SELECT
        player_id,
        player_name,
        rank,
        season,
        salary_usd
    from {{ ref('stg_player_salaries_by_season') }}
),
