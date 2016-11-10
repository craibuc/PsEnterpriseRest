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

### Query a Folder by ID

Version 4.1 of the RESTful SDK doesn't support full paths to the infoobjects, so queries need to use the object's ID (or CUID) to identify the object.

To get a folder's ID, right click the folder in the CMC and select Properties; locate the ID (circled in red):

[Properties!](Images/Folder Properties.png)

~~~powershell
# get the objects (e.g. folders, webi documents, Crystal Reports) in folder 9765
PS> $results = Get-InfoObject -Token $token -Path '9765/children'

# display the results
PS> $results.entries | Select-Object id,name,type,description
~~~

### Filter Objects by Type

~~~powershell
# get the Webi documents in folder 9765
PS> $results = Get-InfoObject -Token $token -Path '9765/children?type=Webi'

# display the results
PS> $results.entries | Select-Object id,name,type,description
~~~