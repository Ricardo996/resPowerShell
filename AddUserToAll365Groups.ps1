Connect-ExchangeOnline

$m365GroupList = Get-UnifiedGroup

foreach($group in $m365GroupList){
    Add-UnifiedGroupLinks -Identity $group.PrimarySmtpAddress -LinkType "Members" -Links "user.brisa@MSDx008251.onmicrosoft.com"
}

Disconnect-ExchangeOnline -Confirm:$False