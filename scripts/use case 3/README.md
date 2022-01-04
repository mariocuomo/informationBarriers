# Use case 3
User segmentation using extended user features in Azure Active Directory.

Chosen elite students you want to isolate them to work on a secret project.

<div align="center">  
  <img src="https://github.com/mariocuomo/informationBarriers/blob/main/images/usecase3.png" width=300>
</div>

#### STEP 1 - ACCEPT INFORMATION BARRIERS PROCESSOR

```PowerShell
Connect-AzureAD -Tenant cybermario.onmicrosoft.com
$appId="bcf62038-e005-436d-b970-2a472f8c1982" 
$sp=Get-AzureADServicePrincipal -Filter "appid eq '$($appid)'"
if ($sp -eq $null) { New-AzureADServicePrincipal -AppId $appId }
Start-Process "https://login.microsoftonline.com/common/adminconsent?client_id=$appId"
```

#### STEP 2 - CONNECTION TO COMPLIANCE & SECURITY CENTER

```PowerShell
Connect-IPPSSession -UserPrincipalName mariocuomo@cybermario.onmicrosoft.com
```

#### STEP 3 - ADD CUSTOM ATTRIBUTES TO USERS

```PowerShell
Set-Mailbox -Identity mariocuomo@cybermario.onmicrosoft.com -CustomAttribute1 Elite
```

#### STEP 4 - CREATION OF SEGMENTS
```PowerShell
New-OrganizationSegment -Name "Elite" -UserGroupFilter "CustomAttribute1 -eq 'Elite'"
New-OrganizationSegment -Name "Other" -UserGroupFilter "CustomAttribute1 -ne 'Elite'"
```

#### STEP 5a - CREATION OF POLICY

```PowerShell
New-InformationBarrierPolicy -Name "Elite-to-Elite" -AssignedSegment "Elite" -SegmentsAllowed "Elite" -State Inactive
New-InformationBarrierPolicy -Name "Other-Elite" -AssignedSegment "Other" -SegmentsBlocked "Elite" -State Inactive
```

#### STEP 5 - SET STATE OF POLICY AS ACTIVE

```PowerShell
Set-InformationBarrierPolicy -Identity "Elite-to-Elite" -State Active
Set-InformationBarrierPolicy -Identity "Other-Elite" -State Active
```


#### STEP 6 - APPLY POLICIES

```PowerShell
Start-InformationBarrierPoliciesApplication
```
