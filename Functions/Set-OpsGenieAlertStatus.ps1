Function Set-OpsGenieAlertStatus{
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Id,

        [Parameter(Mandatory=$true)]
        [ValidateSet('UnAcknowlegded','Acknowlegded','Closed')]
        [string[]]
        $Status,

        [string]
        $Notes = ""
    )

    $Uri = ""
    if ($Status -eq "UnAcknowlegded"){
        $Uri = "$($Script:BaseUrl)/v2/alerts/$($Id)/unacknowledge?identifierType=id"
    }
    elseif ($Status -eq "Acknowlegded"){
        $Uri = "$($Script:BaseUrl)/v2/alerts/$($Id)/acknowledge?identifierType=id"
    }
    elseif ($Status -eq "Closed"){
        $Uri = "$($Script:BaseUrl)/v2/alerts/$($Id)/close?identifierType=id"
    }

    $Details = @{
        "user"      = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        "source"    = "PS Module"
        "note"      = $Notes
    }

    $jsondetails = $Details | ConvertTo-Json

    $result = Invoke-RestMethodProxy -ContentType 'application/json' -Method Post -Uri $Uri -Body $jsondetails -Headers $Script:Headers 
    $result = get-OpsGenieRequestStatus -RequestId $result.requestId
    return $result
}