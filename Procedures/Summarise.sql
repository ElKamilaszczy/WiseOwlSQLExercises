/*
Create a procedure called spSummariseEpisodes to show:
    the 3 most frequently-appearing companions; then separately
    the 3 most frequently-appearing enemies.
Surely number 3 is a great candidate as an input parameter to SP
*/
USE DoctorWho;
GO
CREATE OR ALTER PROC spSummariseEpisodes @num int = 1, @direction char = 'D'
AS
BEGIN
	SET NOCOUNT ON;
	IF UPPER(@direction) = 'D'
	BEGIN
		SELECT TOP (@num) WITH TIES tc.CompanionName, COUNT(*) as Episodes FROM tblEpisode te INNER JOIN tblEpisodeCompanion tec ON te.EpisodeId = tec.EpisodeId
		INNER JOIN tblCompanion tc ON tec.CompanionId = tc.CompanionId
		GROUP BY tc.CompanionId, tc.CompanionName
		ORDER BY Episodes DESC
		SELECT TOP (@num) WITH TIES tc.EnemyName, COUNT(*) as Episodes FROM tblEpisode te INNER JOIN tblEpisodeEnemy tec ON te.EpisodeId = tec.EpisodeId
		INNER JOIN tblEnemy tc ON tec.EnemyId = tc.EnemyId
		GROUP BY tc.EnemyId, tc.EnemyName
		ORDER BY Episodes DESC
	END;
	ELSE
		BEGIN
		SELECT TOP (@num) WITH TIES tc.CompanionName, COUNT(*) as Episodes FROM tblEpisode te INNER JOIN tblEpisodeCompanion tec ON te.EpisodeId = tec.EpisodeId
		INNER JOIN tblCompanion tc ON tec.CompanionId = tc.CompanionId
		GROUP BY tc.CompanionId, tc.CompanionName
		ORDER BY Episodes ASC
		SELECT TOP (@num) WITH TIES tc.EnemyName, COUNT(*) as Episodes FROM tblEpisode te INNER JOIN tblEpisodeEnemy tec ON te.EpisodeId = tec.EpisodeId
		INNER JOIN tblEnemy tc ON tec.EnemyId = tc.EnemyId
		GROUP BY tc.EnemyId, tc.EnemyName
		ORDER BY Episodes ASC
	END;
END;
GO
EXEC spSummariseEpisodes @num = 5, @direction = 'A';