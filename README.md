# dbt™ Data Modeling Challenge - NBA Edition

## Table of Contents
- [Introduction](#introduction)
- [Data Sources](#data-sources)
- [Methodology](#methodology)
- [Tools Used](#tools-used)
- [Applied Techniques](#applied-techniques)
- [Visualizations](#visualizations)
  - [Team Performance vs Payroll](#team-performance-vs-payroll)
  - [Player Development Analysis](#player-development-analysis)
  - [Player Performance vs Salary](#player-performance-vs-salary)
  - [Ways the NBA is Changing](#ways-the-nba-is-changing)
- [Conclusions](#conclusions)
- [Bonus](#bonus)

## Introduction
Explore my submission for the dbt™ data modeling challenge - NBA Edition, Hosted by Paradime! This project aimed to use essential analytics engineering tools to develop strategic insights for NBA General Managers and interesting statistics for NBA fans. I created ETL pipelines, wrote a predictive model, visualized the data, and structured my analysis and recommendations in this document.

Paradime provided NBA player and team metrics, and I sourced some external data to assist with my analysis. I created relationships with the data using SQL and dbt to discover important insights, then visualized the data with Sigma. Since the data provided was analytical, I utilized an OLAP process that produced mostly denormalized fact and dimension tables in my data warehouse.

My models and documentation are located in the Github repository [here](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/?tab=readme-ov-file#my-github-repo)!

## Data Sources
My analysis leverages these NBA datasets provided by Paradime:

- `COMMON_PLAYER_INFO`: Player attributes including name, ID, age, weight, team, draft information, country, number of seasons played, roster status, and more.
- `GAMES`: Stat sheets for every game an NBA team has played, includes core dimensions and metrics such as team ID, game ID, points, field goals, and more.
- `PLAYER_GAME_LOGS`: Stat sheets for every game an NBA player has participated in, includes their core metrics for each game.
- `PLAYER_SALARIES_BY_SEASON`: Salary information for each player and season they played.
- `TEAM_SPEND_BY_SEASON`: Each team’s payroll, luxury tax spend, and active/dead spend for each season.
- `TEAM_STATS_BY_SEASON`: Aggregated core metrics for each team for each season.
- `TEAMS`: Team attributes including team name, ID, city, and other dimensions.

External datasets used to augment my analysis:

- `INFLATION_DATA`: Yearly inflation data based on the Consumer Price Index (CPI) from the Bureau of Labor Statistics. Used to create even comparisons when looking at player salary data across different seasons.
- `SALARY_CAP_BY_SEASON`: Maximum NBA salary cap for each season, as well as the minimum and maximum amount players could earn each season, according to the NBA’s collective bargaining agreement (CBA). This information came from [Spotrac](https://www.spotrac.com/nba/cba/).

Additionally, I created a predictive model using Python with libraries such as Pandas, Snowflake, and scikit-learn to predict NBA players’ salaries based on core performance metrics.

## Methodology

### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, Python, dbt™.
- **[Snowflake](https://www.snowflake.com/)**  for data storage and computing.
- **[Sigma](https://www.sigmacomputing.com/)**  for data visualization.

### Applied Techniques
#### For Combining Core Metrics:
- SQL and dbt™ to analyze the correlation between team spend and performance, transform seasonal player statistics for cohort analyses, determine if a player's predicted salary was over or under their current salary, and analyze how the style of play has changed in the NBA over the last 20+ seasons.

#### For the Predictive Salary Model:
- Python to predict salaries based on player performance metrics. A linear regression model was trained and used to make salary predictions, adjusted for inflation, salary cap, and legal salary bounds. The data is filtered for regular season and players who played a minimum of 30 games each season.

## Visualizations

### Team Performance vs Payroll
Is there a correlation between a team’s payroll and overall performance? Do the biggest spenders tend to win more often? I explore these questions below.

![Team Performance vs Payroll - Chart 1](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/1TP_1.png)

The luxury tax threshold wasn’t implemented and enforced until the 2005 season. I analyzed salary data starting from the 2010 season since that’s the earliest season that actual luxury tax payments were available for each team that crossed the threshold.

**Insights**: Since 2010, a majority of teams are not paying the luxury tax, which means they are under or slightly above the salary cap maximum.

![Team Performance vs Payroll - Chart 2](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/1TP_2.png)

However, based on the scatter plot above, it appears that teams that spend more appear to have more wins (according to data from the 2022-23 season). 

**Insights**: Almost all teams that paid the luxury tax had more than 40 wins. Teams that paid above the salary cap but below the luxury tax threshold also performed better than their counterparts that paid less than the salary cap maximum. These teams are paying for the best players, so their performance should be better than average.

![Team Performance vs Payroll - Chart 3](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/1TP_3.png)

In the bar chart above, you can see the average number of regular season wins segmented out by teams who paid the luxury tax or not.

**Insights**: On average, teams that pay the luxury tax tend to perform better each season.

![Team Performance vs Payroll - Chart 4](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/1TP_4.png)

In the chart above, you can see the average number of team playoff wins, segmented by luxury tax payment.

**Insights**: Teams that pay the luxury tax are winning significantly more games in the playoffs versus their counterparts that do not pay the luxury tax.

![Team Performance vs Payroll - Chart 5](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/1TP_5.png)

Finally, we can see the % of teams that paid the luxury tax and made the finals/won the NBA championship since the 2010 season.

**Insights**: ~70% of teams that paid the luxury tax won the NBA championship, an astonishing number that shows the importance of investing in the best players in order to win the league each year.

### Player Development Analysis
Now that we know how spending on the best players has a higher correlation with making the playoffs and winning championships, how do we know when to invest in these players? Also, what is the longevity of star players and when do they start to decline? See my findings below for more detail.

![Player Development Analysis - Chart 1](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/2PD_1.png)

In the chart above, you can see average minutes per game with a player’s age on the X-axis. I used player data starting from the 2003 season, that’s when LeBron James was a Rookie in the league. I also segmented the data by the player’s status in the league. If they averaged more than 20 points per game three times, they were a Star player; more than six times, they were a Superstar; and if they’re in the top 75 all-time, they are a Legend.

**Insights**: Players see a rise in average minutes per game in their early years, when they’re developing. At 26/27 years old, playing time starts to decline for each cohort, however Legends and Superstars tend to have more longevity (LeBron is somehow hanging in there at the age of 39).

![Player Development Analysis - Chart 2](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/2PD_2.png)

In the chart above, you can see how Avg PPG trends over the course of a player’s career.

**Insights**: A player’s Avg PPG tends to peak at 29 for the Legends, 28 for the Superstars, and 26 for the Role players. However, Role players and Star players are relatively consistent over time until the end of their careers.

![Player Development Analysis - Chart 3](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/2PD_3.png)

Above is a look at a player’s win % over the course of their career.

**Insights**: Legends not only last longer in the league, but they are able to play on teams that have a higher winning % over the course of their career. Star players also gravitate to teams that win and Role players tag along for the ride. Superstars appear to fade around the age of 32.

### Player Performance vs Salary
It’s important to invest in the best players to win. We’ve also seen when players typically start to rise and fall in their careers as well, which guides us on when to invest in the best players.

In order to assist GMs in finding the best players now to invest in, I created a predictive model that helps us identify who is currently undervalued and overvalued compared to their most recent contract (2022-23). This model incorporates core metrics and compares a player’s current salary to how they performed against their competitors. 

I also segmented players by their experience in the league. If a player is early in their career, they’re either a “Rookie” or “Developing” player. After 5 seasons, they are “Established,” and after 10 seasons, they are a “Veteran,” which is somewhat aligned to the age data I showed earlier. 

Let’s take a look at what this data tells us to see who GMs should target or avoid for their teams.

![Player Performance vs Salary - Chart 1](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/3PS_1.png)

To start, let’s look at the most overvalued players that our model predicted and what their expected value should be according to the model.

**Insights**: Based on the model, John Wall is the most overvalued player in 2022-23. His salary was a whopping ~$47mil, but based on his performance, I predicted that he should be paid ~$11mil for his efforts. He was actually bought out of his contract and released at the end of that season, which is in line with our findings here. Ben Simmons, another notable name, has played very little over the past few years due to injury problems, but also has underperformed. Some other notable names are on there as well that the GMs should avoid.

![Player Performance vs Salary - Chart 2](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/3PS_2.png)

Similar to the overvalued players, here’s a list of the most undervalued players. 

**Insights**: Desmond Bane and Ja Morant are at the top of this list of undervalued players for their stellar play, and they’re both on the Grizzlies. We’d expect the Grizzlies to re-sign both of them since they’re the centerpieces of the franchise. Other players on the list are “Developing” players, meaning they are on the rise as well and will probably expect bigger contracts for their great performances. These are players GMs may want to consider to help their teams win in the playoffs.

![Player Performance vs Salary - Chart 3](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/3PS_3.png)

This box plot shows the distribution of overvalued and undervalued players for each experience cohort. The y-axis shows % difference between a player’s current salary (2022-23 season) and their predicted salary. Over 0% means a player is getting paid more than what was predicted, meaning they are overvalued, and vice versa for undervalued players.

**Insights**: What we’re seeing here is typically “Developing” players are the most undervalued. That means their performance is outpacing their current salary and we can expect them to demand higher contracts once their contract is about to expire. As a player gets older and into the “Veteran” and “Late Veteran” categories, they are generally not performing as well compared to what they are getting paid. It’s better to pay for developing talent in order to win games, but Veteran players are still important for winning critical games.

![Player Performance vs Salary - Chart 4](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/3PS_4.png)

Above is a scatter plot showing “Established, “Developing,” and “Rookie” players that are undervalued according to our model. The size of the circle shows what they deserve to be getting paid based on their performance.

**Insights**: These are the players GMs could potentially target to improve their teams. Here’s where these players currently stand salary-wise (see the x-axis) and what they might expect to be paid in the future.

![Player Performance vs Salary - Chart 5](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/3PS_5.png)

For fun, I decided to see who had the biggest contract of all-time when adjusting for inflation and today’s salary cap.

**Insights**: No surprise, it was Michael Jordan. What was surprising was the amount his highest contract would be worth today. In the 1996 season, his contract was worth $30mil, the most an NBA player had ever gotten paid at the time. When adjusting for inflation and today’s salary cap, that contract would have been worth an incredible **$280mil** for the 2022-23 season. The highest contract for an active player when adjusting for these attributes would have been $58mil for Steph Curry, peanuts compared to MJ’s historic contract.

### Ways the NBA is Changing
In this section, I dive into how the NBA is changing. More NBA players are starting to come from overseas and the style of play is changing to utilize the three-pointer more. This data is useful for GMs to understand so they can make more strategic decisions when deciding to draft players or change the composition of their current roster.

![Ways the NBA is Changing - Chart 1](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/4G_1.png)
![Ways the NBA is Changing - Chart 2](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/4G_2.png)
![Ways the NBA is Changing - Chart 3](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/4G_3.png)

In the charts above, I dive into three-point (3PT) shot data since the 2000-01 season. In addition, you can see how the change in 3PT data has affected overall PPG in recent years.

**Insights**: The number of 3PT attempts dramatically increased beginning in the 2012-13 season. Since that season, we’ve seen a consistent rise in the number of 3PT attempts. In the most recent season, 3PT attempts make up ~40% of all field goal attempts (FGA). As a result, the average points per game scored by an NBA team has increased as well, from ~95 PPG in the 2000 season to ~114 PPG in the 2022-23 season. The rise in three-pointers has changed how the NBA is played and teams are now more reliant on the three-pointer than ever before

![Ways the NBA is Changing - Chart 4](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/4G_4.png)
![Ways the NBA is Changing - Chart 5](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/4G_5.png)

The average height of players in the NBA has changed quite a bit as well. Above, the charts show changes in NBA player height and how that has trended with the rise in three-point attempts.

**Insights**: The NBA has gotten taller, with a larger % of players in the league standing at 6ft 4in or taller. There are almost no players smaller than 6ft in the league anymore. What’s interesting is these big men are also shooters. It’s almost a requirement now for all players to be able to shoot threes regardless of height. In the second chart, you can see that all height cohorts have seen a rise in three-point attempts since the 2012 season. Even 7-footers are shooting threes 21% of the time, compared to 4% in the 2000 season!

![Ways the NBA is Changing - Chart 6](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/4G_6.png)
![Ways the NBA is Changing - Chart 7](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/4G_7.png)

The NBA is starting to attract more international players to the league, which could lead to more money for the league as more people across the globe become interested in the NBA.

**Insights**: ~24% of the current players rostered are from countries outside the US, compared to ~9% in the 2000 season. It’s clear that basketball is becoming more popular, which means it is becoming more competitive for Americans to make it to the NBA. GMs should consider scouting around the globe to find the best talent instead of just focusing on the US.

![Ways the NBA is Changing - Chart 8](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/4G_8_NewMap.png)
![Ways the NBA is Changing - Chart 9](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-cahughes95-gmail-com/images/4G_9_OldMap.png)

The maps above show the nationalities of players in the NBA. The first map shows what it looked like in the 2000 season and the second map shows the 2022-23 season makeup.

**Insights**: More players are coming from Europe, Africa, and South America to play in the NBA. Basketball is clearly getting more popular across the globe and it might be worth scouting for players in some of the countries across these different continents. In addition, the league should consider increasing marketing in these locations to increase the popularity of the league.

## Conclusions
The NBA has a vast amount of data that can assist GMs in making strategic decisions to improve their team’s chances of winning. In addition, the data can be entertaining for avid fans who want to see their favorite teams succeed or play fantasy basketball in their spare time. Here is a summary of the biggest conclusions I drew from the data I analyzed:

- Teams that are willing to spend more tend to win more. In the 2022-23 season, teams that paid the luxury tax won more than an average of 50 games in the regular season. However, GMs need to keep in mind the effects of the compounding luxury tax when they spend more on big names, otherwise this spending may impact their bottom line despite a higher chance of winning the league.
- A player’s stats can change depending on their age and experience in the league. As younger players develop, they contribute more to their team’s success, up until their late-20s. After that, a player’s contributions trend downwards, although Superstars and Legends have greater longevity.
- I recommend GMs target developing players who are on the rise and some established/veteran star players to create a competitive team. It’s critical to target developing players who are outperforming their current salaries and not overspend on Superstars who may be past their prime.
- When accounting for inflation and salary cap, Michael Jordan had the biggest contract of all time. Is he the GOAT? We’ll let the fans decide.
- The demographics of the NBA has been changing over the past 20 years and we’re seeing a significant impact on the game itself. With more players shooting threes, it’s critical that all players are able to make long-distance shots. As the NBA attracts more international talent, more fans will come from different places as well.
Thank you for taking the time to read my analysis, I’m wishing you and your team success in the future!

## Bonus
In addition to the analysis above, I explored some of the other features available in Paradime:

- **Data Catalog:** Used the Catalog tool to generate documentation for each model, which saved time when detailing each model.
- **Bolt Scheduler:** Explored Paradime’s scheduling tool and added a “paradime_schedules.yml” file to my repository for future workflows.
- **Data Lineage:** Tested the “Lineage” tab within the Paradime code editor to see how my models were tied together in real-time.

