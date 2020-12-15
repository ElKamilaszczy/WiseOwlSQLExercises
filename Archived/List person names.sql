/*
	Proc which outputs comma separated list of course students
*/
USE Training;
GO
select * from tblschedule;
SELECT * FROM tblCourse;
select * from tblDelegate;
go
CREATE OR ALTER PROC spNames @ScheduleId int, @Names NVARCHAR(MAX) OUTPUT
AS
BEGIN
SELECT @Names = SUBSTRING((SELECT ', '+CONCAT(tp.FirstName+' ',tp.LastName)  FROM tblSchedule ts INNER JOIN tblDelegate td ON ts.ScheduleId = td.ScheduleId
INNER JOIN tblPerson tp ON td.PersonId = tp.Personid
WHERE ts.ScheduleId = @ScheduleId
FOR XML PATH('')), 3, 2000);
END;
GO
DROP TABLE IF EXISTS #Schedules;
GO
CREATE TABLE #Schedules
(
	ScheduleId int,
	StartDate datetime,
	CourseName VARCHAR(50),
	People NVARCHAR(MAX)
);
GO
-- Declaration of a cursor --
DECLARE C CURSOR LOCAL FORWARD_ONLY FAST_FORWARD FOR
SELECT ts.ScheduleId, ts.StartDate, tc.CourseName FROM tblSchedule ts INNER JOIN tblCourse tc ON ts.CourseId = tc.CourseId
WHERE tc.CourseName LIKE '%SQL%' COLLATE Latin1_General_CI_AI;
DECLARE @ScheduleId int, @StartDate datetime, @CourseName varchar(40) = '';
DECLARE @Names NVARCHAR(MAX) = N'';
OPEN C;
FETCH NEXT FROM C INTO @ScheduleId, @StartDate, @CourseName;
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC spNames @ScheduleId, @Names = @Names OUTPUT;
	INSERT INTO #Schedules
	SELECT @ScheduleId, @StartDate, @CourseName, @Names;
	FETCH NEXT FROM C INTO @ScheduleId, @StartDate, @CourseName;
END;
CLOSE C;
DEALLOCATE C;
SELECT * FROM #Schedules;
