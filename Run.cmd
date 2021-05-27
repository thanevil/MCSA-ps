@Echo off 
cls
powershell.exe -ExecutionPolicy bypass -File .\create_task.ps1
powershell.exe -ExecutionPolicy bypass -File .\time_ip_name.ps1
