Function New-OpsGenieHeartbeatPing {
    Param(
        [string]
        $HeartbeatName
    )

    $result = Invoke-RestMethodProxy -Method Get -Uri "$($Script:BaseUrl)/v2/heartbeats/$($HeartbeatName)/ping" -Headers $Script:Headers #-Proxy $Script:proxyurl -ProxyUseDefaultCredentials
    return $result.data
}