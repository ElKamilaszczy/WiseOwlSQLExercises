CREATE OR ALTER PROC spEpisodesSorted @SortColumn VARCHAR(30) = 'EpisodeId',
	@SortOrder CHAR(4) = 'ASC'
AS
BEGIN
DECLARE @stmt NVARCHAR(MAX);
SET @stmt = 'SELECT * FROM tblEpisode ORDER BY '+QUOTENAME(@SortColumn)+ ' '+@SortOrder;
EXEC(@stmt);
END;

exec spEpisodesSorted 'Title', 'DESC';