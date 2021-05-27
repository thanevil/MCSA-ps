<#
    192201 - Alex
    Builds the OU structure
#>


Import-Module activedirectory

#region = [OU topology creation] = = = = = = = = = = = = = = = = = = = = = = = =

Get-Content .\OUStructure.txt | Foreach-Object {
  $domene = 'DC=cyber,DC=local'
  $alleOU = ''
  $ous = (Split-Path $_ -Parent).Split('\')
  [array]::Reverse($ous)
  $ous | Foreach-Object {
    if ($_.Length -eq 0) {
      return
    }
    $alleOU = $alleOU + 'OU=' + $_ + ','
  }
  $alleOU += $domene
  $nyOUNavn = Split-Path $_ -Leaf

  New-ADOrganizationalUnit -Name "$nyOUNavn" -Path "$alleOU" -ProtectedFromAccidentalDeletion $false
}
#endregion = [OU topology creation] = = = = = = = = = = = = = = = = = = = = = = = =

#region = [User accounts creation] = = = = = = = = = = = = = = = = = = = = = = = =
#Store the data from ADUsers.csv in the $ADUsers variable
$ADUsers = Import-csv '.\bulk_users1.csv'

#Loop through each row containing user details in the CSV file 
foreach ($User in $ADUsers)
{
	#Read user data from each field in each row and assign the data to a variable as below
		
	$Username 	= $User.username
	$Password 	= $User.password
	$Firstname 	= $User.firstname
	$Lastname 	= $User.lastname
	$OU 		= $User.ou #This field refers to the OU the user account is to be created in
    $email      = $User.email
    $streetaddress = $User.streetaddress
    $city       = $User.city
    $zipcode    = $User.zipcode
    $state      = $User.state
    $country    = $User.country
    $telephone  = $User.telephone
    $jobtitle   = $User.jobtitle
    $company    = $User.company
    $department = $User.department
    $Password = $User.Password


	#Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 #If user does exist, give a warning
		 Write-Warning "A user account with username $Username already exist in Active Directory."
	}
	else
	{
		#User does not exist then proceed to create the new user account
		
        #Account will be created in the OU provided by the $OU variable read from the CSV file
		New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@cyber.com" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -DisplayName "$Lastname, $Firstname" `
            -Path $OU `
            -City $city `
            -Company $company `
            -State $state `
            -StreetAddress $streetaddress `
            -OfficePhone $telephone `
            -EmailAddress $email `
            -Title $jobtitle `
            -Department $department `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $True
            
	}
}

#endregion = [User accounts creation] = = = = = = = = = = = = = = = = = = = = = = = =

#region = [Groups creation] = = = = = = = = = = = = = = = = = = = = = = = =


#endregion = [Goups creation] = = = = = = = = = = = = = = = = = = = = = = = =

