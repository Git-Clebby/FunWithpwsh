#Changes password and forces password change on next logon.
Import-Module -Name ActiveDirectory
Function ResetPword {
    Param (
        [string]$Criteria
    )
    try {
        Get-ADUser -Filter "-like $Criteria" | Set-ADAccountPassword -NewPassword (ConvertTo-SecureString -AsPlainText "Welcome123" -Force) -ChangePasswordAtLogon $true
    }
    catch {
        Write-Host "Please try again, search criteria not valid"
    }
    Finally {
        Write-Host "Password successfully reset to Welcome123, user forced to change password at next logon"
    }
}