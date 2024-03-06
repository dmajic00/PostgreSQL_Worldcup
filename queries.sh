#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals)+SUM(opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals)+AVG(opponent_goals),16) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals>2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "select name from teams t full join games g on t.team_id=g.winner_id where g.round='Final' and year=2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo  "$($PSQL "SELECT w.name FROM games g JOIN teams w ON g.winner_id = w.team_id where year=2014 and round='Eighth-Final' UNION ALL SELECT o.name FROM games g JOIN teams o ON g.opponent_id = o.team_id where year=2014 and round='Eighth-Final' order by name ")"

echo -e "\nList of unique winning team names in the whole data set:"
echo  "$($PSQL "SELECT DISTINCT(name) FROM games JOIN teams on games.winner_id=teams.team_id  order by name ")"

echo -e "\nYear and team name of all the champions:"
echo  "$($PSQL "SELECT year, name FROM games JOIN teams on games.winner_id=teams.team_id where round='Final' order by year ")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams where name like 'Co%' order by name ")"
