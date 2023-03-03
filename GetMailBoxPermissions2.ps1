$password="asdasdas"
$date = Get-Date -Format "ddMMyyyy-HHmm"
$output = '.\mailboxPermissions-' + $date + '.csv'
$newCSV = {} | Select "Mailbox", "User", "Permissions", "IsInherited", "Deny" | Export-Csv $output -NoTypeInformation
$csvFile = Import-CSV $output

Import-Module ExchangeOnlineManagement
$session = Connect-ExchangeOnline

$mailboxList = Get-Content "C:\Users\ricardo.lopes\OneDrive - Unipartner IT Services, S.A\Documents\Brisa\Script\MailBoxPermission\mailboxList.txt"

foreach ($mailbox in $mailboxList){
    $listPermissions = Get-MailboxPermission -Identity $mailbox
    $listSendAs = Get-RecipientPermission -Identity $mailbox
    
    foreach ($permissions in $listPermissions){
        if($permissions.User -notlike "NT AUTHORITY\SELF"){
            $csvFile.Mailbox = $mailbox
            $csvFile.User = $permissions.User
            $csvFile.Permissions = $permissions.AccessRights
            $csvFile.IsInherited = $permissions.IsInherited
            $csvFIle.Deny = $permissions.Deny

            Write-Host $permissions.Identity + $permissions.User + $permissions.AccessRights + $permissions.IsInherited
            $csvFile | Export-Csv $output -Append -NoTypeInformation
        }
    }

    foreach ($sendAsPermission in $listSendAs){
        if($sendAsPermission.Trustee -notlike "NT AUTHORITY\SELF"){
            $csvFile.Mailbox = $mailbox
            $csvFile.User = $sendAsPermission.Trustee
            $csvFile.Permissions = $sendAsPermission.AccessRights
            $csvFile.IsInherited = $sendAsPermission.IsInherited
            $action = 0
            if($sendAsPermission.AccessControlType -like "Allow"){
                $action = "False"
            }else {
                $action = "True"
            }
            $csvFile.Deny = $action
            Write-Host $sendAsPermission.Identity + $sendAsPermission.Trustee + $sendAsPermission.AccessRights + $sendAsPermission.IsInherited + $sendAsPermission.AccessControlType + $action
            $csvFile | Export-Csv $output -Append -NoTypeInformation
        }
    }
}



Remove-PSSession $session