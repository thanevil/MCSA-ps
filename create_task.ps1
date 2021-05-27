<#
    190122 - Alex
    Create a scheduled tasks
#>

Clear-Host

#region = [Create Scheduled task] = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# Scheduled task to be used as startup script
$1TaskName = "Run1"
$1Task = Get-ScheduledTask -TaskName $1TaskName -ErrorAction SilentlyContinue
$1Task = $1Task.ToString()
if ($1Task.Length -gt 0){
    Write-Host "The task exists"
} else {
    Write-Host "The task does not exist, start creating"
    $1Action = New-ScheduledTaskAction -Execute "C:\Tmp\Run.cmd"
    $1trigger = New-ScheduledTaskTrigger -AtLogOn
    Register-ScheduledTask -Action $1Action -TaskName $1TaskName -Description "Using as startup script" -User "Administrator" -Trigger $1trigger
}
#endregion = [Create Scheduled task] = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

