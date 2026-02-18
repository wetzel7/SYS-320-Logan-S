$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.23/ToBeScraped.html

# Get links in page
$scrapedPage.Links