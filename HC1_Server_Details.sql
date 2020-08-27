
--First time when viewing a server
USE  [master]
GO

SELECT
SERVERPROPERTY('ComputerNamePhysicalNetBIOS') as ServerName,
SERVERPROPERTY('Edition') as Edition,
SERVERPROPERTY('InstanceName') as SQLName,
SERVERPROPERTY('IsClustered') as ISClustered,
SERVERPROPERTY('ProductVersion') as Build,
SERVERPROPERTY('ProductLevel') as ProdLevel
GO