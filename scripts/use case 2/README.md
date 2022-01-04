# Use case 2
An internal group user must not communicate or share data with anyone outside the team itself.

The _treasury_ department cannot communicate externally.

<div align="center">  
  <img src="https://github.com/mariocuomo/informationBarriers/blob/main/images/usecase2.png" width=550>
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

#### STEP 3 - CREATION OF SEGMENTS

```PowerShell
New-OrganizationSegment -Name "Engineering" -UserGroupFilter "Department -eq 'Engineering'"
New-OrganizationSegment -Name "Literature" -UserGroupFilter "Department -eq 'Literature'"
New-OrganizationSegment -Name "Administration" -UserGroupFilter "Department -eq 'Administration'"
New-OrganizationSegment -Name "FrontOffice" -UserGroupFilter "Department -eq 'Front Office'"
New-OrganizationSegment -Name "Treasury" -UserGroupFilter "Department -eq 'Treasury'"
```

#### STEP 4a - CREATION OF POLICY FOR TREASURY

```PowerShell
New-InformationBarrierPolicy -Name "Treasury-to-Treasury" -AssignedSegment "Treasury" -SegmentsAllowed "Treasury" -State Inactive
# or New-InformationBarrierPolicy -Name "Treasury-to-Treasury" -AssignedSegment "Treasury" -SegmentsBlocked "Engineering","Literature","Administration","FrontOffice" -State Inactive
```

#### STEP 4b - CREATION OF POLICY FOR OTHER SEGMENTS

```PowerShell
New-InformationBarrierPolicy -Name "Engineering-Treasury" -AssignedSegment "Engineering" -SegmentsBlocked "Treasury" -State Inactive
New-InformationBarrierPolicy -Name "Literature-Treasury" -AssignedSegment "Litetarute" -SegmentsBlocked "Treasury" -State Inactive
New-InformationBarrierPolicy -Name "Administration-Treasury" -AssignedSegment "Administration" -SegmentsBlocked "Treasury" -State Inactive
New-InformationBarrierPolicy -Name "FrontOffice-Treasury" -AssignedSegment "FrontOffice" -SegmentsBlocked "Treasury" -State Inactive
```

#### STEP 5 - SET STATE OF POLICY AS ACTIVE

```PowerShell
Set-InformationBarrierPolicy -Identity "Treasury-to-Treasury" -State Active
Set-InformationBarrierPolicy -Identity "Engineering-Treasury" -State Active
Set-InformationBarrierPolicy -Identity "Literature-Treasury" -State Active
Set-InformationBarrierPolicy -Identity "Administration-Treasury" -State Active
Set-InformationBarrierPolicy -Identity "FrontOffice-Treasury" -State Active
```


#### STEP 6 - APPLY POLICIES

```PowerShell
Start-InformationBarrierPoliciesApplication
```
