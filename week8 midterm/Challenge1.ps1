# Challenge 1

function Get-HTML {

    # setting url as a string parameter
    param([string]$URL = "http://10.0.17.6/IOC.html")

    $ScrapedPage = Invoke-WebRequest -TimeoutSec 10 $URL

    # get all table rows (tr elements) of the page
    $trs = $ScrapedPage.ParsedHtml.body.getElementsByTagName("tr")

    # empty array to hold results
    $IOCTable = @()

    for($i=1; $i -lt $trs.length; $i++){ #going over every tr element

        # get every cell's data (td) of the tr element
        $tds = $trs[$i].getElementsByTagName("td")

        $IOCTable += [PSCustomObject]@{
                         
                         "Pattern" = $tds[0].innerText
                         "Explanation" = $tds[1].innerText 
                     }
                }
    return $IOCTable
    }
    
#    Get-HTML | Format-Table -AutoSize