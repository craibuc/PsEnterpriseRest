Import-Module PsEnterpriseRest -Force
# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
# . "$here\$sut"

Describe "Get-InfoObject" {

	# arrange
	$server = Read-Host "Enter server"
	$authentication = 'secWinAD'
	$username = Read-Host "Enter username"
	$securePassword = Read-Host "Enter password" -AsSecureString

	$token = Get-LogonToken -Server $server -Authentication $authentication -Username $username -Password $securePassword

	Context "Valid Uri supplied" {

		$path="infostore/Root Folder/children"

		It "Retrieves an array of PsCustomObjects" {

			# act
			$actual = Get-InfoObject -Token $token -Path $path -Verbose

			# assert
			$actual.GetType() | Should Be System.Management.Automation.PsCustomObject

			# $result.entries | % {
			#     [PsCustomObject]@{
			#         id=$_.id;
			#         cuid=$_.cuid;
			#         name=$_.name;
			#         description=$_.description
			#         type=$_.type;
			#         uri=$_.__metadata.uri
			#     }
			# } | select  name,type
		}

	} # /Context

	Context "Invalid Uri supplied" {

		$path="infostore/Root Folder/children"

		It "It throws an 404 exception" {

			# act / assert
			{  Get-InfoObject -Token $token -Path $path -Verbose} | Should Throw

		}

	} # /Context

	# Context "Webi documents" {
	# 	$path="raylight/v1/documents/"
	# }

}
