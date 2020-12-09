USE DoctorWho;
GO
DECLARE @epId INT, @EnemyList nvarchar(100) = '';
SET @epId = 15;
SELECT @EnemyList = ', '+CAST(ten.EnemyName as varchar) + @EnemyList FROM
tblEpisode te INNER JOIN tblEpisodeEnemy tee ON te.EpisodeId = tee.EpisodeId
INNER JOIN tblEnemy ten ON tee.EnemyId = ten.EnemyId
WHERE te.EpisodeId = @epId;
SELECT SUBSTRING(@EnemyList, 3, 2000);
-- With loop --
GO
DECLARE @epId int = 15, @EnemyList nvarchar(100) = '', @EnemyPom nvarchar(50) = '',
@inc int = 1;
DECLARE C CURSOR LOCAL FORWARD_ONLY FAST_FORWARD FOR 
SELECT ten.EnemyName  FROM
tblEpisode te INNER JOIN tblEpisodeEnemy tee ON te.EpisodeId = tee.EpisodeId
INNER JOIN tblEnemy ten ON tee.EnemyId = ten.EnemyId
WHERE te.EpisodeId = @epId;
OPEN C;
FETCH NEXT FROM C INTO @EnemyPom;
-- SET @EnemyList = @EnemyPom; Deleted
WHILE @@FETCH_STATUS = 0
BEGIN
SELECT @EnemyList = @EnemyList + ', '+@EnemyPom;
FETCH NEXT FROM C INTO @EnemyPom;
END;
CLOSE C;
DEALLOCATE C;
SELECT @EnemyList;
-- FOR XML --
GO
DECLARE @epId INT = 1, @EnemyList nvarchar(100) = '';
SET @epId = 15;
SELECT @EnemyList = SUBSTRING( (
	SELECT ', ' +ten.EnemyName FROM tblEpisode te INNER JOIN tblEpisodeEnemy tee ON te.EpisodeId = tee.EpisodeId
	INNER JOIN tblEnemy ten ON tee.EnemyId = ten.EnemyId
	WHERE te.EpisodeId = 15
	FOR XML PATH('')
), 3, 2000);
SELECT @EnemyList;
