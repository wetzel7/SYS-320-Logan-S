# Fuction: Get windows logs going back x days (User assigned)
#
# Input: Numeral assigned to X
# Output: Logs of the past x days

function PowerOnOffHist{
# assigning how many days to go back
$x = Read-Host "Get Power on and off times from the past ___ days"

#fetching last X days
$PowerOnOff = Get-EventLog -LogName System -source EventLog -After (Get-Date).AddDays(-$x) `
                | Where-Object {$_.EventID -eq 6006 -or $_.EventID -eq 6005}

$PowerOnOffTable=@() # empty array to fill custom
for($i=0; $i -lt $PowerOnOff.count; $i++){

# event property value
$event = ""
if($PowerOnOff[$i].EventID -eq 6005) {$event="PowerOn"}
if($PowerOnOff[$i].EventID -eq 6006) {$event="PowerOff"}

# User Value
$User = "System"

# adding new lines in form of custom objects in empty array
$PowerOnOffTable += [pscustomobject]@{"Time"= $PowerOnOff[$i].TimeWritten; `
                                       "Id"= $PowerOnOff[$i].EventID;  `
                                    "Event"= $event; `
                                     "User"= $User;
                                     }
} #End of for
return $PowerOnOffTable
}

