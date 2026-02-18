function ScrapeChamplain (){

$ChampScrape = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.23/Courses2026SP.html

#get all the table row (tr) elements of html document
$trs=$champScrape.ParsedHtml.body.getElementsByTagName("tr")

# Empty array to hold the results
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){ #going over every tr element

    # Get every td element of current tr element
    $tds = $trs[$i].getElementsByTagName("td")

    # Seperate start time and end time from one time field
    $Times = $tds[5].innertext -split ("-")

    $FullTable += [PSCustomObject]@{ "Class Code" = $tds[0].innerText; `
                                      "Title" = $tds[1].innerText; `
                                      # "Credits" = $tds[2].innerText; `
                                      # "Seats" = $tds[3].innerText; `
                                      "Days" = $tds[4].innerText; `
                                      "Time Start" = $Times[0]; `
                                      "Time End" = $Times[1]; `
                                      "Instructor" = $tds[6].innerText; `
                                      "Location" = $tds[9].innerText; `
                                }
} #end of for loop
return $FullTable
}

function daysTranslator($FullTable){

#go over every record in the table
for($i=0; $i -lt $FullTable.length; $i++){

    #Empty array to hold days for every record
    $Days=@()

    # if M -> Monday
    if($FullTable[$i].Days -ilike "M*") { $Days += "Monday" }

    # if T followed by t, w,or f -> tuesday
    if($FullTable[$i].Days -ilike "*T[TWF]*") { $Days += "Tuesday" }
    # if only see T -> tuesday
    ElseIf($FullTable[$i].Days -ilike "T") { $Days += "Tuesday" }

    # if you see W -> wednesday
    if($FullTable[$i].Days -ilike "*W*") { $Days += "Wednesday" }
    
    # if you see TH thursday
    if($FullTable[$i].Days -ilike "*TH*") { $Days += "Thursday" }

    # F -> friday
    if($FullTable[$i].Days -ilike "*F") { $Days += "Friday" }

    #Switch
    $FullTable[$i].Days = $Days


    }
    return $FullTable
    }
    