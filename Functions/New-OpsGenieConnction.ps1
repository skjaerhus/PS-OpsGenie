<#
.SYNOPSIS

Connects to an OpsGenie HTTP Integration.

.DESCRIPTION

Connects to OpsGenie using the API Key from an HTTP integration.

.INPUTS

None.

.OUTPUTS

None, saves script variables with needed information for the module.

.EXAMPLE

PS> New-OpsGenieConnection -APIKey xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
Connect without proxy and using default base url for OpsGenie EU Datacenter.

.EXAMPLE
PS> $mycred = get-credential
PS> New-OpsGenieConnection -APIKey xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -ProxyCredential $mycred -ProxyUrl "http://myproxy:8080"

Connect using proxy information.

.LINK

https://github.com/skjaerhus/PS-OpsGenie

#>
Function New-OpsGenieConnection {
    Param(
        [Parameter(Mandatory=$true)][string]$APIKey = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", 
        [string]$BaseUrl = "https://api.eu.opsgenie.com",
        [pscredential]$ProxyCredential,
        [string]$ProxyUrl
    )

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    
    if($ProxyUrl){
        $Script:proxyurl = $ProxyUrl
    }
    elseif(!$proxyurl -and !$ProxyCredential){
        #No Proxy defined and no credential, assuming no proxy, but check system info still.
        $dest = $BaseUrl
        $proxytest = ([System.Net.WebRequest]::GetSystemWebproxy()).GetProxy($dest)
        if ($proxytest.OriginalString -ne $BaseUrl){
            #Proxy detected, set details and use it.
            $Script:ProxyUrl = $proxytest
        }
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