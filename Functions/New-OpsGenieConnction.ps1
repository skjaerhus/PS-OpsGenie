Function New-OpsGenieConnection {
    Param(
        [string]$APIKey = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", 
        [string]$BaseUrl = "https://api.eu.opsgenie.com",
        [pscredential]$ProxyCredential,
        [string]$ProxyUrl
    )

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    
    if($ProxyUrl){
        $Script:proxyurl = $ProxyUrl
    }
    else{
        $dest = $BaseUrl
        $Script:proxyurl = ([System.Net.WebRequest]::GetSystemWebproxy()).GetProxy($dest)
        $Script:proxyurl
    }
    
    $Script:headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $Script:headers.Add("Authorization", 'GenieKey ' + $($APIKey))

    $Script:BaseUrl = $BaseUrl

    if($ProxyCredential){
        $Script:ProxyCredentials = $ProxyCredential
        Write-Host "Will Connect using credentials..."
    }

    Write-Host $Script:BaseUrl
}