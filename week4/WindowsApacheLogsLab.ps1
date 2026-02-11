# This is the Windows Apache Logs class activity, to use any of these commands if found in
# github uncomment the desired line

# list all apache logs from xampp
# get-content C:\xampp\apache\logs\access.log

# display only logs containing 200 (OK)
# Get-Content C:\xampp\apache\logs\access.log | Select-string ' 200 '

# List only last 5 apache logs of xampp
# Get-Content -path "C:\xampp\apache\logs\access.log" -tail 5

# Display logs that contain 404 or 400
# Get-Content C:\xampp\apache\logs\access.log | Select-string ' 400 ', ' 404 '

# Display logs that does not contain 200
# Get-Content -path C:\xampp\apache\logs\access.log | Select-string -notmatch ' 200 '

# Display .log files strings with errors including lines
# Get-Childitem -path C:\xampp\apache\logs -filter "*.log" | select-string 'error'

# Display only IP addresses for 404 record errors (THIS CODE IS AWFUL DO NOT USE TS)
# Get-content "C:\xampp\apache\logs\access.log" | Select-string ' 404 ' | ForEach-Object { $_.Line.Split(' ')[0]}

# Count IPs from deliverable 6
$IPArray1 = Get-content "C:\xampp\apache\logs\access.log" | Select-string ' 404 ' 
$table=@()
for ($i=0; $i -lt $IPArray1.count; $i++){
$words = $IPArray1[$i] -Split(' ');
 $table += [pscustomobject]@{ "IP" = $words[0]; }
 }
 Write-Host ($table | group-object IP | Format-Table -AutoSize | Out-String)
 # $IPArray1[$i]
 