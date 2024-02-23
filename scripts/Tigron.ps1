<#
.SYNOPSIS
Validation script for win-acme, using the Tigron API

.DESCRIPTION
Creates and deletes the required records to pass ACME validation with
the win-acme tool.

See https://www.win-acme.com/ for more information.

.PARAMETER RecordName
FQDN for the TXT record

.PARAMETER TxtValue
Value for the TXT record

.PARAMETER TigronToken
Your Tigron ACME API token

.PARAMETER ExtraParams
Overflow parameters (ignore)

.EXAMPLE

Tigron.ps1 create {RecordName} {Token} TigronToken

Tigron.ps1 delete {RecordName} {Token} TigronToken

.NOTES

#>
param(
	[string]$Task,
	[string]$RecordName,
	[string]$TxtValue,
	[string]$TigronToken
)

Function Add-DnsRecord {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,Position=0)]
        [string]$RecordName,
        [Parameter(Mandatory,Position=1)]
        [string]$TxtValue,
        [Parameter(Mandatory,Position=2)]
        [string]$TigronToken,
        [Parameter(ValueFromRemainingArguments)]
        $ExtraParams
    )

    $Call = "https://api.tigron.net/service/acme?token=$TigronToken&record=${RecordName}&value=${TxtValue}&action=create"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Write-Verbose "Calling create for ${RecordName}"
	$response = Invoke-RestMethod -URI $Call

	if (-not $response.success) {
		throw "Failed to add the record"
	}

    <#
    .SYNOPSIS
        Add a TXT record

    .DESCRIPTION
        Add a TXT record

    .PARAMETER RecordName
		FQDN for the TXT record

    .PARAMETER TxtValue
		Value for the TXT record

    .PARAMETER TigronToken
		Your Tigron ACME API token

    .PARAMETER ExtraParams
        Overflow parameters (ignore)

    .EXAMPLE
        Add-DnsRecord '_acme-challenge.test.example.com' 'valueOfTheTXTRecord' -TigronToken 'yourTigronToken'

        Adds the specified TXT record with the specified value.
    #>
}

Function Delete-DnsRecord {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,Position=0)]
        [string]$RecordName,
        [Parameter(Mandatory,Position=1)]
        [string]$TxtValue,
        [Parameter(Mandatory,Position=2)]
        [string]$TigronToken,
        [Parameter(ValueFromRemainingArguments)]
        $ExtraParams
    )

    $Call = "https://api.tigron.net/service/acme?token=$TigronToken&record=${RecordName}&value=${TxtValue}&action=delete"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Write-Host Calling delete for ${RecordName}
	$response = Invoke-RestMethod -URI $Call

	if (-not $response.success) {
		throw "Failed to delete the record"
	}

    <#
    .SYNOPSIS
        Delete a TXT record

    .DESCRIPTION
        Delete a TXT record

    .PARAMETER RecordName
		FQDN for the TXT record

    .PARAMETER TxtValue
		Value for the TXT record

    .PARAMETER TigronToken
		Your Tigron ACME API token

    .PARAMETER ExtraParams
        Overflow parameters (ignore)

    .EXAMPLE
        Delete-DnsRecord '_acme-challenge.test.example.com' 'valueOfTheTXTRecord' -TigronToken 'yourTigronToken'

        Delete the specified TXT record with the specified value.
    #>
}

if ($Task -eq 'create'){
	Add-DnsRecord $RecordName $TxtValue $TigronToken
}

if ($Task -eq 'delete'){
	Delete-DnsRecord $RecordName $TxtValue $TigronToken
}
