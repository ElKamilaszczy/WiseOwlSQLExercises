/*
Scalar function to see, if an event is first alphabetically, last, newest (based on date), otherwise - loser.
Obviously the performance of this function will be horrible
*/
USE WorldEvents;
GO
CREATE OR ALTER FUNCTION fnWinners (@EventID int)
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @EventName VARCHAR(100) = '';
SET @EventName = CASE 
	WHEN @EventID = (SELECT TOP 1 EventID FROM tblEvent ORDER BY EventName ASC) THEN 'First Alphabetically'
	WHEN @EventID = (SELECT TOP 1 EventID FROM tblEvent ORDER BY EventName DESC) THEN 'Last aplhabetically'
	WHEN @EventID IN (SELECT TOP 1 WITH TIES EventID FROM tblEvent ORDER BY EventDate DESC) THEN 'Newest'
	ELSE 'Loser'
	END;
RETURN @EventName;
END;
GO
Select EventName, dbo.fnWinners(EventId) FROM tblEvent;