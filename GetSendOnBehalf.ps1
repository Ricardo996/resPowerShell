
$date = Get-Date -Format "ddMMyyyy-HHmm"
$output = '.\mailboxPermissions-' + $date + '.csv'
$newCSV = {} | Select "Mailbox", "User", "Permission" | Export-Csv $output -NoTypeInformation
$csvFile = Import-CSV $output

Import-Module ExchangeOnlineManagement
$session = Connect-ExchangeOnline




$mailboxList = Get-Content "C:\Users\ricardo.lopes\OneDrive - Unipartner IT Services, S.A\Documents\Brisa\Script\MailBoxPermission\mailboxList.txt"

foreach ($mailbox in $mailboxList){
    $m = Get-Mailbox -identity $mailbox -ResultSize Unlimited |  ? {$_.GrantSendOnBehalfTo -ne $null} | select Name,Alias,UserPrincipalName,PrimarySmtpAddress,GrantSendOnBehalfTo 
   if($m.GrantSendOnBehalfTo -notlike $null){
    $csvFile.Mailbox = $mailbox
    $csvFile.User = $m.GrantSendOnBehalfTo
    $csvFile.Permission = "Send On Behalf"
    
    $csvFile | Export-Csv $output -Append -NoTypeInformation
    
    }
   
}