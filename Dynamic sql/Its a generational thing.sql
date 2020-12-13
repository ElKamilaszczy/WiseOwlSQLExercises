Use WorldEvents;
GO
-- Variable which contains comma separated list of events that occured in my decade of birth
DECLARE @eventList NVARCHAR(MAX) = '';
SELECT @eventList = SUBSTRING(
(SELECT ', '+QUOTENAME(e.EventName, '''') FROM tblEvent e
WHERE e.EventDate BETWEEN '19900101' AND '20000101' 
FOR XML PATH('')
), 3, 20000);
SELECT @eventList;
-- Dynamic SQL --
DECLARE @stmt1 NVARCHAR(MAX) = '',
@paramDefinition NVARCHAR(50) = '@list NVARCHAR(MAX)';
SET @stmt1 = N'SELECT * FROM tblEvent WHERE EventName IN ('+@eventList+')';
EXEC sp_executesql  @stmt1, N'@eventList NVARCHAR(MAX)', @eventList;
