# DC01 - 192.168.11.3
# DC02 - 192.168.11.4
<#
    Import-Module .\HostsFileFunctions.ps1
    Add-HostsFileEntry -HostName DC01 -IPAddress 192.168.11.3
    Add-HostsFileEntry -HostName DC02 -IPAddress 192.168.11.4
#>
Function New-LabSessions {
    Param (
        [string[]]$Comps = @('DC01','DC02'),
        [string]$Domain = 'techsnipsdemo.org',
        [string]$Password = 'Somepass1'
    )
    $global:Sessions = @()
    $Cred = [pscredential]::new("$Domain\administrator",$securePassword)
    ForEach($Comp in $Comps){
        $securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        $global:Sessions += New-PSSession $comp -Credential $cred
    }
}