$host = ""
$name = "dyDNSClient (${host})"
$cred = Get-Credential -Message "ID/Pass for Google Domain"
$interval = New-TimeSpan -Hour 1

$action = {
	$response = Invoke-WebRequest -UseBasicParsing "http://ifconfig.me/ip"
	$ip = $response.Content
	$url = "https://domains.google.com/nic/update?hostname=$hostname&ip=$ip"
	Invoke-WebRequest -UseBasicParsing -Credential $cred $url
}
Register-ScheduledJob -ScriptBlock $action -Name "$name" -RunNow -RunEvery "$interval"
