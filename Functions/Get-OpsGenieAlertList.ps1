Function Get-OpsGenieAlertList {
    Write-Host "$($Script:BaseUrl)/v2/alerts?query=status%3Aopen"
    $result = Invoke-RestMethodProxy -Method Get -Uri "$($Script:BaseUrl)/v2/alerts?query=status%3Aopen" -Headers $Script:Headers 
    return $result.data
}