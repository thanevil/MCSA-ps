<#
    190122 - Alex
    Initial setup
#>
 
Set-Executionpolicy -Scope CurrentUser -Executionpolicy UnRestricted -Force

#region = [Time] = = = = = = = = = =
Set-TimeZone -Id "Israel Standard Time"
#endregion = [Time] = = = = = = = = = =

#region = [IP Address] = = = = = = = = = =
& netsh interface ipv4 set address name="ethernet0" static 10.0.0.2 255.255.255.0 10.0.0.1 
#endregion = [IP Address] = = = = = = = = = =

#region = [Name] = = = = = = = = = =
Rename-computer -newname DC-srv16
#endregion = [Name] = = = = = = = = = =


"@Echo off " | Out-File -FilePath .\Run.cmd -Encoding utf8 -Force
"cls" | Out-File -FilePath .\Run.cmd -Encoding utf8 -Append
"powershell.exe -ExecutionPolicy bypass -file c:\tmp\3.ps1" | Out-File -FilePath .\Run.cmd -Encoding utf8 -Append

Restart-Computer -Force



