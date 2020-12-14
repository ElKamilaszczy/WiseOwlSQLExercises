/*
Trigger to log any changes made on tblCountry table
*/
use WorldEvents;
GO
DROP TABLE IF EXISTS tblLogCountryChanges;
GO
CREATE TABLE tblLogCountryChanges
(
	CountryName VARCHAR(50),
	Change VARCHAR(50),
	Login VARCHAR(100),
	DateAndTime Datetime2 DEFAULT (CURRENT_TIMESTAMP)
); -- No need to create clustered index in it
GO
CREATE OR ALTER TRIGGER trgCountryChanges ON dbo.tblCountry
AFTER /* FOR */ INSERT, DELETE, UPDATE
AS
BEGIN
DECLARE @login VARCHAR(100) = SUSER_NAME();
SET NOCOUNT ON;
/* I need to ensure proper statement execution */
-- IF CountryName WAS updated  (added EXISTS because UPDATE also fires when new row is added!
IF Exists(SELECT 1 FROM inserted i INNER JOIN deleted d ON i.CountryID = d.CountryID) AND UPDATE(CountryName)
BEGIN
	insert into  tblLogCountryChanges(CountryName, Change, Login)
	select i.CountryName, 'New name', @login from inserted i;
	insert into  tblLogCountryChanges(CountryName, Change, Login)
	select i.CountryName, 'Previous name', @login from deleted i;
END
-- Next - if new country was added (while CountryName is not null, because this field is nullable)
IF EXISTS (SELECT 1 FROM inserted i) AND NOT EXISTS (SELECT 1 FROM deleted)
BEGIN
	insert into  tblLogCountryChanges(CountryName, Change, Login)
	select i.CountryName, 'Inserted', @login from inserted i;
END;
ELSE IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
BEGIN
	insert into  tblLogCountryChanges(CountryName, Change, Login)
	select i.CountryName, 'dELETED', @login from deleted i;
END;
END;
