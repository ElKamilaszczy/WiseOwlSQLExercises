/*
Create a series of views which will ultimately list out all of the episodes which had both multiple enemies and multiple companions.
Note. There are many ways to do things like this in SQL, and the method in this exercise is a long way from being the most efficient.
*/
-- Using views--
USE DoctorWho;
GO
-- View to list Llist all of the episodes which had only a single companion.--
CREATE OR ALTER VIEW vwEpisodeCompanion
AS
select te.EpisodeId, te.Title FROM tblEpisode te
INNER JOIN tblEpisodeCompanion tc
ON tc.EpisodeId = te.EpisodeId
GROUP BY te.EpisodeId, te.Title
HAVING COUNT(*) = 1;
GO
--View to list all of the episodes which had only a single enemy.
CREATE OR ALTER VIEW vwEpisodeEnemy
AS
select te.EpisodeId, te.Title FROM tblEpisode te
INNER JOIN tblEpisodeEnemy tc
ON tc.EpisodeId = te.EpisodeId
GROUP BY te.EpisodeId, te.Title
HAVING COUNT(*) = 1
GO
-- Finally - the view to list all of the episodes which have no corresponding rows in either the vwEpisodeCompanion or vwEpisodeEnemy tables.
SELECT EpisodeId, Title FROM tblEpisode te
WHERE Not EXISTS 
(
SELECT NULL FROM vwEpisodeCompanion vc
WHERE vc.EpisodeId = te.EpisodeId
)
AND Not EXISTS
(
SELECT NULL FROM vwEpisodeEnemy vc
WHERE vc.EpisodeId = te.EpisodeId
)
/* better way to tackle this problem */
SELECT EpisodeId, Title FROM tblEpisode te
WHERE Not EXISTS
(
	SELECT NULL FROM tblEpisodeCompanion tc
	WHERE tc.EpisodeId = te.EpisodeId
	GROUP BY tc.EpisodeId
	HAVING COUNT(*) = 1
)
AND Not EXISTS
(
SELECT NULL FROM tblEpisodeEnemy tc
	WHERE tc.EpisodeId = te.EpisodeId
	GROUP BY tc.EpisodeId
	HAVING COUNT(*) = 1
)