. (Join-Path "C:\Users\champuser\SYS-320-01-Logan-S\week6\turnToMenu" Event-Logs.ps1)
. (Join-Path "C:\Users\champuser\SYS-320-01-Logan-S\week7" Email.ps1)
. (Join-Path "C:\Users\champuser\SYS-320-01-Logan-S\week7" Scheduler.ps1)
. (Join-Path "C:\Users\champuser\SYS-320-01-Logan-S\week7" Configuration.ps1)

# Obtaining Configuration
$configuration = getConfiguration

# Obtaining at risk users
$Failed = atRiskUsers($configuration.Days)

# Sending at risk users email
sendAlertEmail($Failed | Format-Table -AutoSize| Out-String)

# Setting the script to be run daily
ChooseTimeToRun($configuration.Time)