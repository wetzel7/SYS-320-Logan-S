$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.23/ToBeScraped.html

#print innertext of every div element that has the class as "div-1"
$divs1 = $scrapedPage.ParsedHtml.body.getElementsByTagName("div") | Where { `
$_.getAttributeNode("class").value -ilike "*div-1*"} | Select innerText

$divs1