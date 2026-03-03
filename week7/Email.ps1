function sendAlertEmail($Body){

$From = "logan.savage@mymail.champlain.edu"
$To = "logan.savage@mymail.champlain.edu"
$Subject = "At Risk Account Report"

$Password = Get-Content "C:\Users\champuser\SYS-320-01-Logan-S\week7\file.txt" | ConvertTo-SecureString 
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-port 587 -UseSsl -Credential $Credential

}

# sendAlertEmail "Body of email"