docker run -d -p 1444:1433 -e sa_password=Aa123456! -e ACCEPT_EULA=Y microsoft/mssql-server-windows-developer-2019

::docker run -d -p 1455:1433 -v D:/PROJECT/Docker/win_sql/FileStorage1C:C:/temp/ -e sa_password=Aa123456! -e ACCEPT_EULA=Y -e attach_dbs="[{'dbName':'FileStorage1C','dbFiles':['C:\\temp\\FileStorage1C.mdf','C:\\temp\\FileStorage1C_log.ldf']}]" microsoft/mssql-server-windows-developer-2019

::docker run -d -p 1466:1433 -v D:/PROJECT/Docker/win_sql/FileStorage1C:C:/temp/ -e sa_password=Aa123456! -e ACCEPT_EULA=Y -e attach_dbs="bases.json" microsoft/mssql-server-windows-developer-2019
