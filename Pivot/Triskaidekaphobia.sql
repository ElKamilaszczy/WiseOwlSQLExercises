/*
Pivot table to show numer of episodes by year and series number (first 5 series)
*/
Use DoctorWho;
GO
WITH cte AS (
	Select YEAR(e.EpisodeDate) as EpisodeYear, e.SeriesNumber, e.EpisodeId FROM tblEpisode e
)
SELECT * FROM cte e
PIVOT(
	COUNT(e.EpisodeId) FOR e.SeriesNumber IN ([1], [2], [3], [4], [5])
) as P