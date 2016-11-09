#
# load (dot-source) *.PS1 files, excluding unit-test scripts (*.Tests.*), and disabled scripts (__*)
#

@("$PSScriptRoot\Functions\*.ps1") | Get-ChildItem |
    Where-Object { $_.Name -like '*.ps1' -and $_.Name -notlike '__*' -and $_.Name -notlike '*.Tests*' } |
    % {

        # dot-source script
        # Write-Host "Loading $($_.BaseName)"
        . $_

        # export functions in the `Public` folder
        if ( (Split-Path( $_.Directory) -Leaf) -Eq 'Public' ) {
            # Write-Host "Exporting $($_.BaseName)"
            Export-ModuleMember $_.BaseName
        }

    }