Connect-AzureAD -Tenant cybermario.onmicrosoft.com
$appId="bcf62038-e005-436d-b970-2a472f8c1982" 
$sp=Get-AzureADServicePrincipal -Filter "appid eq '$($appid)'"
if ($sp -eq $null) { New-AzureADServicePrincipal -AppId $appId }
Start-Process "https://login.microsoftonline.com/common/adminconsent?client_id=$appId"

Connect-IPPSSession -UserPrincipalName mariocuomo@cybermario.onmicrosoft.com

Set-Mailbox -Identity mariocuomo@cybermario.onmicrosoft.com -CustomAttribute1 Elite

New-OrganizationSegment -Name "Elite" -UserGroupFilter "CustomAttribute1 -eq 'Elite'"
New-OrganizationSegment -Name "Other" -UserGroupFilter "CustomAttribute1 -ne 'Elite'"

New-InformationBarrierPolicy -Name "Elite-to-Elite" -AssignedSegment "Elite" -SegmentsAllowed "Elite" -State Inactive
New-InformationBarrierPolicy -Name "Other-Elite" -AssignedSegment "Other" -SegmentsBlocked "Elite" -State Inactive

Set-InformationBarrierPolicy -Identity "Elite-to-Elite" -State Active
Set-InformationBarrierPolicy -Identity "Other-Elite" -State Active

Start-InformationBarrierPoliciesApplication