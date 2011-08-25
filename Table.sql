/* Calculate a league table out of a set of results
 * See ResultsSample.sql for database structure and sample data
 */
SELECT team_name, SUM(w), SUM(l), SUM(t), SUM(pts) AS pts, SUM(gls), SUM(glsag), SUM(diff) AS diff FROM teams AS b
INNER JOIN(
	SELECT 
		home_team_id AS team_id, 
		1 AS w, 
		0 AS l, 
		0 AS t, 
		3 AS pts, 
		home_team_goals AS gls, 
		away_team_goals AS glsag, 
		(home_team_goals - away_team_goals) AS diff 
	FROM `matches` WHERE home_team_goals > away_team_goals
	UNION ALL
	SELECT away_team_id, 0, 1, 0, 0, away_team_goals, home_team_goals, (away_team_goals - home_team_goals) FROM matches WHERE home_team_goals > away_team_goals
	UNION ALL
	SELECT home_team_id, 0, 1, 0, 0, home_team_goals, away_team_goals, (home_team_goals - away_team_goals) AS diff FROM matches WHERE home_team_goals < away_team_goals
	UNION ALL
	SELECT away_team_id, 1, 0, 0, 3, away_team_goals, home_team_goals, (away_team_goals - home_team_goals) AS diff FROM matches WHERE home_team_goals < away_team_goals
	UNION ALL
	SELECT home_team_id, 0, 0, 1, 1, home_team_goals, away_team_goals, 0 FROM matches WHERE home_team_goals = away_team_goals
	UNION ALL
	SELECT away_team_id, 0, 0, 1, 1, away_team_goals, home_team_goals, 0 FROM matches WHERE home_team_goals = away_team_goals
) AS a
ON a.team_id = b.team_id
GROUP BY a.team_id
ORDER BY pts DESC, diff DESC