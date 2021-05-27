<#
    190122 - Alex
    This script will install ADDS and DNS; and promote this server to DC
#>

Install-WindowsFeature -name AD-Domain-Services -IncludeAllSubFeature -includemanagementtools
Install-WindowsFeature -name DNS -IncludeAllSubFeature -includemanagementtools
Start-Sleep -Seconds 3

"@Echo off " | Out-File -FilePath .\Run.cmd -Encoding utf8 -Force
"cls" | Out-File -FilePath .\Run.cmd -Encoding utf8 -Append
"powershell.exe -ExecutionPolicy bypass -File .\OU_add_bulk_users.ps1" | Out-File -FilePath .\Run.cmd -Encoding utf8 -Append

Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath “C:\Windows\NTDS” -DomainMode “Win2012R2” -DomainName cyber.local -DomainNetbiosName cyber -ForestMode “Win2012R2” -InstallDns:$true -LogPath “C:\Windows\NTDS” -NoRebootOnCompletion:$false -SysvolPath “C:\Windows\SYSVOL” -Force:$true

Restart-Computer -Force
