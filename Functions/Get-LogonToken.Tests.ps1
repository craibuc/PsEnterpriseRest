Import-Module PsEnterpriseRest -Force
# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
# . "$here\$sut"

Describe "Get-LogonToken" {

	# arrange
	$server = Read-Host "Enter server"
	$authentication = 'secWinAD'
	
	Context "Valid credentials supplied" {

		$username = Read-Host "Enter username"
		$securePassword = Read-Host "Enter password" -AsSecureString

		It "Creates a logon token" {
			#act
			$actual = Get-LogonToken -Server $server -Authentication $authentication -Username $username -Password $securePassword -Verbose

			#assert
			$actual | Should Not BeNullOrEmpty
		}
	}

	Context "Invalid credentials supplied" {

		# arrange
		$username = 'foobar'
		$securePassword = ConvertTo-SecureString 'barfoo' -AsPlainText -Force

		It "Throws an exception" {
			#act/asset
			{ Get-LogonToken -Server $server -Authentication $authentication -Username $username -Password $securePassword -Verbose } | Should Throw
		}
	}

}
