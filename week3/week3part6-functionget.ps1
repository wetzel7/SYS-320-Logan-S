. (Join-Path $PSScriptRoot "week3part4-LogonLogoff.ps1")
. (Join-Path $PSScriptRoot "week3part5-PowerOnOff.ps1") 

clear

# Get login and logoffs from last X days
$loginouts = WinLogHist


# Get shut downs and start ups from last X days
$PowerOnOffHists = PowerOnOffHist

$loginouts 
$PowerOnOffHists 

