# Use case 1
An internal group that is prevented from communicating or sharing data with another specific internal team.

The departments of _literature_ and _engineering_ cannot communicate directly with the _administration_.

<div align="center">  
  <img src="https://github.com/mariocuomo/informationBarriers/blob/main/images/usecase1.png" width=450>
</div>

### POWERSHELL
`
Connect-IPPSSession -UserPrincipalName mariocuomo@cybermario.onmicrosoft.com
`

`
Connect-AzureAD -Tenant cybermario.onmicrosoft.com
`
$appId="bcf62038-e005-436d-b970-2a472f8c1982" 
$sp=Get-AzureADServicePrincipal -Filter "appid eq '$($appid)'"
if ($sp -eq $null) { New-AzureADServicePrincipal -AppId $appId }
Start-Process "https://login.microsoftonline.com/common/adminconsent?client_id=$appId"

`

```PowerShell
Connect-AzureAD -Tenant cybermario.onmicrosoft.com
$appId="bcf62038-e005-436d-b970-2a472f8c1982" 
$sp=Get-AzureADServicePrincipal -Filter "appid eq '$($appid)'"
if ($sp -eq $null) { New-AzureADServicePrincipal -AppId $appId }
Start-Process "https://login.microsoftonline.com/common/adminconsent?client_id=$appId"
```
