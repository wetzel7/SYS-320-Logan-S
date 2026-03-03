. (Join-Path $PSScriptRoot String-Helper.ps1)


<# ******************************
     Function Explaination
****************************** #>
function getLogInAndOffs($timeBack){

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays("-"+"$timeBack")

$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){

$type = ""
if($loginouts[$i].InstanceID -eq 7001) {$type="Logon"}
if($loginouts[$i].InstanceID -eq 7002) {$type="Logoff"}


# Check if user exists first
$user = (New-Object System.Security.Principal.SecurityIdentifier `
         $loginouts[$i].ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                    "Event" = $type; `
                                     "User" = $user;
                                     }
} # End of for

return $loginoutsTable
} # End of function getLogInAndOffs




<# ******************************
     Function Explaination
****************************** #>
function getFailedLogins($timeBack){
  
  $failedlogins = Get-WinEvent -FilterHashTable @{
    LogName ='Security'
    ID      = 4625
    StartTime = (Get-Date).AddDays(-[int]$timeBack)
    }
  $failedloginsTable = @()
    for($i=0; $i -lt $failedlogins.Count; $i++){
        $xml = [xml]$failedlogins[$i].ToXml()
        $data = $xml.Event.EventData.Data

        $usr = ($data | Where-Object { $_.Name -eq 'TargetUserName' }).'#text'
        $dmn = ($data | Where-Object { $_.Name -eq 'TargetDomainName' }).'#text'
        $user = $dmn + "\" + $usr

        $failedloginsTable += [pscustomobject]@{
            "Time"  = $failedlogins[$i].TimeCreated
            "Id"    = $failedlogins[$i].Id
            "Event" = "Failed"
            "User"  = $user
        }
    }
    return $failedloginsTable
} # End of function getFailedLogins

function pastTenFailedLogins($days){

    $failedLogins = GetFailedLogins $days

    $lastTen = $failedLogins | Sort-Object -Property Time -Descending | Select-Object -First 10

    Write-Host "Last 10 failed logins on this machine:"
    Write-Host ($lastTen |Format-Table | Out-String)
    
}

function atRiskUsers($days){
    return (getFailedLogins $days | Group-Object -property User | Where-Object {$_.Count -ge 3} | Select Name, Count | Out-String)
}