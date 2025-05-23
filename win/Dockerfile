# SQL Server 2019 Windows container dockerfile
## Warning: Restarting windows container causes the machine key to change and hence if you have any encryption configured then restarting SQL On Windows containers breaks the encryption key chain in SQL Server. 

# Download the SQL Developer from the following location  https://go.microsoft.com/fwlink/?linkid=866662 and get the .box and .exe files using the option: "Download Media"
# Download Latest Cumulative Update from the following location  https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2019/build-versions

FROM mcr.microsoft.com/windows/servercore:ltsc2019

ENV sa_password="_" \
    attach_dbs="[]" \
    ACCEPT_EULA="_" \
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY start.ps1 /
COPY SQLServer2019-DEV-x64-ENU.exe /
COPY SQLServer2019-DEV-x64-ENU.box /
COPY SQLServer2019-CU-x64.exe /

WORKDIR /

RUN Start-Process -Wait -FilePath .\SQLServer2019-DEV-x64-ENU.exe -ArgumentList /qs, /x:setup ; \
    .\setup\setup.exe /q /ACTION=Install /INSTANCENAME=MSSQLSERVER /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT AUTHORITY\NETWORK SERVICE' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS ; \
    Remove-Item -Recurse -Force SQLServer2019-DEV-x64-ENU.exe, SQLServer2019-DEV-x64-ENU.box, setup

RUN stop-service MSSQLSERVER ; \
    set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql15.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; \
    set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql15.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; \
    set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql15.MSSQLSERVER\mssqlserver\' -name LoginMode -value 2 ;

RUN Start-Process -Wait -FilePath .\SQLServer2019-CU-x64.exe -ArgumentList '/Action=Patch /InstanceName=MSSQLSERVER /quiet /IAcceptSQLServerLicenseTerms' ; \
    Remove-Item -Recurse -Force SQLServer2019-CU-x64.exe

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

CMD .\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose
