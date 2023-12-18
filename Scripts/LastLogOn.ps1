#Checks last logon of a specific user
#Will first check through Get-ADUser, then through latest modified file
Import-Module -Name ActiveDirectory
Function LastUserLogOn {
    Param (
        [string]$UserName,
        [string]$Computer,
        [string]$FirstName,
        [string]$LastName
    )

    try {
        if (Test-Connection -ComputerName $Computer -Count 2 -Quiet) {
            Invoke-Command -ComputerName $Computer -ScriptBlock {
                Get-ADUser -Filter * -Properties "LastLogonDate" |
                Select-Object -First 1
            } | Write-Output
        } else {
            Write-Host "Computer $Computer is not reachable."
        }
    }
    catch {
        Write-Host "Oops, something went wrong :( it was this:"
        Write-Host $_.Exception.Message
    }
}