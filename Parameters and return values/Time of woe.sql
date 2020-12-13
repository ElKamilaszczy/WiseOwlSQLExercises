/*
First proc to see a continent, in which first event occured. Pass that Continent to OUTPUT param and use this in second procedure, which filters out events only happened in this continent.
*/
Use WorldEvents;
GO
CREATE OR ALTER PROC spFirstEvent @ConName VARCHAR(100) OUTPUT
AS
BEGIN
WITH cte AS (
	SELECT tco.ContinentName, ROW_NUMBER() OVER(ORDER BY te.EventDate ASC) as RN FROM tblEvent te inner join tblCountry tc ON te.CountryID = tc.CountryID
	INNER JOIN tblContinent tco ON tc.ContinentID = tco.ContinentID
)
SELECT @ConName = ContinentName FROM cte WHERE RN = 1;
END;
GO
CREATE OR ALTER PROC spEventsOccuredInContinent @ContinentName VARCHAR(100)
AS
BEGIN
	SELECT te.EventName, te.EventDate, tco.ContinentName FROM tblEvent te inner join tblCountry tc ON te.CountryID = tc.CountryID
	INNER JOIN tblContinent tco ON tc.ContinentID = tco.ContinentID
	WHERE tco.ContinentName = @ContinentName;
END;
GO
DECLARE @ContinentName VARCHAR(100) = '';
EXEC spFirstEvent @ConName = @ContinentName OUTPUT;
EXEC spEventsOccuredInContinent @ContinentName = @ContinentName;
-- 