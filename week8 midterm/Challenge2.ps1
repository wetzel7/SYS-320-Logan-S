# Challenge 2

Function AccessLogs(){
    
    # Read all lines from access log
    $AccessLog = (Get-Content $PSScriptRoot\access.log)

    # empty array to store parsed entries
    $table = @()

    # Loop over each line in log file 
    for ($i=0; $i -lt $AccessLog.Length; $i++){
    
    # splits log line into an array of words using split(" ")
    $words = $AccessLog[$i] -Split(" ");

    # custom powershell object for each log entry, and mapping each field to the position in the split line
    $table += [pscustomobject]@{ "IP" = $words[0]; `
                              "Time" = $words[3].trim('[');`
                              "Method" = $words[5].trim('"'); `
                              "Page" = $words[6]; `
                              "Protocol" = $words[7].trim('"'); `
                              "Response" = $words[8]; `
                              "Referrer" = $words[10]; ` 
                              "Client" = $words[11.. ($words.Length-1)]; }
                              }
    return $table 
    }

    # run function
#    AccessLogs | Select-Object IP, Time, Method, Page, Protocol, Response, Referrer | Format-Table