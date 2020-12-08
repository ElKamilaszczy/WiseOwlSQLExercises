/*
Country with no events
*/
USE WorldEvents;
GO
SELECT tc.* FROM tblEvent te RIGHT OUTER JOIN tblCountry tc ON te.CountryID = tc.CountryID
where te.CountryID IS NULL;
