$Password =  ConvertTo-SecureString -AsPlainText '@Password123' -Force
$OU = 'OU=KPIT,OU=Vendors,OU=QRB,DC=internal,DC=quorum-irb,DC=com'
$Company = 'Kinetiq'
$Department = 'Kinetiq IT'
$Manager = 'CN=Tiffany Kinkade,OU=Users,OU=QRB,DC=internal,DC=quorum-irb,DC=com'
$TelephoneNumber = '+91-99309988897'
$Logonscript = 'login.bat'




$KPIT =  Import-Csv -Path 'C:\ps\KPIT.csv'

# Create and add to groups from csv
$KPIT | ForEach-Object -Process {
    New-ADUser -Name $_.DisplayName -DisplayName $_.DisplayName -SamAccountName $_.SamAccountName -Path $OU -AccountPassword $Password -Description $_.Description -ChangePasswordAtLogon $false `
    -PasswordNeverExpires $true -CannotChangePassword $false -Enabled $true -GivenName $_.GivenName -Surname $_.Surname -UserPrincipalName $_.UPN -Department $Department -Company $Company -Manager $Manager -OfficePhone $TelephoneNumber `
    -ScriptPath $Logonscript -Title $_.Title -EmailAddress $_.Email
    Add-ADGroupMember -Identity $_.GroupToAdd -Members $_.SamAccountName 
}

