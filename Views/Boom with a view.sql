use WorldEvents;
GO
Create OR ALTER VIEW vwEverything
AS
SELECT tc.CategoryName, tcon.ContinentName, tco.CountryName, te.EventName, te.EventDate FROM
tblEvent te inner join tblCategory tc ON te.CategoryID = tc.CategoryID
INNER JOIN tblCountry tco ON tco.CountryID  = te.CountryID
INNER JOIN tblContinent tcon ON tcon.ContinentID = tco.ContinentID
GO
SELECT CategoryName, COUNT(*) FROM vwEverything
WHERE ContinentName = 'Africa'
GROUP BY CategoryName