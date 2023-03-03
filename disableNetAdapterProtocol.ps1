
AppSecret=sadasdasklkdklsadjdklasfgdg

$netAdapterList = Get-NetAdapter

foreach($netAdapter in $netAdapterList){
    Write-Host $netAdapter.Name
    If ($netAdapter.Name -match '^Wi-fi*' -or $netAdapter.Name -match '^Ethernet*'){
        Set-NetAdapterBinding -Name $netAdapter.Name -DisplayName "Microsoft Network Adapter Multiplexor Protocol" -Enabled $false
        Write-Host $netAdapter.Name + ": Microsoft Network Adapter Multiplexor Protocol disabled"
    
        Set-NetAdapterBinding -Name $netAdapter.Name -DisplayName "Microsoft LLDP Protocol Driver" -Enabled $false
        Write-Host $netAdapter.Name + ": Microsoft LLDP Protocol Driver disabled"
    
        Set-NetAdapterBinding -Name $netAdapter.Name -DisplayName "Internet Protocol Version 6 (TCP/IPv6)" -Enabled $false
        Write-Host $netAdapter.Name + ": Internet Protocol Version 6 (TCP/IPv6) disabled"
    
        Set-NetAdapterBinding -Name $netAdapter.Name -DisplayName "Link-Layer Topology Discovery Responder" -Enabled $false
        Write-Host $netAdapter.Name + ": Link-Layer Topology Discovery Responder disabled"
    
        Set-NetAdapterBinding -Name $netAdapter.Name -DisplayName "Link-Layer Topology Discovery Mapper I/O Driver" -Enabled $false
        Write-Host $netAdapter.Name + ": Link-Layer Topology Discovery Maper I/O Driver disabled"
    }
}

