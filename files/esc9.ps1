param(
    [Parameter(Mandatory=$true)]
    [string]$esc9user
)

# Get DistinguishedNames
$domainUsers = Get-ADGroup -Identity "$((Get-ADDomain).DomainSID)-513"
$domainUsersDN = $domainUsers.DistinguishedName
$domainUsersName = $domainUsers.Name
$esc9userDN = (Get-ADUser -Identity $esc9user).DistinguishedName

#Add GenericAll rights over the esc9user to the Domain Users group
dsacls "$esc9userDN" /G "$domainUsersDN"":GA" | Select-String -Pattern $domainUsersName
