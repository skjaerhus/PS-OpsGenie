function Get-OpsGenieRequestStatus {
    Param(
        [string]
        $RequestId
    )

    $i = 1
    Write-Progress -Activity "Getting Request Status for id: $($RequestId)" -Status "$i% Complete:" -PercentComplete $i;

    Start-Sleep -Milliseconds 1000 #give OpsGenie some spare time....
    $result = Invoke-RestMethodProxy -Method Get -Uri "$($Script:BaseUrl)/v2/alerts/requests/$($RequestId)" -Headers $Script:Headers -ErrorAction SilentlyContinue 
    
    #If ($result.result -eq "Request will be processed"){
    while ($result.result -eq "Request will be processed" -or $i -le 30){
        Start-Sleep -Seconds 1
        $result = Invoke-RestMethodProxy -Method Get -Uri "$($Script:BaseUrl)/v2/alerts/requests/$($RequestId)" -Headers $Script:Headers -ErrorAction SilentlyContinue 
        if ($result.data.success -eq "True" -or $result.data.success -eq "False") {
            $i = 100
        }
        Write-Progress -Activity "Getting Request Status for id: $($RequestId)" -Status "$i% Complete:" -PercentComplete $i;
        $i++

        #DEBUG:
        #$result
    }
    
    return $result.Data    
}