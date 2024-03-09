## Table of Contents
1. [Introduction](#introduction)
2. [Data Sources](#data-sources)
3. [Methodology](#methodology)
   - [Tools Used](#tools-used)
   - [Applied Techniques](#applied-techniques)
4. [Visualizations](#visualizations)
   - [Experience among championship teams](#experience-among-championship-teams)
   - [Draft picks among championship contenders](#draft-picks-among-championship-contenders)
   - [Fouls and playoff contention](#fouls-and-playoff-contention)
   - [3-point attempts among finals contenders](#3-point-attempts-among-finals-contenders)
   - [Top 10 +/- players and playoff contention](#top-10-+/--players-and-playoff-contention)
   - [Salary among starters](#salary-among-starters)
   - [Clutch player performances in the playoffs](#clutch-player-performances-in-the-playoffs)
   - [Dead payroll among playoff contenders](#dead-payroll-among-playoff-contenders)
   - [Luxury tax bills among championship contenders](#luxury-tax-bills-among-championship-contenders)
5. [Conclusions](#conclusions)

## Introduction
This project combines five NBA tables to understand which factors lead to championship-winning teams. Nearly all insights observe seasons since 2000-01. All insights compare data between teams based on season outcome: No Playoffs, Playoff Contenders, Finals Appearance, or League Champions. 

### [My GitHub repo](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/tree/nba-atticus-gazerlabs-com)

## Data Sources
My analysis leverages five key NBA datasets from Paradime:
- *PLAYER_GAME_LOGS*
- *TEAM_STATS_BY_SEASON*
- *COMMON_PLAYER_INFO*
- *TEAM_SPEND_BY_SEASON*
- *PLAYER_SALARIES_BY_SEASON*

## Methodology
### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, dbt™.
- **[Snowflake](https://www.snowflake.com/)** for data storage and computing.
- **[Sigma](https://www.sigmacomputing.com/)** for data visualization.

### Applied Techniques
- SQL and dbt™ to transform _height_normalized_ to format player heights in inches, casted as integers.
- SQL and dbt™ to transform _player_stats_by_season_ to combine regular season point and minute averages with draft and experience metrics. 
- SQL and dbt™ to transform _plus_minus_top_ten_by_year_ to parse the top 10 players in +/- across each year.
- SQL and dbt™ to transform _team_stats_by_player_by_season_ to map _player_stats_by_season_ to parse a team's outcome in a given season e.g. playoff appearance
- SQL and dbt™ to transform _team_stats_by_player_by_season_starting_five_ to understand player metrics and team outcomes when observing a team's starting 5 players, based on minutes per game.
- SQL and dbt™ to transform _top_playoff_performances_ to understand teams with players scoring 35 points or more in playoff games.
- SQL and dbt™ to transform _undrafted_normalization_ to quantify undrafted players with draft ranks in order to calculate average draft numbers. 

## Visualizations
### Experience among championship teams
91% of the time teams that make the Finals have a higher average experience (~8 years) among their starting 5 than teams that don't make the Finals. Teams that didn't make the playoffs nearly always have less average experience (~5 years) among their starting 5 than teams that do make the playoffs. 

<img width="1101" alt="Screenshot 2024-03-08 at 10 44 02 PM" src="https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/16438456/1ff07f48-2ba8-4122-ac12-d96d86d20499">

*Experience = years in league;  *
*Starting 5 = players with highest minutes-per-game average across regular season*


### Draft picks among championship contenders
Several championship contenders had undrafted or later draft picks in their starting 5. While early draft picks may lead to talented prospects, recent evidence shows these picks may not lead championship runs.  

<img width="1103" alt="Screenshot 2024-03-08 at 10 55 01 PM" src="https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/16438456/b4d0a912-cb4b-4c9b-8895-ef1192baf240">

*Undrafted players = Add +1 to highest draft pick in a given year.*


### Fouls and playoff contention 
The amount of fouls a team gives doesn't influence whether they make the playoffs or the finals. 35% of championship contenders gave more fouls, on average, than the rest of the league. 

<img width="1098" alt="Screenshot 2024-03-08 at 11 03 34 PM" src="https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/16438456/7d23d458-2ca1-4cbd-9305-00a558ae30eb">


### 3-point attempts among finals contenders
87% of the time a team that made the finals led the league in 3-pointers attempted. Based on this evidence it's advantageous to sign players that shoot many 3-pointers, regardless of % made.

<img width="1100" alt="Screenshot 2024-03-08 at 11 09 29 PM" src="https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/16438456/9d910e92-2e18-46f1-a0cf-7a6332a6f01a">


### Top 10 +/- players and playoff contention
+/- tells a player's point differential while on the court. In the last 23 seasons, teams that make the playoffs nearly always have a player in the top 10 for +/-. If your team lacks a top 10 +/- player, it's important to trade for one if you want to make a playoff run. 

<img width="1107" alt="Screenshot 2024-03-08 at 11 16 16 PM" src="https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/16438456/2fabb4d0-3aee-450f-a028-f092a8da93f7">


### Salary among starters
91% of finals contenders since 2000-01 had the most expensive starting 5, on average, compared to the rest of the league. If you want to compete for a championship, recent evidence shows you have to spend more on your top players than other teams.

<img width="1100" alt="Screenshot 2024-03-08 at 11 24 32 PM" src="https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/16438456/c9660b00-1bcd-4d25-8a24-b91dc1b1fff4">


### Clutch player performances in the playoffs
Teams making the finals nearly always have a higher number of clutch-player performances (35+ point game) than the rest of playoff contenders. To compete for a championship, you need a player that can reliably score big in the playoffs. 

<img width="1103" alt="Screenshot 2024-03-08 at 11 29 20 PM" src="https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/16438456/ac89d353-ed46-4622-ae24-81424317415c">


### Dead payroll among playoff contenders
Teams with higher dead payroll typically don't make the playoffs. Smart player signings that don't result in premature trades are an indicator of playoff contention. 

<img width="1100" alt="Screenshot 2024-03-08 at 11 32 54 PM" src="https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/16438456/bc0e3a30-7b46-4edc-8474-d45757aebfb6">


### Luxury tax bills among championship contenders
Since 2011-12, 92% of championship contenders had higher average luxury tax bills. Recent evidence shows it pays off to dip into luxury tax space and pay extra for top talent if you want to win a championship. 

<img width="1107" alt="Screenshot 2024-03-08 at 11 35 21 PM" src="https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/16438456/6f7f3e78-f6ea-4cdd-9081-ccf1561a3036">


## Conclusions
This project successfully extracts significant insights from NBA data that GMs & NBA fans would find interesting, such as: 

- It pays off to spend more on starting players, especially those with more experience in the league who can put up big numbers during playoff time and shoot 3-pointers often. 
- Target +/- as a north star metric when assessing player value as it relates to championship likelihood. 
- Early draft picks don't seem to materialize into championship runs.
- Avoid trading away and creating dead payroll at all costs. 
