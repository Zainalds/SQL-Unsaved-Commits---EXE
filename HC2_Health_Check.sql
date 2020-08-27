--SQL Server Basic Health Check

SET NOCOUNT ON

DECLARE @server_data varchar(50)
,@data_uptime varchar(50), @computer_name varchar(50)
,@clustercheck varchar(1), @clustermsg varchar(200)
,@prodver varchar(10), @spack varchar(3)
,@dat varchar(19), @edi varchar(35), @buildesc varchar(7)
,@nodes varchar(1), @prin varchar(15), @secn varchar(15)
SET @data_uptime = (SELECT sqlserver_start_time FROM sys.dm_os_sys_info)
SET @server_data = (SELECT @@SERVERNAME)
SET @computer_name = (SELECT CONVERT(NVARCHAR,SERVERPROPERTY('ComputerNamePhysicalNetBIOS')))
SET @clustercheck = (SELECT CONVERT(NVARCHAR,SERVERPROPERTY('IsClustered')))
SET @prodver = (SELECT CONVERT(NVARCHAR,SERVERPROPERTY('productversion')))
SET @spack = (SELECT CONVERT(NVARCHAR,SERVERPROPERTY('productlevel')))
SET @dat = (SELECT CONVERT(datetime,GETDATE()))
SET @spack = (SELECT CONVERT(NVARCHAR,SERVERPROPERTY('edition')))
SET @nodes = (SELECT COUNT(nodename) FROM sys.dm_os_cluster_nodes);
SET @prin = (SELECT TOP(1)NODENAME FROM fn_virtualservernodes())
SET @secn  = (SELECT nodename FROM fn_virtualservernodes() WHERE NodeName != @prin)


IF @prodver LIKE '%10.0%'
	BEGIN
		SET @buildesc = '2008'
	END;
		ELSE IF @prodver LIKE '10.50.%'
			BEGIN
				SET @buildesc = '2008 R2'
					END;
					ELSE IF @prodver LIKE '15.%'
					BEGIN
					SET @buildesc = '2019'
						END;
					ELSE IF @prodver LIKE '9.%'
					BEGIN
					SET @buildesc = '2005'
					 END;

IF @clustercheck = 0 

	BEGIN

	PRINT '|********************MSSQL SATUS CHECK' + ''+ @dat + '**********|'
	PRINT 'SQL Instance name:' +@server_data
	PRINT 'SQL Last restart:' +@data_uptime+'(Server Timezone)'
	PRINT 'Instance Type: CLUSTERED'
	PRINT 'Build:'+ @prodver + '(' + @buildesc + ')'
	PRINT 'MSSQL Service Pack Level:' +''+@spack
	PRINT 'Cluster Nodes:'+ @nodes
	PRINT 'Primary Cluster Node:'+''+@prin
	PRINT 'Secondary CLuster Node:'+''+@secn
	PRINT 'SQL is running on:'+''+@computer_name
	END;

	--DB status check

DECLARE @dbstate varchar(1)
SET @dbstate = (SELECT SUM(state) FROM sys.databases)
IF @dbstate = 0
	PRINT 'Databases Status (System and User); All ONLINE'
		ELSE PRint 'Databases Status (System and User_; One or more not ONLINE'

--User DB count

DECLARE @userdbcount varchar(3)
SET @userdbcount = (SELECT COUNT(database_id) FROM sys.databases
WHERE database_id > 4)

PRINT 'User Db Count'+''+@userdbcount

--SQL Agent Status

Create table #agentstatus (status varchar(15))
DECLARE @agentstatus varchar(15)
INSERT INTO #agentstatus (status)
exec xp_servicecontrol'querystate','sqlserveragent'
SET @agentstatus = (SELECT status as 'SQL Agent Status' FROM #agentstatus)
PRINT 'SQL Server AGent status'+''+ @agentstatus
DROP TABLE #agentstatus
PRINT'|********************End of MSSQL Status Check'+''+@dat+'**********|'