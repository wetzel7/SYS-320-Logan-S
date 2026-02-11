$AccessLogNF = (Get-Content C:\xampp\apache\logs\access.log)
$table = @()

for ($i=0; $i -lt $AccessLogNF.Length; $i++){
    $words = $AccessLogNF[$i] -Split(" ");
    $table += [pscustomobject]@{ "IP" = $words[0]; `
                              "Time" = $words[3].trim('[');`
                              "Method" = $words[5].trim('"'); `
                              "Page" = $words[6]; `
                              "Protocol" = $words[7].trim('"'); `
                              "Response" = $words[8]; `
                              "Referrer" = $words[10]; ` 
                              "Client" = $words[11.. ($words.Length-1)]; }
                              }
                              
return $table | Where-Object {$_.IP -match "10.*" } | Format-Table -Autosize
