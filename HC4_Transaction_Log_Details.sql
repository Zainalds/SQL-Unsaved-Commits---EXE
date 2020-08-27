--Validate Database COnsistency

USE[msdb]
GO
DBCC CHECKDB


--With erros
USE[Movies]
GO
DBCC CHECKDB


--Validate Table Consistency
DBCC CHECKTABLE('sysjobs') WITH ALL_ERRORMSGS
GO

--Check transaction log for each database
DBCC SQLPERF(logspace)