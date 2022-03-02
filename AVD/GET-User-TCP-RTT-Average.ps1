if (Get-Module -ListAvailable -Name PSTerminalServices) {
    Write-Host "Info: Module PSTerminalServices exists" -ForegroundColor Cyan
} 
else {
    Write-Host "Info: Module PSTerminalServices does not exist and will be installed now" -ForegroundColor Cyan
    Install-Module -Name PSTerminalServices
}
$Username = Read-Host -Prompt "Please enter a username (SAMAccountName)"
$UserSessionName = Get-TSSession -UserName $Username  | Select-Object WindowStationName
#$UserSessionName = Get-TSSession -UserName $env:USERName | Select-Object WindowStationName
$Session = $UserSessionName.WindowStationName.Split("#")
Clear-Variable Counter, Sum
$i=0
while ($i -ne 10){
   Write-Progress -Activity "Collecting Counters (10 times)" -PercentComplete $i -Status "Collecting"
   Start-Sleep -Milliseconds 100 
   $Counter = Get-Counter -Counter ('\\' + $env:COMPUTERNAME +'\remotefx network(' + $Session[0] + ' '+ $Session[1]+ ')\current tcp rtt')
   Start-Sleep -Seconds 10
   $Sum = $Sum + $Counter.CounterSamples.CookedValue
   $i++
}

$Average = $Sum/10
Write-Host "Username: $Username" -ForegroundColor Cyan 
Write-Host "RDP Session Average TCP RTT(ms): $Average" -ForegroundColor Cyan
