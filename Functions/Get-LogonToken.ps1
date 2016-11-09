function Get-LogonToken {

	[CmdletBinding()]
	param(

        [Parameter(Position = 0, Mandatory = $true)]
        [string]$ServerName,

        [Parameter(Position = 1, Mandatory = $true)]
        [ValidateSet("secEnterprise", "secLDAP", "secWinAD")]
        [string]$Authentication,

        [Parameter(Position = 2, Mandatory = $true)]
        [string]$Username,

        [Parameter(Position = 3, Mandatory = $true)]
        [SecureString]$Password
	)

	BEGIN {
		Write-Debug $ServerName
		Write-Debug $Authentication
		Write-Debug $Username

		$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
		$plainTextPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

		# $assemblyPath='C:\Program Files (x86)\SAP BusinessObjects\SAP BusinessObjects Enterprise XI 4.0\win32_x86\dotnet\iPoint'
		$assemblyPath = $MyInvocation.MyCommand.Module.PrivateData.AssemblyPath
		Write-Debug $assemblyPath

		Add-Type -Path "$assemblyPath\CrystalDecisions.Enterprise.Framework.dll"
		Add-Type -Path "$assemblyPath\CrystalDecisions.Enterprise.InfoStore.dll"
	}

	PROCESS {

		[CrystalDecisions.Enterprise.EnterpriseSession]$session = $null

		try
		{
			$sessionMgr = New-Object CrystalDecisions.Enterprise.SessionMgr
			$session = $sessionMgr.Logon($username, $plainTextPassword, $ServerName, $authentication)
			$logonTokenMgr = $session.LogonTokenMgr

			# token valid on any workstation; for 24 hours(1440 minutes); for unlimited number of logins (-1)
			$token = $logonTokenMgr.CreateLogonTokenEx("", 1440, -1)
			Write-Verbose $token
			$token

		}

	    # catch [System.Runtime.InteropServices.COMException]
	    # {
	    #     # switch (e.ErrorCode)
	    #     # {
	    #     #     default:
	    #     #         WriteError(new ErrorRecord(e, e.Message, ErrorCategory.SecurityError, session));
	    #     #         break;
	    #     # }
	    #     WriteError(new ErrorRecord($_, $_.Message, [ErrorCategory]::SecurityError, $session))
	    # }

		catch
		{
			Throw $_
		}

	} # /PROCESS

	END {}

}
