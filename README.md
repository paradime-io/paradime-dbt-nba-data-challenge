# dbt™ Data Modeling Challenge - NBA Edition

## Table of Contents

1. [Introduction](#introduction)
2. [Data Sources](#data-sources)
3. [Methodology](#methodology)
   - [Tools Used](#tools-used)
   - [Applied Techniques](#applied-techniques)
4. [Visualizations](#visualizations)
   - [Historical context of NBA offense](#historical-context-of-nba-offense)
     - [Points per game by Season](#points-per-game-by-season)
     - [Pace per game by Season](#pace-per-game-by-season)
     - [Offensive Efficiency per game by Season](#offensive-efficiency-per-game-by-season)
     - [Three point attempts and Three point percentage by Season](#three-point-attempts-and-three-point-percentage-by-season)
     - [Three point attempts by Position and Season](#three-point-attempts-by-position-and-season)
     - [All-time teams in Points per game](#all-time-teams-in-points-per-game)
     - [All-time teams in Offensive Efficiency](#all-time-teams-in-offensive-efficiency)
     - [Number of players with 25+ point per games by Season](#number-of-players-with-25-point-per-games-by-season)
     - [Number of players with 8+ three point attempts by Season](#number-of-players-with-8-three-point-attempts-by-season)
     - [Number of 50+/60+ point games by Season](#number-of-5060-point-games-by-season)
   - [Historical context of NBA Defense](#historical-context-of-nba-defense)
     - [Steals and Blocks per Game by Season](#steals-and-blocks-per-game-by-season)
     - [Steal and Block percentage by Season](#steal-and-block-percentage-by-season)
     - [All-time team ranking in defensive efficiency](#all-time-team-ranking-in-defensive-efficiency)
   - [Defensive and Offensive stats in League Champions](#defensive-and-offensive-stats-in-league-champions)
     - [Number of champs at top1/top3/top5 in stats](#number-of-champs-at-top1top3top5-in-stats)
     - [Number of champs at top1/top3/top5 in scoring](#number-of-champs-at-top1top3top5-in-scoring)
     - [Number of champs at top1/top3/top5 in offensive and defensive efficiency](#number-of-champs-at-top1top3top5-in-offensive-and-defensive-efficiency)
     - [Number of champs at top1/top3/top5 in effective fieldgoal percentage and true shooting percentage](#number-of-champs-at-top1top3top5-in-effective-fieldgoal-percentage-and-true-shooting-percentage)
   - [Age of freaks and unicorns?](#age-of-freaks-and-unicorns)
     - [Points and assists per game by percentile](#points-and-assists-per-game-by-percentile)
     - [Three point and Effective Fieldgoal percentage by percentile](#three-point-and-effective-fieldgoal-percentage-by-percentile)
     - [Total rebounds and rebound percentage by percentile](#total-rebounds-and-rebound-percentage-by-percentile)
     - [Steals and Blocks by percentile](#steals-and-blocks-by-percentile)
     - [Steal and Block percentage by percentile](#steal-and-block-percentage-by-percentile)
5. [Conclusions](#conclusions)

## Introduction
Explore my project for the _dbt™ data modeling challenge - NBA Edition_, Hosted by [Paradime](https://www.paradime.io/)! This project dives into the analysis and visualization of NBA statistics, designed for basketball enthusiasts and analysts. My analysis focuses mostly on the historical context of how offense and defense has changed in the NBA. I was making an attempt to find a connection between offensive/defensive performance and championships and finally was looking for a correlation between physical parameters and performance. 

### [My GitHub repo](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/tree/nba-istvan-mozes-90-gmail-com)

## Data Sources
My analysis leverages five key NBA datasets from Paradime and one seed file from an external source (NBA.com):
- *stg_games*
- *stg_player_game_logs*
- *stg_team_stats_by_season*
- *stg_teams*
- *stg_common_player_info*
- *NBA_DRAFT_COMBINE_2000_2023_CLEANED.csv*

## Methodology
### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, dbt™.
- **[Snowflake](https://www.snowflake.com/)** for data storage and computing.
- **[Sigma](https://app.sigmacomputing.com/paradime-io-nba/workbook/team_stats_by_season-404NCzYBYv9r9Hg7cZHbas)** for data visualization.

### Applied Techniques
- SQL and dbt™ to create _player_advanced_stats_ and _team_advanced_stats_ by transforming _stg_player_game_logs_ and _stg_games_, enriching the box score statistics by calculating advanced statistical metrics, such as _possessions_, _pace_, _offensive_efficiency_, _defensive_efficiency_, offensive_rebound_percentage_, defensive_rebound_percentage_, _free_throw_rate_,  _effective_field_goal_percentage_, _true_shooting_percentage_, _rebound_percentage_, _steal_percentage_, _block_percentage_ and _PER_. To calculate advanced metrics I used the formulas found on [this page](https://www.nbastuffer.com/analytics-101/). 
- SQL and dbt™ to create _stg_draft_combine_ by transforming _NBA_DRAFT_COMBINE_2000_2023_CLEANED.csv_ seed file. I got this data from www.nba.com.
- SQL and dbt™ to transform _team_advanced_stats_ and create _fct_aggregated_metrics_by_reg_szn_ to understand how metrics have changed over time.
- SQL and dbt™ to transform _player_advanced_stats_ and _stg_common_player_info_ to create _fct_aggregated_metrics_by_reg_szn_position_ to see how metrics have changed over time by player position.
- SQL and dbt™ to transform _player_advanced_stats_, stg_common_player_info_ and _stg_draft_combine_ to create _player_average_stats_enriched_ to understand player level statistics, enriched with the players physical parameters such as _height_ and _wingspan_.
- SQL and dbt™ to transform _player_average_stats_enriched_ to understand the connection between game performance and the _height_wingspan_ratio_.
- SQL and dbt™ to transform _player_advanced_stats_ for insights on number of players by season with outstanding individual performances in _fct_nr_of_25_plus_ppg_player_by_reg_szn_ , _fct_nr_of_50_60_point_game_player_by_reg_szn_ and _fct_nr_of_8_plus_3pa_player_by_reg_szn_.
- SQL and dbt™ to transform _player_advanced_stats_ , _stg_teams_ and _team_advanced_stats_ to generate _fct_nr_of_champs_leading_stats_ to see how many championship teams were leading or in top3/top5 in that season in certain statistics.
- SQL and dbt™ to transform _team_advanced_stats_ to see all time ranking in offensive and defensive efficiency on a team level in _fct_team_defensive_efficiency_all_time_reg_szn_ and _fct_team_defensive_efficiency_all_time_reg_szn_ and all time point per game in _fct_team_ppg_all_time_reg_szn_.


## Visualizations

### Historical context of NBA offense
There's a lot off buzz recently that the NBA offense has broken, there is no defense anymore, every other game sets a new record for scoring or individual players score 50-60-70 points. I wanted to find out if it can be statistically proven or it is maybe just recency bias.

#### Points per game by Season
Average points scored per season.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/fcce9c0b-3bb8-45ae-bde8-e935d803c71a)

*Insights:* 
We can certainly see an upward trend in the past 25 years and this year is close to the all-time high but it has been higher in the beginning of the 60s. 

#### Pace per game by Season
Average pace per season. Pace is the total number of possessions a team uses in a game.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/d5a7e8c6-753d-46ac-a9c7-4c4e2ee9462f)

*Insights:* 
We can see a similar trend in pace too, it had a decline in the end of the 80s but since it has been increasing.

#### Offensive Efficiency per game by Season
Average offensive efficiency per season. Offensive efficiency is the number of points a team scores per 100 possessions.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/d0f4814e-2c3e-4db8-a31f-8398fa4c2869)

*Insights:* 
In the offensive efficiency however,  we can definitely see an increase since the 1985-86 season (Based on the data provided, I couldn't sufficiently calculate the offensive efficiency before the 85-86 season). Within this window this year's offensive efficiency is the all-time high. 

#### Three point attempts and Three point percentage by Season
Average number of three pointers a team attempts on a game and percentage of how many is made per season.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/9f23598a-6fdf-491c-8405-9a837429f976)

*Insights:* 
Increasing points and offensive efficiency can be directly connected to three point shooting. Since Mike D'Anthony we know that three point shooting is is more effective than two point shooting, so players started to attempt more and more threes, that's what we can see on this chart too. About 30 years ago there was under 10 three point attempts per game, whereas in recent years it is around 36 attempts per game. In the meantime we can see that three point percentage hasn't changed significantly, the league average was always between 33 and 36%, so it is not a surprise to see an increase in points and offensive efficiency.

#### Three point attempts by Position and Season
Average number of three pointers a team attempts in a season split by positions. Positions were consolidated into three cathegories: guard, forward, center.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/02e160e7-0338-43f1-8cae-25ea1e4ba043)

*Insights:* 
For the full context of three point shooting, we need to examine the different positions too. We can see here that every position has increased the 3 point attempts, however, forwards and especially centers did it in a bigger proportion. 40 years ago, in the 1983-84 season guards on average attempted 0.43 three pointers per game, in 2023-24 this number is 4.22 which is 9.81 times higher. Forwards in 83-84 attempted 0.14 threes, in 23-24 it was 3.07 attempts which is 21.93 times higher. Centers though, attempted 0.03 three pointers in the 83-84 season, whereas now it is 1.22 which is a 40.67-time increase.

#### All-time teams in Points per game 
This visualisation displays the highest scoring teams per season all-time. 

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/c7fea1d5-a518-4eeb-9298-4ac4151abf23)

*Insights:* 
In the top 20 teams, 11 is from the past 5 years, 7 is from 2023-24 and in the top 3, 2 is from the 2023-24 season. 

#### All-time teams in Offensive Efficiency
Best teams in offensive efficiency per season all-time.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/d2549957-0e5a-4441-8192-1fe149a56e98)

*Insights:* 
If we check out the same but with offensive efficiency, we see that all top 20 teams are from the past 4 seasons, the top 6 offensive efficiency all-time is from the 2023-24 season.

#### Number of players with 25+ point per games by Season
Displays the number of players who has an average of 25 or more points per season.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/337eb686-8634-4124-b7ed-2d1dfb27f162)

*Insights:* 
If we dive even a bit deeper in individual performance we can see the number of players with an average of 25 points or higher is also dominating in the past few years. The 5 most are the last 5 years.

#### Number of players with 8+ three point attempts by Season
Shows the number of players who attempts 8 or more three pointers on average per season.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/49bcef22-1828-4576-9b71-0a734ec4e4a2)

*Insights:* 
Similarly the number of players with an average of 8 or more three point attempts per season shows that 2023-24 season is leading the way with 18 players, and the top 9 places are all seasons after 2015.

#### Number of 50+/60+ point games by Season
Number of times a player has scored 50 or more and 60 or more in a season.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/c2e40bb7-9c0f-4fee-8b1d-77237eb0bc97)

*Insights:*
After all these it is not a surprise to see an increase of the number of outstanding individual performances. The number of 50+ point games by a player was 25 last season and the 2023-24 season is on the 9th place with 13 of them. However, if we see the number of 60+ point games, 2023-24 is again leading the way with 5, which is mind-boggling considering the fact that we have only half season of that for this season.

### Historical context of NBA Defense
I'd like to mention as a disclaimer that defense is much harder to measure relevantly than offense, especially with box-score statistics. With modern technologies like motion-tracking there are much more advanced techniques to generate defensive statistics. I took a chance, nonetheless.

#### Steals and Blocks per Game by Season
The first and simplest defensive statistical cathegories an nba fan would meet are steal and block. The following graph shows the average steals and blocks per game per season.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/1c2ce08e-fc54-4f2e-bb1d-cbce900ac7b1)

*Insights:*
We can see a slight decline in both stats over time. In blocks it is not too significant, in steals this decline is a bit bigger, however I feel these stats are not representing the defensive effort very well.

#### Steal and Block percentage by Season
Steal and block percentage are bit better stats than simple steals and blocks because they are adjusted for pace and volume.
Steal Percentage is the percentage of estimated opponent possessions that end with a steal by the player while the player is on the court.
Block percentage is an estimate of the percentage of opponent two-point field goal attempts blocked by the player while he was on the floor.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/bb9b3de9-5fe2-4085-adc7-a4c5a79454d1)

*Insights:*
In steal percentage we can see a slight decrease, however, in block percentage we can see an increase over time. 

#### All-time team ranking in defensive efficiency
This displays the teams with the worst defensive efficiencies all-time

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/5b5ecf1d-1f08-4450-8eef-a0b75aa8d6b0)

*Insights:* 
What we can see here is that 11 teams of the 20 worst defensive efficiencies all-time are from the 2023-24 season, 5 is from the 2022-23 season, and the rest is also from the past 5 years. This is not big surprise though, after we saw the leading offensive efficiencies are also from 2023-24 season as these two stats are strongly related.

### Defensive and Offensive stats in League Champions
People say good offense wins games but good defense wins championships. In this one I tried to find a connection between good defense and league champions. I examined the 76 champions in nba history. The way I analysed them was to see how many of them was on top 1, top 3, top 5 in certain statistics in that season.

#### Number of champs at top1/top3/top5 in stats

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/815c6b09-cd1e-459a-afec-0c288a7235f7)

#### Number of champs at top1/top3/top5 in scoring

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/115d2e40-59d9-4e0e-9f1d-7e800809ac15)

#### Number of champs at top1/top3/top5 in offensive and defensive efficiency

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/1ab2e1ef-faa4-4539-9dee-59b7cd0a8999)

#### Number of champs at top1/top3/top5 in effective fieldgoal percentage and true shooting percentage
Effective Field Goal Percentage, aka eFG%, is a player or team evaluation metric that measures the effectiveness of 2-point shots and 3-point shots.
True shooting percentage, aka TS%, is a metric that factors a player’s or a team’s performance at the free-throw line and considers the efficiency of all types of shots.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/b42679d1-f746-4e63-a3f9-3be0771a0dfe)


*Insights:* 
In the table and the related visuals we can see that out of 76 teams 0 has ever led the league in scoring, 6 was in top 3 and 11 in top 5 in scoring. Only 1 team has led the league in true shooting percentage, however 32 led in effective field goal percentage. Comparing offensive and defensive efficiency gives a bit more interesting insight: it shows that only 30 champions have led the league in offensive efficiency while 43 has led in defensive efficiency. If we see top3 and top5 we only see slight increase in this number for offensive efficiency with 34 and 36, respectively, whereas in defensive efficiency 54 champs were in top 3 and 61 out of 76 were in top 5 in defensive efficiency. Not on seperate visuals but also we can see in the table that 37 and 41 teams were in top 5 in steal percentage and block percentage respectively. 

### Age of freaks and unicorns? 
In recent time number players with outstanding physical parameters seemed to grow. AD, Porzingis, Kawai or Wemby, all of them exceptional talents in the game of basketball. Higher than average height was always connected to basketball and considered am advantage. But is there a connection, does it really help or maybe is it a handicap for a successful NBA carreer? 
For this analysis I used an extra dataset for players between 2000 and 2023 (1000+ players). It provides physical measurements like body fat rate, height, standing reach, or wingspan. I only examined wingspan for the analysis, more specifically the height-wingspan ratio. I split the dataset into 5 percentile based on this value and was trying to find connection between offensive and defensive stats and this ratio. The first percentile means players with lower height-wingspan ratio (longer arms) and fifth percentile means higher ratio (shorter arms).

#### Points and assists per game by percentile

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/4ea14d5d-ba8e-486d-a803-533aca365eb0)

*Insights:*
For points there is no clear trend, although the highest value is in the fifth percentile. In assists there is a trend where the higher the ratio or shorter the arm, the higher the score. 

#### Three point and Effective Fieldgoal percentage by percentile

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/121484f5-46bb-41a3-91aa-f2e7f382799b)

*Insights:* 
Definitely shows a trend in three point percentage towards the fifth percentile. Effective fieldgoal percentage shows no significant difference

#### Total rebounds and rebound percentage by percentile
Total rebound percentage is estimated percentage of available rebounds grabbed by the player while the player is on the court.

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/4ca3892e-9a38-4d5b-9b71-cc59463fb77f)

*Insights:* 
It clearly shows for both stats that lower arms defeinitely help in rebounding.

#### Steals and Blocks by percentile

![image](https://github.com/moses90/paradime-dbt-nba-data-challenge/assets/23437333/231b072c-e993-4742-b30d-533715243f48)

*Insights:* 
Blocks definitely shows a trend in favor of the lower ratio, longer arms. Interestingly though, in steals the two highest values are in the first and the fifth percentile. Apparently if you have the longest or the shortest arms both will help you succeed in stealing the ball.

#### Steal and Block percentage by percentile

![image](https://github.com/moses90/nba-challange/assets/23437333/0f82a2f4-0eb9-4dca-9906-3290fede359f)

*Insights:* 
Looking at the steal and block percentage we can see a trend for both towards the first percentile. For block percentage it is relatively stronger though, than for steals. 


## Conclusions
This project successfully extracts significant insights from NBA data that NBA fans would find interesting, such as: 

- The game of NBA is really in a change or evolution as it has always been. Teams are finding the key to efficient basketball, which is essetially three point shooting and spacing. The fact that nowadays not only guards shoot well above the three point line but forwards and centers too is setting a big challange for defenders.
- Players are becoming much more skilled and not only a couple of them are now above the league, there are a whole bunch of talented star players who can be real scoring machines.
- Defensive findigs are not specifically conclusive regarding the hostorical changes.
- There is a connection between championships and good defense, however, it would definitely require deeper analysis.
- Physical parameters are not one to learn unfortunately, but it can play a huge role in success, but it's not everything. There are trends in defensive statistics and wingspan, however it would also need deeper analysis to further prove this hypothesis.  
