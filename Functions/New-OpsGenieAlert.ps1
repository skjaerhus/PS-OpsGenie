Function New-OpsGenieAlert {
    Param(
        [Parameter(Mandatory=$true)] [String]$Message,
        [String]$Description,
        [String]$Alias,
        [String]$Source,
        [String]$Entity,
        [Object]$Details, #When inputting an Object use the following if you run into errors ($Object | Convertto-Csv | Convertfrom-csv)
        [String]$Priority,
        [String]$Tags,
        [String]$Actions,
        [String]$Responders
    )
    
    $params = @{}
    $params.Add('message', $Message)
    
    if($Description){$params.Add('description', $Description)}
    if($Alias){$params.Add('alias', $Alias)}
    if($Source){$params.Add('source', $Source)}
    if($Entity){$params.Add('entity', $Entity)}
    if($Details){$params.Add('details', $Details)}
    if($Priority){$params.Add('priority', $Priority)}
    if($Tags){$params.Add('tags', $Tags)}
    if($Actions){$params.Add('actions', $Actions)}
    if($Responders){$params.Add('responders', $Responders)}
    
    $json = ConvertTo-Json -InputObject $params
    #write-host $json

    try {
        $result = Invoke-RestMethodProxy -Method Post -Uri "$($Script:BaseUrl)/v2/alerts" -Headers $Script:Headers -ContentType 'application/json' -Body $json #-Proxy $Script:proxyurl -ProxyUseDefaultCredentials
        $result = get-OpsGenieRequestStatus -RequestId $result.requestId
        return $result
    }
    catch {
        Write-Host "Error Creating Alert!"
        Write-Host "Exception Type: $($_.Exception.GetType().FullName) Exception Message: $($_.Exception.Message)"
        Write-Host "Data Payload:"
        $json
    }
}