# Challenge 3

. (Join-Path $PSScriptRoot Challenge1.ps1)
. (Join-Path $PSScriptRoot Challenge2.ps1)


function Get-Matches {
    param(
        $table,    # Parsed access log entires from AccessLog array
        $IOCTable  # IOC pattern objects from scraped html
    )

    # empty array
    $matches = @()

    # loop over all entries in access log
    foreach ($log in $table) {
       
       # for each log entry check against patterns from IOC html
       foreach ($ioc in $IOCTable) {
       
       # if the url has IOC patterns add it to matches
        if ($log.Page -like "*$($ioc.Pattern)*") {
            $matches += $log 
            break
            }
        }
    }

    return $matches

}

Get-Matches -Table (AccessLogs) -IOCTable (Get-HTML) | Format-Table 