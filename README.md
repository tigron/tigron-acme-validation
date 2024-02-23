# Tigron ACME validation scripts

Tigron provides an API which allows creating and deleting specifically
those records required to pass ACME validation.

This repository contains ready-made scripts to use with various ACME
clients.

Simply create an access token in your Tigron control panel under the
"Details" menu in the "Access tokens" tab, and pass it to the relevant
script.

Contact [support@tigron.be](mailto:support@tigron.be) for details and
support.

## acme.sh

The `dns_tigron.sh` script is a `dnsapi` plugin for
[acme.sh](https://acme.sh).

    TIGRON_TOKEN="FmD408PdqT1E269gUK57"

The documentation can be found [here](https://github.com/acmesh-official/acme.sh/wiki/DNS-API-Dev-Guide)

## win-acme

The [win-acme](https://www.win-acme.com/) tool provides similar
functionality the `acme.sh` script we use on Linux.

The `Tigron.ps` script is a [DNS validation](https://www.win-acme.com/reference/plugins/validation/dns/script)
script.

Example:

    .\wacs.exe --test --source manual --accepttos --emailaddress me@tigron.be --host test.demodomain.be --validationmode dns-01 --validation script --dnsscript C:\Tigron.ps1 --dnscreatescriptarguments "create {RecordName} {Token} MyTigronToken" --dnsdeletescriptarguments "delete {RecordName} {Token} MyTigronToken"

In the example above, replace `MyTigronToken` with the correct access token
for the given host(s). Creating the token can be done via the control panel,
under the "Details" menu in the "Access tokens" tab.
