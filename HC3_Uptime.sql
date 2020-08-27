--Uptime

use[tempdb]
GO
SET NOCOUNT ON;
DECLARE @db_created DATETIME,
@seconds_diff INT,
@days_online INT,
@hours_online INT,
@minutes_online INT;
SELECT @db_created = create_date FROM sys.databases WHERE name = 'tempdb'
SELECT @seconds_diff = DATEDIFF(second,@db_created,GETDATE())
,@days_online  = @seconds_diff/86400
,@seconds_diff = @seconds_diff % 86400
,@hours_online = @seconds_diff/3600
,@seconds_diff = @seconds_diff %3600
,@minutes_online = @seconds_diff/60
PRINT'SQL Server'+' '+@@SERVERNAME+' '+'is online for'+' '+ CAST(@days_online AS varchar) + ' ' + 'days and'+ ' ' +  CAST(@hours_online AS varchar) + ' ' + 'hours' +' '  
+ CAST(@minutes_online AS varchar)+' '+'minutes'