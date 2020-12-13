/*
For each month return all event names in comma-separated list
	- cursor
	- For xml
	- string agg
*/
-- 1 --
USE WorldEvents;
GO
DECLARE @NumOfMonth int, @MonthName varchar(30)= '', @EventName varchar(100) = '', @MaxMonth int, @Cnt int,
@CumulStr VARCHAR(8000) = '', @PrevMonth VARCHAR(30) = '';
-- Declaration of a cursor - we really need to sort, so cursor goes and grabs approbiate events based on month
DECLARE All_Events CURSOR LOCAL FORWARD_ONLY FAST_FORWARD
FOR
SELECT DATENAME(month, EventDate), EventName FROM tblEvent
ORDER BY DATENAME(month, EventDate) ASC;
-- Max value 
SELECT @MaxMonth = MAX(DATEPART(month, EventDate)) FROM tblEvent;
-- Opne the cursor
OPEN All_Events;

SET @Cnt = 1;
FETCH NEXT FROM All_Events INTO @MonthName, @EventName;
SELECT @PrevMonth = @MonthName;
WHILE @Cnt <= @MaxMonth
BEGIN
	WHILE @@FETCH_STATUS = 0
	BEGIN
	IF @MonthName <> @PrevMonth
		BEGIN
		PRINT 'Events which occured in '+@PrevMonth+ ': '+ SUBSTRING(@CumulStr, 3, 20000);
		SELECT @PrevMonth = @MonthName, @CumulStr = '';
		BREAK;
		END;
	SELECT @CumulStr = @CumulStr + ', '+@EventName;
	FETCH NEXT FROM All_Events INTO @MonthName, @EventName;
	END;
	SET @Cnt = @Cnt + 1;
END;
-- 2 --
SELECT DATENAME(month, te.EventDate), SUBSTRING(X.event, 3, 2000) FROM tblEvent te
CROSS APPLY (
			SELECT ', '+te1.EventName FROM tblEvent te1
			WHERE DATENAME(month, te.EventDate) = DATENAME(month, te1.EventDate)
			FOR XML PATH('')
) AS X(event)
GROUP BY DATENAME(month, te.EventDate), SUBSTRING(X.event, 3, 2000);
-- 3 --
SELECT DATENAME(month, te.EventDate), STRING_AGG(te.EventName, ', ') WITHIN GROUP (ORDER BY DATENAME(month, te.EventDate))
FROM tblEvent te
GROUP BY DATENAME(month, te.EventDate)
