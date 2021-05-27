@Echo off 
cls
powershell.exe -ExecutionPolicy bypass -File .\create_task.ps1
powershell.exe -ExecutionPolicy bypass -File .\2.ps1
