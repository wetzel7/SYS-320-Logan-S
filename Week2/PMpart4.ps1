# PowerShell Script to start an instance of Google Chrome and directs to Champlain.edu
# If chrome is already running, it kills it

# getting process
$processName = "chrome"
$Process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue

# Killing chrome if running
if ($process){
    Write-Host "$ProcessName is closing"
       get-process -Name "chrome" | stop-process
} 
# Starting chrome if not running
else {
    Write-Host "Starting $processName"
        Start-Process "chrome.exe" "https://champlain.edu"
    }