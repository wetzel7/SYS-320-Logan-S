$logsNotformatted = get-content C:\xampp\apache\logs\access.log | select-string ' 400 '
$tableRecords = @()

for ($i=0; $i -lt $logsNotformatted.Count; $i++){

#split
$words = $logsNotFormatted[$i].Split(" ")}
$words