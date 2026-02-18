$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.23/ToBeScraped.html

# Get count of links in page
$pagelinks = $scrapedPage.Links.Count

Write-Host $pagelinks

