# dbt™ Data Modeling Challenge - NBA Edition

# Final Submission

## Table of Contents
1. [Introduction](#introduction)
2. [Data Sources](#data-sources)
3. [Methodology](#methodology)
   - [Tools Used](#tools-used)
   - [Applied Techniques](#applied-techniques)
4. [Dashboards](#dashboards)
   - [Team Playoff Appearances](#team-playoff-appearances)
   - [Player Playoff Games](#player-playoff-games)
   - [Top Playoff Scorers](#top-playoff-scorers)
   - [Top Regular Season Scorers](#top-regular-season-scorers)
   - [NBA Players by University](#nba-players-by-university)
5. [Conclusions](#conclusions)

## Introduction
Explore my project for the _dbt™ data modeling challenge - NBA Edition_, Hosted by [Paradime](https://www.paradime.io/)! This project dives into the analysis and visualization of NBA statistics, designed for basketball enthusiasts and analysts.

### [My GitHub repo](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/tree/nba-spence-perry)

## Data Sources
My analysis these NBA datasets from Paradime:
- Player Game Logs
- Common Player Info
- Games

Additional Data Sources
- NBA League Salary Cap by Year
- Field Goal Tracking Data
- Injury Report Data

## Methodology
### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, dbt™.
- **[Snowflake](https://www.snowflake.com/)** for data storage and computing.
- **Lightdash** for data visualization.

### Applied Techniques
- SQL, dbt to transform player_salaries_by_season
- SQL, dbt to transform and model game info
- SQL, dbt to transform and model annual salary cap data
- SQL, dbt to transform and model field goal attempt data
- SQL, dbt to transform and model injury report data (early Stages)
- Lightdash semantic layer modeling to combine player game logs, common player info, player salaries, field goals, and injuries


## Dashboards

### Behind the Arc: A closer look at three-pointers

![3pt_1](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/3pt/cap1.png?raw=true)

![3pt_2](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/3pt/cap2.png?raw=true)

![3pt_3](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/3pt/cap3.png?raw=true)

![3pt_4](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/3pt/cap4.png?raw=true)

### Every Second Counts: Final moments in final quarters

![final_1](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/final_seconds/cap1.png?raw=true)

![final_2](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/final_seconds/cap2.png?raw=true)

### Mind the Cap: NBA Salary Cap Investigation

![salary_1](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/salary/cap1.png?raw=true)

![salary_2](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/salary/cap2.png?raw=true)

![salary_3](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/salary/cap3.png?raw=true)

![salary_4](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-spence-perry/screenshots/salary/cap4.png?raw=true)

### Whoops, there it is: Injuries in the NBA (Still early stage)
![]

## Conclusions

- The game of basketball is evolving. There is higher focus on efficiency in spending of resources, whether those are available shots, available dollars, or remaining seconds.


