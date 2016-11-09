function Get-InfoObject {

	[CmdletBinding()]
	param(
		[Parameter(Position = 0, Mandatory = $true)]
		[string]$token,

		[Parameter(Position = 1, Mandatory = $true)]
		[string]$path='infostore'
	)

	BEGIN {
		Write-Debug $token

		$server = $MyInvocation.MyCommand.Module.PrivateData.Server
		Write-Debug $server

		$url="http://$server/biprws/$path"
		Write-Debug $url

		$client = New-Object System.Net.WebClient
		$client.Headers.Add("Accept","application/json")
		$client.Headers.Add("X-SAP-LogonToken",$token)
	}

	PROCESS {

		try {
			$result = $client.DownloadString($url) | ConvertFrom-Json
			$result 
		}
		catch [Net.WebException] {
			# $_.Exception | fl * -Force
			Write-Error $_.Exception.ToString()
		}
		catch [Exception]{
			# $_ | fl * -Force
			# Write-Error -Message $_.Message -Exception $_ -Category ObjectNotFound
			Write-Error $_.Exception.ToString()
		}
	}

	END {}

}
