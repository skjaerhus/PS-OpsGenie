Function Update-OpsGenieAlertMessage {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Id,

        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    $details = @{
        "message" = $Message 
    }

    $jsondetails = ConvertTo-Json -InputObject $details

    $Uri = "$($Script:BaseUrl)/v2/alerts/$($Id)/message?identifierType=id"
    $result = Invoke-RestMethodProxy -ContentType 'application/json' -Method PUT -Uri $Uri -Body $jsondetails -Headers $Script:Headers 
    
    $result = get-OpsGenieRequestStatus -RequestId $result.requestId
    return $result
}