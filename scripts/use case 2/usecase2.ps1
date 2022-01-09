Connect-AzureAD -Tenant cybermario.onmicrosoft.com
$appId="bcf62038-e005-436d-b970-2a472f8c1982" 
$sp=Get-AzureADServicePrincipal -Filter "appid eq '$($appid)'"
if ($sp -eq $null) { New-AzureADServicePrincipal -AppId $appId }
Start-Process "https://login.microsoftonline.com/common/adminconsent?client_id=$appId"

Connect-IPPSSession -UserPrincipalName mariocuomo@cybermario.onmicrosoft.com

New-OrganizationSegment -Name "Engineering" -UserGroupFilter "Department -eq 'Engineering'"
New-OrganizationSegment -Name "Literature" -UserGroupFilter "Department -eq 'Literature'"
New-OrganizationSegment -Name "Administration" -UserGroupFilter "Department -eq 'Administration'"
New-OrganizationSegment -Name "FrontOffice" -UserGroupFilter "Department -eq 'Front Office'"
New-OrganizationSegment -Name "Treasury" -UserGroupFilter "Department -eq 'Treasury'"

New-InformationBarrierPolicy -Name "Treasury-to-Treasury" -AssignedSegment "Treasury" -SegmentsAllowed "Treasury" -State Inactive
# or New-InformationBarrierPolicy -Name "Treasury-to-Treasury" -AssignedSegment "Treasury" -SegmentsBlocked "Engineering","Literature","Administration","FrontOffice" -State Inactive

New-InformationBarrierPolicy -Name "Engineering-Treasury" -AssignedSegment "Engineering" -SegmentsBlocked "Treasury" -State Inactive
New-InformationBarrierPolicy -Name "Literature-Treasury" -AssignedSegment "Litetarute" -SegmentsBlocked "Treasury" -State Inactive
New-InformationBarrierPolicy -Name "Administration-Treasury" -AssignedSegment "Administration" -SegmentsBlocked "Treasury" -State Inactive
New-InformationBarrierPolicy -Name "FrontOffice-Treasury" -AssignedSegment "FrontOffice" -SegmentsBlocked "Treasury" -State Inactive

Set-InformationBarrierPolicy -Identity "Treasury-to-Treasury" -State Active
Set-InformationBarrierPolicy -Identity "Engineering-Treasury" -State Active
Set-InformationBarrierPolicy -Identity "Literature-Treasury" -State Active
Set-InformationBarrierPolicy -Identity "Administration-Treasury" -State Active
Set-InformationBarrierPolicy -Identity "FrontOffice-Treasury" -State Active

Start-InformationBarrierPoliciesApplication