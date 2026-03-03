function getConfiguration(){

    $Days = Get-Content -Path $PSScriptRoot\configuration.txt -First 1
    $Time = Get-Content -Path $PSScriptRoot\configuration.txt -Last 1

    $configArray = @()
    $configArray = [pscustomobject]@{"Days" = $Days;"Time" = $Time}

    return $configArray

    }

function changeConfig(){

    $setDays = Read-Host -Prompt "Enter the Number of days you'd like to go back in logs" 
    $setTime = Read-Host -Prompt "Enter the execution time for the script"

    
    Clear-Content -Path $PSScriptRoot\configuration.txt
    $setDays | Out-File -FilePath $PSScriptRoot\configuration.txt
    $setTime | Out-File -FilePath $PSScriptRoot\configuration.txt -Append

    }

function configurationMenu(){

    $Prompt = "Choose a menu item to continue:`n"
    $Prompt += "1 - Show Configuration`n"
    $Prompt += "2 - Change Configuration`n"
    $Prompt += "3 - Exit`n"

    $operation = $True

    while($operation) {

        Write-Host $Prompt | Out-String
        $choose = Read-Host

        if($choose -eq 1){

            Write-Host ( getConfiguration | Format-Table | Out-String )
        
        }
        
        elseif($choose -eq 2){

            changeConfig

        }

        elseif($choose -eq 3){

            Write-Host "peace out" | Out-String

            exit
            $operation = $False

        }
        
        else{

            Write-Host "Not a valid choice" | Out-String

        }
    }
}

# configurationMenu