. (Join-Path $PSScriptRoot Week3Part4.ps1)

clear

# Get login and logoffs from last X days
$loginouts = WinLogHist
$loginouts

# Get shut downs and start ups from last X days
$PowerOnOffHists = PowerOnOffHist
$PowerOnOffHists