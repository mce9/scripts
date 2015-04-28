Write-Host "Enter the full name for the user"
$name = Read-Host -Prompt "Name "

Write-Host "Enter the first name for the user"
$givenName = Read-Host -Prompt "First Name "

Write-Host "Enter the last name for the user"
$surName = Read-Host -Prompt "Last Name "

Write-Host "Enter the email address from the user"
$emailAddress = Read-Host - Prompt "Email address "

$samAccountName = "$givenName.$surName"
$userPrincipalName = $emailAddress.TrimEnd(".com")
$userPrincipalName = $userPrincipalName + ".local"

New-ADUser -Name $name -GivenName $givenName -Surname $surName -UserPrincipalName $userPrincipalName -SamAccountName $samAccountName -EmailAddress $emailAddress 

$pwd = Convertto-SecureString "ChangeMe1" -AsPlainText -Force
Set-ADAccountPassword -Identity $samAccountName -NewPassword $pwd
Set-ADUser -Identity $samAccountName -ChangePasswordAtLogon $true

Write-Host "The new user account has been assigned a temporary password of 'ChangeMe1' and will be required to change it when they log on for the first time."

Enable-ADAccount -Identity $samAccountName
