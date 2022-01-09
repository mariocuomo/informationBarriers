Connect-AzureAD -Tenant cybermario.onmicrosoft.com
$appId="bcf62038-e005-436d-b970-2a472f8c1982" 
$sp=Get-AzureADServicePrincipal -Filter "appid eq '$($appid)'"
if ($sp -eq $null) { New-AzureADServicePrincipal -AppId $appId }
Start-Process "https://login.microsoftonline.com/common/adminconsent?client_id=$appId"

Connect-IPPSSession -UserPrincipalName mariocuomo@cybermario.onmicrosoft.com

New-OrganizationSegment -Name "Engineering" -UserGroupFilter "Department -eq 'Engineering'"
New-OrganizationSegment -Name "Literature" -UserGroupFilter "Department -eq 'Literature'"
New-OrganizationSegment -Name "Administration" -UserGroupFilter "Department -eq 'Administration'"

New-InformationBarrierPolicy -Name "Engineering-Administration" -AssignedSegment "Engineering" -SegmentsBlocked "Administration" -State Inactive
New-InformationBarrierPolicy -Name "Literature-Administration" -AssignedSegment "Literature" -SegmentsBlocked "Administration" -State Inactive
New-InformationBarrierPolicy -Name "Administration-LiteratureEngineering" -AssignedSegment "Administration" -SegmentsBlocked "Engineering","Literature" -State Inactive

Set-InformationBarrierPolicy -Identity "Administration-LiteratureEngineering" -State Active
Set-InformationBarrierPolicy -Identity "Engineering-Administration" -State Active
Set-InformationBarrierPolicy -Identity "Literature-Administration" -State Active

Start-InformationBarrierPoliciesApplication