--Determine SQL Server Backup Path

select  top 5 a.server_name, a.database_name, backup_finish_date, a.backup_size,
CASE a.[type] -- Let's decode the three main types of backup here
 WHEN 'D' THEN 'Full'
 WHEN 'I' THEN 'Differential'
 WHEN 'L' THEN 'Transaction Log'
 ELSE a.[type]
END as BackupType
 ,b.physical_device_name
from msdb.dbo.backupset a join msdb.dbo.backupmediafamily b
  on a.media_set_id = b.media_set_id
where a.database_name Like 'Movies%'
order by a.backup_finish_date desc


--Server name + backup folder


select  top 5 a.server_name, a.database_name, backup_finish_date, a.backup_size,
CASE a.[type] -- Let's decode the three main types of backup here
 WHEN 'D' THEN 'Full'
 WHEN 'I' THEN 'Differential'
 WHEN 'L' THEN 'Transaction Log'
 ELSE a.[type]
END as BackupType
-- Build a path to the backup
,'\\' + 
-- lets extract the server name out of the recorded server and instance name
CASE
 WHEN patindex('%\%',a.server_name) = 0  THEN a.server_name
 ELSE substring(a.server_name,1,patindex('%\%',a.server_name)-1)
END 
-- then get the drive and path and file information
+ '\' + replace(b.physical_device_name,':','$') AS '\\Server\Drive\backup_path\backup_file'
from msdb.dbo.backupset a join msdb.dbo.backupmediafamily b
  on a.media_set_id = b.media_set_id
where a.database_name Like 'Movies%'
order by a.backup_finish_date desc