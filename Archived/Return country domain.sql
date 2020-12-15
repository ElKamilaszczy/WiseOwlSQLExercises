/*
https://www.wiseowl.co.uk/sql/exercises/standard/archived/1785/
Function to write all websites with their url names, domains and domain names (of the main domain to which it belongs)
*/
Use Websites;
go
CREATE OR ALTER FUNCTION fnCountryDomains ()
RETURNS TABLE
AS
RETURN (
SELECT tw.WebsiteName, tw.WebsiteUrl,
CASE WHEN tw.WebsiteUrl = 'Not given' OR tw.WebsiteName IS NULL THEN 'Invalid'
WHEN CA.val = 0 THEN '0 - not valud url'
ELSE RIGHT(tw.WebsiteUrl, CA.val)
END AS Domain, td.DomainName
FROM tblWebsite tw INNER JOIN tblDomain td ON tw.DomainId = td.DomainId
CROSS APPLY (
	VALUES(CHARINDEX('.',REVERSE(tw.WebsiteUrl), 1))
) AS CA(val)
);
GO
SELECT * FROM fnCountryDomains()
WHERE DomainName <> Domain;
