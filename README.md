# PsEnterpriseRest
Access SAP BI Platform's RESTful SDK

## Installation

### Manual

- Download most-recent [release](https://github.com/craibuc/PsEnterpriseRest/releases)
- Unpack archive
- Move folder to C:\Users\<your account>\Documents\WindowsPowerShell
- Rename folder to PsEnterpriseRest

### Git

~~~powershell
PS> cd ~\Documents\WindowPowerShell
PS> git clone https://github.com/craibuc/PsEnterpriseRest
~~~

## Usage

### Basics

~~~powershell
# import module into current PowerShell session
PS> Import-Module PsEnterpriseRest

# create a logon token and save in variable (you'll be prompted to supply the password)
PS> $token = Get-LogonToken -ServerName 'servername' -Authentication 'secWinAD' -Username 'username'
Password: *****

# query the infostore as desired (all objects in the 'All Folder' folder)
PS> $results = Get-InfoObject -Token $token -Path 'Root Folder/children'

# display the results
PS> $results.entries | Select-Object id,name,type,description
~~~
