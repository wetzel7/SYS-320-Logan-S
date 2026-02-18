$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.23/ToBeScraped.html

#display only url and text
$scrapedPage.links | Select-Object -Property href, OuterText