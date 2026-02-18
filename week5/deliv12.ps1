$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.23/ToBeScraped.html 

$h2Elements = $scrapedPage.ParsedHtml.body.getElementsByTagName("h2") |Select-Object -Property Outertext
 
$h2Elements