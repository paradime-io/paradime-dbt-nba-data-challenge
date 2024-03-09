WITH team_stats_by_player_by_season AS (
    SELECT
    a.team_name, 
    a.year, 
    a.wins, 
    a.losses, 
    a.pf as team_fouls,
    a.fg3a as team_three_pointers_attempted,
    f.dead_payroll, 
    f.luxury_tax_bill,
    CASE WHEN a.nba_finals_appearance = 'N/A' AND a.po_wins + a.po_losses = 0 THEN 'No Playoffs'
         WHEN a.nba_finals_appearance = 'N/A' AND a.po_wins + a.po_losses > 0 THEN 'Playoff Contender' 
         WHEN a.nba_finals_appearance = 'FINALS APPEARANCE' THEN 'Finals Appearance'
         WHEN a.nba_finals_appearance = 'LEAGUE CHAMPION' THEN 'League Champion'
         END AS season_outcome,
    b.player_name, 
    CAST(REPLACE(TRIM(d.salary,'$'), ',') AS int) AS salary,
    b.height_inches, 
    b.draft_year, 
    CASE WHEN b.draft_number = 'Undrafted' OR b.draft_number IS NULL THEN c.max_draft_number+1 ELSE b.draft_number::int END AS draft_number_normalized, 
    b.experience, 
    b.games_played, 
    b.minutes_per_game, 
    b.points_per_game, 
    b.points_per_minute, 
    b.average_plus_minus,
    CASE WHEN e.average_plus_minus_rank IS NOT NULL THEN TRUE ELSE FALSE END AS plus_minus_top_ten_rank,
    ROW_NUMBER() OVER (PARTITION BY a.team_name, a.year ORDER BY b.minutes_per_game DESC) AS minutes_per_game_rank
    FROM {{ source('NBA', 'TEAM_STATS_BY_SEASON') }} a 
    LEFT JOIN {{ ref('player_stats_by_season') }} b ON a.team_name = b.team_name AND a.year = b.season
    LEFT JOIN {{ ref('undrafted_normalization') }} c ON b.draft_year = c.draft_year_updated
    LEFT JOIN {{ source('NBA', 'PLAYER_SALARIES_BY_SEASON') }} d ON b.player_id = d.player_id and b.season = d.season
    LEFT JOIN {{ ref('plus_minus_top_ten_by_year') }} e ON b.player_id = e.player_id and b.season = e.season
    LEFT JOIN {{ source('NBA', 'TEAM_SPEND_BY_SEASON') }} f ON a.team_name = f.full_name AND a.year = f.year
    WHERE a.year != '2023-24'
    ORDER BY a.year DESC, a.wins DESC, a.team_name, b.minutes_per_game DESC 
) 
SELECT * 
FROM team_stats_by_player_by_season 
WHERE minutes_per_game_rank <= 5
ORDER BY year DESC, wins DESC, team_name, minutes_per_game DESC 