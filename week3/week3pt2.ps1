# Get login and logoff records from win events

#fetching last 14 days
$loginouts=Get-EventLog -LogName System -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-14)

$loginoutsTable=@() #empty array to fill custom
for($i=0; $i -lt $loginouts.count; $i++){

# event property value
$event = ""
if($loginouts[$i].InstanceID -eq 7001) {$event="Logon"} 
if($loginouts[$i].InstanceID -eq 7002) {$event="Logoff"}

# user property value
$user = $loginouts[$i].replacementStrings[1]

# adding new lines in form of custom objects in empty array
$loginoutsTable += [pscustomobject]@{"Time"= $loginouts[$i].TimeWritten; `
                                       "Id"= $loginouts[$i].EventID;  `
                                    "Event"= $event; `
                                     "User"= $user;
                                     }
} #End of for

$loginoutstable
