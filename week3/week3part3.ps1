# Get login and logoff records from win events

#fetching last 14 days
$loginouts=Get-EventLog -LogName System -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-14)

$loginoutsTable=@() #empty array to fill custom
for($i=0; $i -lt $loginouts.count; $i++){

# event property value
$event = ""
if($loginouts[$i].InstanceID -eq 7001) {$event="Logon"} 
if($loginouts[$i].InstanceID -eq 7002) {$event="Logoff"}

# awful code did not work
# $SID = $loginouts[$i].replacementStrings[1] | 
# $user = $SID.translate([System.Security.principal.NTAccount])
# $user.value

# super cool code did work, translating SID to User
$User = (New-Object System.Security.Principal.SecurityIdentifier `
            $loginouts[$i].ReplacementStrings[1]).Translate( `
             [System.Security.Principal.NTAccount])

# adding new lines in form of custom objects in empty array
$loginoutsTable += [pscustomobject]@{"Time"= $loginouts[$i].TimeWritten; `
                                       "Id"= $loginouts[$i].EventID;  `
                                    "Event"= $event; `
                                     "User"= $User;
                                     }
} #End of for

$loginoutstable
