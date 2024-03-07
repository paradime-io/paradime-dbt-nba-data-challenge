## Table of Contents
1. [Introduction](#introduction)
2. [Data Sources](#data-sources)
3. [Methodology](#methodology)
   - [Tools Used](#tools-used)
   - [Applied Techniques](#applied-techniques)
4. [Visualizations](#visualizations)
   - [Team Playoff Appearances](#team-playoff-appearances)
   - [Player Playoff Games](#player-playoff-games)
   - [Top Playoff Scorers](#top-playoff-scorers)
   - [Top Regular Season Scorers](#top-regular-season-scorers)
   - [NBA Players by University](#nba-players-by-university)
5. [Conclusions](#conclusions)

## Introduction
Explore my project for the _dbt™ data modeling challenge - NBA Edition_, Hosted by [Paradime](https://www.paradime.io/)! This project dives into the analysis and visualization of NBA statistics, designed for basketball enthusiasts and analysts.

### [My GitHub repo](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/tree/nba-kevinhannon95-gmail-com)

## Data Sources
My analysis leverages three key NBA datasets from Paradime:

- *COMMON_PLAYER_INFO*
- *TEAM_STATS_BY_SEASON*
- *TEAM_SPEND_BY_SEASON*

## Methodology
### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, dbt™.
- **[Snowflake](https://www.snowflake.com/)** for data storage and computing.
- **[Sigma](https://www.sigmacomputing.com)** for data visualization.

### Applied Techniques
- SQL and dbt™ to transform stg_team_stats_by_season and stg_team_spend_by_season to investigate
whether a larger payroll leads to a greater number of NBA championships
- SQL and dbt™ to transform stg_common_player_info to understand how the end of the Cold War 
led to an increase in NBA players from Eastern Europe and the growth of the league internationally
- SQL and dbt™ to transform stg_team_stats_by_season to examine which teams were the first to extensively use the 3-point shot

## Visualizations
### Can Money Buy Championships?
Assesment of the relationship between a team's salary rank in a season and total number of NBA championships.

![NBA Championships by Team Salary Rank](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-kevinhannon95-gmail-com/models/example_transformations/warehouse/NBA%20Championships%20by%20Team%20Salary%20Rank.png)

*Insights:* 
I was interested if there was a notable correlation between the total number of championships won by a team with a particular salary rank for the season.
The results were mostly what I had expected and show that the teams with the largest payrolls have won the most NBA championships.
Surprisingly, the next greatest number of championships was actually the teams with the third-highest salary rank rather than the second-highest
with a gradual decline in total championships before an unexpected bump at the fifteenth-highest salary.
Overall, though, a higher payroll does correlate to more NBA championships.

### How did the end of the Cold War affect the international growth of the NBA?
Exploration of the rise of NBA players from Eastern Europe in the years following 1989

![Running Total of NBA Players from Eastern Europe](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-kevinhannon95-gmail-com/models/example_transformations/warehouse/Running%20Total%20of%20NBA%20Players%20from%20Eastern%20Europe.png)

*Insights:* 
The NBA has become the most popular U.S. sports league internationally over the past few decades with [CNBC](https://www.cnbc.com/2023/10/25/nba-season-starts-how-its-expanding-global-reach.html) reporting that
the league expects fans from 214 different countries to tune in this year and that a record number (125) of international players were on opening-night rosters this season.
However, I was particularly interested about another important time for the NBA internationally – the last years of the Cold War. I read an [article](https://stacker.com/basketball/25-ways-nba-has-changed-last-50-years) that mentioned how
the Soviet Union first allowed their players to join the NBA at the end of the 1988 Olympics. As a result, I visualized the running total of NBA players from Eastern Europe to illustrate the influence of those early trailblazers like Vlade Divac (Serbia), 
Drazen Petrovic (Croatia) and Sarunas Marciulionis (Lithuania) who all joined the NBA in 1989 and whose countries now account for the top three most NBA players from Eastern Europe. Those early players paved the way for current stars such as
Kristaps Porzingis and the rise of the NBA as an international success.

### Which teams first popularized the 3-Pointer?
Exploration of which teams were the first to adopt the three-pointer following the first by the Celtics' Chris Ford on October 12, 1979. However, 3-point data in this dataset only starts in 1982.

![Top 5 NBA Teams with the Most 3-Point Attempts (1982-88)](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-kevinhannon95-gmail-com/models/example_transformations/warehouse/Three%20Point%20Rank%20by%20Season%20and%20Team%20Name.png)

*Insights:* 
I've seen many charts showing the steady rise of 3-pointers over time in the NBA and the ways in which it has profoundly changed the game.
As a result, I wondered which teams were the first to notably adopt the three-point shot in those early years so I ranked each team by the number of attempted three-pointers across
the first six seasons available. The data revealed a surprising consistency in the teams making the top 5 ranking in those early years, notably the Washington Bullets, Dallas Mavericks (number 1 for three consecutive seasons!)
and Boston Celtics. Many other teams were in the ranking mix during those years but it's interesting how some teams were notably early in adopting the three-pointer
and understanding how it would reshape the league.

## Conclusions

* Teams with the largest payrolls have won the most NBA championships but more spending does not necessarily guarantee a championship
* The end of the Cold War led to an increase in NBA players from Eastern Europe and was a crucial catalyst to the growth of the NBA as an international success
* The Washington Bullets, Dallas Mavericks and Boston Celtics were the first teams to consistently adopt the 3-pointer and likely understand the profound ways in which it would later change the league.