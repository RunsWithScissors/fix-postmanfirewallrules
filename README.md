# Fix-PostmanFirewallRules.ps1

This is a simple PowerShell script and readme to schedule a task that updates Windows firewall from Postman nagging to llow it.


## Installation as a scheduled task

Run this in an elevated PowerShell prompt:

```pwsh
$action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Scripts\Fix-PostmanFirewallRules\Fix-PostmanFirewallRules.ps1"

$trigger = New-ScheduledTaskTrigger -AtLogOn

$settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Minutes 1)

Register-ScheduledTask -TaskName "Postman Firewall Rule" `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -RunLevel Highest `
    -Force
```

## Test the task

`Start-ScheduledTask -TaskName "Postman Firewall Rule"`

## Verify the path

`Get-NetFirewallRule -DisplayName "Postman" | Get-NetFirewallApplicationFilter | Select-Object Program`