. (Join-Path $PSScriptRoot ScrapeChamplain.ps1)

$FullTable = ScrapeChamplain
$FullTable = daysTranslator $FullTable


# List All Classes that Furkan Teaches (Deliverable 1)
$FullTable | Select-Object  "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
             Where {$_.Instructor -like "Furkan Paligu"}
             
# List all classes that are in Freeman 105 on wed., only show class codes and times (Deliverable 2)
$FullTable | Where-Object { ($_.Location -ilike "FREE 105") -and ($_.days -ccontains "Wednesday") } | `
             Sort-Object "Time Start" | `
             Select-Object "Time Start", "Time End", "Class Code"

# Make a list of all instructors that teach at least 1 course in one of the courses SYS NET SEC FOR CSI DAT
# Sorted by name and made unique
$ITSInstructors = $FullTable | Where-Object {($_."Class Code" -ilike "SYS*") -or `
                                             ($_."Class Code" -ilike "NET*") -or `
                                             ($_."Class Code" -ilike "SEC*") -or `
                                             ($_."Class Code" -ilike "FOR*") -or `
                                             ($_."Class Code" -ilike "CSI*") -or `
                                             ($_."Class Code" -ilike "DAT*")} `
                             | Sort-Object "Instructor" | Select-Object "Instructor" -unique
$ITSInstructors

# Group all the instructors by the number of classes they're teaching, then sort by the number of classes they are teaching
$FullTable | where {$_.Instructor -in $ITSInstructors.Instructor} `
           | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending