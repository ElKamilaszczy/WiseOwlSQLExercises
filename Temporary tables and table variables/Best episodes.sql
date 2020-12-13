/*
The aim of this exercise is to create a single table containing all of the "best" Doctor Who episodes (ie those featuring Karen Gillan as Amy Pond and/or those written by Steven Moffat).
*/
USE DoctorWho;
GO
DROP TABLE IF EXISTS #tempEmps;
GO
CREATE TABLE #tempEmps
(
	EpisodeID int,
	title nvarchar(100),
	SeriesNumber int,
	EpisodeNumber int,
	Why varchar(30)
);
GO
-- Insert all episodes written by Steven Moffat --
INSERT INTO #tempEmps(EpisodeID, title, SeriesNumber, EpisodeNumber, Why)
SELECT e.EpisodeId, e.Title, e.SeriesNumber, e.EpisodeNumber, a.AuthorName FROM tblEpisode e INNER JOIN tblAuthor a ON a.AuthorId = e.AuthorId
WHERE a.AuthorName = 'Steven Moffat';
-- Episodes featuring Amy Pond --
INSERT INTO #tempEmps(EpisodeID, title, SeriesNumber, EpisodeNumber, Why)
SELECT e.EpisodeId, e.Title, e.SeriesNumber, e.EpisodeNumber, c.CompanionName FROM tblEpisode e INNER JOIN tblEpisodeCompanion ec ON e.EpisodeId = ec.EpisodeId
JOIN tblCompanion c ON ec.CompanionId = c.CompanionId
WHERE c.CompanionName = 'Amy Pond'

-- Now aggregate them, so I can see episodes duplicated (more than 1)

SELECT * FROM #tempEmps;
SELECT e.EpisodeID, e.title, COUNT(*) FROM #tempEmps e
GROUP BY e.EpisodeID, e.title
HAVING COUNT(*) > 1;