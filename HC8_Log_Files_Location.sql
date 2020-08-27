--Determin error log location

SELECT SERVERPROPERTY('ErrorLogFileName')

--Reading Error Log File in SSMS
EXEC sp_readerrorlog

--default  6 max 99 log files
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE'
,N'Software\Microsoft\MSSQLServer\MSSQLServer'
,N'NumErrorLogs'
,REG_DWORD
,99
GO

--recycle error log

exec sp_cycle_errorlog
--inspecting errorlog after recycle
exec sp_readerrorlog
