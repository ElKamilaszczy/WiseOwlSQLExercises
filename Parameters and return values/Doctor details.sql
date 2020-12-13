
USE DoctorWho;
GO
CREATE OR ALTER PROC spDoctorAndNumOfEpisodes @DocId int, @DocName VARCHAR(100) OUTPUT, @Num int OUTPUT
AS
BEGIN
SELECT @Docname = td.DoctorName,  @Num = COUNT(te.EpisodeId)  FROM tblEpisode te right join tblDoctor td ON te.DoctorId = td.DoctorId
WHERE td.DoctorId = @DocId
GROUP BY td.DoctorId, td.DoctorName
END;
GO
DECLARE @DocId int = 1, @DocName VARCHAR(100), @Num int;
EXEC spDoctorAndNumOfEpisodes @DocId = @DocId, @DocName = @DocName OUTPUT, @Num = @num OUTPUT;
PRINT 'Doc number: ' + CAST(@DocId as VARCHAR);
PRINT '';
PRINT 'Name: ' + @DocName + ', num of episodes: ' + CAST(@Num as VARCHAR);