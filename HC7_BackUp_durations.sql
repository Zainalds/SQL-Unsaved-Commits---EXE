--Inspecting a Backup Database Duration through DMV

USE[Movies]
GO

BACKUP DATABASE[Movies] 
TO DISK = N'C:\Users\nabiz\Documents\SQL Server Management Studio\Backup'
GO

--Backup Duration
SELECT session_id,start_time,command,DB_NAME(database_id) DatabaseName
,percent_complete
,CONVERT(NUMERIC(6,2),estimated_completion_time/1000.0/60.0) AS [MinutesToFinish]
FROM sys.dm_exec_requests
WHERE command LIKE '%BACKUP%'
GO