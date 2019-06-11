Add-Type -AssemblyName 'Microsoft.PowerShell.Commands.Utility, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'
function Invoke-RestMethodProxy
{
    param(
        [Parameter(Mandatory=$true)][string]$Uri,
        [Object]$Body,
        [String]$ContentType,
        [PSCredential]$Credential,
        [System.Collections.IDictionary]$Headers,
        [String]$InFile,
        [Int32]$MaximumRedirection,
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method,
        [String]$OutFile,
        [String]$SessionVariable,
        [Int32]$TimeoutSec,
        [String]$TransferEncoding,
        [String]$UserAgent,
        [ Microsoft.PowerShell.Commands.WebRequestSession]$Session
    )

    If($Script:proxyurl){
        Write-host "Using Proxy: $($Script:proxyurl)"
        if($Script:ProxyCredentials){
            $p=@{Proxy= $Script:proxyurl; ProxyCredential=$Script:ProxyCredentials}
            #Write-Host "Connecting using credentials..."
        }
        else {
            $p=@{Proxy= $Script:proxyurl; ProxyUseDefaultCredentials=$true}
            #Write-Host "Connecting using default credentials..."
        }
    }
    else {
        $p = @{}
    }

    $PSBoundParameters.GetEnumerator() | ForEach-Object{ $p.Add( $_.Key, $_.Value) }
    Invoke-RestMethod @p
}