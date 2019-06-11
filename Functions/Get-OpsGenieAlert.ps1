Function Get-OpsGenieAlert {
    Param(
        [Parameter(Mandatory=$true)] [String]$Id
    )
    Write-Host "$($Script:BaseUrl)/v2/alerts/$Id/details?identifierType=id"
    $result = Invoke-RestMethodProxy -Method Get -Uri "$($Script:BaseUrl)/v2/alerts/$($Id)?identifierType=id" -Headers $Script:Headers
    return $result.data
}