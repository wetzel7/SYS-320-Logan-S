. (Join-Path $PSScriptRoot apacheLogs2.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot String-Helper.ps1)
. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot chromeScript.ps1)

$Prompt = "Choose a Menu Item to proceed:`n"
$Prompt += "1 - Show last 10 apache logs`n"
$Prompt += "2 - Show last 10 failed login attempts for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start chrome and go to champlain.edu. Exit chrome if already open`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){
    Write-Host $Prompt | Out-String 
    $choose = Read-Host

    if($choose -eq 1){
        ApacheLogs1
    }

    elseif($choose -eq 2){

        $days = Read-Host "Number of days of logs to fetch for failed logins"
        getFailedLogins $days| Format-Table -AutoSize
    
    }

    elseif($choose -eq 3){

        $days = Read-Host -Prompt "numbers of days to go back"
        Write-Host "at Risk Users:"
        atRiskUsers $days
    }

    elseif($choose -eq 4){
    
        chromeStartKill
    }

    elseif($choose -eq 5){

        Write-Host "Exiting" | Out-String
        exit
        $operation = $false
    }

    else{

        Write-Host "Not a valid input"

    }
}