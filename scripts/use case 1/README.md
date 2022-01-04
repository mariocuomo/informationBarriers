# Use case 1
An internal group that is prevented from communicating or sharing data with another specific internal team.

The departments of _literature_ and _engineering_ cannot communicate directly with the _administration_.

<div align="center">  
  <img src="https://github.com/mariocuomo/informationBarriers/blob/main/images/usecase1.png" width=450>
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
```

#### STEP 4 - CREATION OF POLICY

```PowerShell
New-InformationBarrierPolicy -Name "Engineering-Administration" -AssignedSegment "Engineering" -SegmentsBlocked "Administration" -State Inactive
New-InformationBarrierPolicy -Name "Literature-Administration" -AssignedSegment "Literature" -SegmentsBlocked "Administration" -State Inactive
New-InformationBarrierPolicy -Name "Administration-LiteratureEngineering" -AssignedSegment "Administration" -SegmentsBlocked "Engineering","Literature" -State Inactive
```

#### STEP 5 - SET STATE OF POLICY AS ACTIVE

```PowerShell
Set-InformationBarrierPolicy -Identity "Administration-LiteratureEngineering" -State Active
Set-InformationBarrierPolicy -Identity "Engineering-Administration" -State Active
Set-InformationBarrierPolicy -Identity "Literature-Administration" -State Active
```


#### STEP 6 - APPLY POLICIES

```PowerShell
Start-InformationBarrierPoliciesApplication
```
