--Initial vs Current MB Database Size


SELECT DB_NAME(database_id) AS database_name, 
    type_desc, 
    name AS FileName, 
    size/128.0 AS CurrentSizeMB
FROM sys.master_files
WHERE database_id > 6 AND type IN (0,1)

--Database free space

SELECT DB_NAME() AS DbName, 
    name AS FileName, 
    type_desc,
    size/128.0 AS CurrentSizeMB,  
    size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0 AS FreeSpaceMB
FROM sys.database_files
WHERE type IN (0,1);