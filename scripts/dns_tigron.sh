#!/usr/bin/env sh

# Validation script for acme.sh, using the Tigron API
#
# Provide the required ACME token like this:
# TIGRON_TOKEN="FmD408PdqT1E269gUK57"

TIGRON_API="https://api.tigron.net/service/acme"

########  Public functions #####################

#Usage: add  _acme-challenge.www.domain.com   "XKrxpRBosdIKFzxW_CT3KLZNf6q0HG9i01zxXp5CPBs"
dns_tigron_add() {
  record=$1
  value=$2

  TIGRON_TOKEN="${TIGRON_TOKEN:-$(_readaccountconf_mutable TIGRON_TOKEN)}"
  if [ -z "$TIGRON_TOKEN" ]; then
    TIGRON_TOKEN=""
    _err "Please set TIGRON_TOKEN and try again."
    return 1
  fi
  _saveaccountconf_mutable TIGRON_TOKEN "$TIGRON_TOKEN"

  _info "Adding TXT record to ${record}"
  response="$(_get "$TIGRON_API?token=$TIGRON_TOKEN&record=${record}&value=${value}&action=create")"
  if _contains "${response}" 'success'; then
    return 0
  fi
  _err "Could not create resource record, check logs"
  _err "${response}"
  return 1
}

# Usage: fulldomain txtvalue
dns_tigron_rm() {
  record=$1
  value=$2

  TIGRON_TOKEN="${TIGRON_TOKEN:-$(_readaccountconf_mutable TIGRON_TOKEN)}"
  if [ -z "$TIGRON_TOKEN" ]; then
    TIGRON_TOKEN=""
    _err "Please set TIGRON_TOKEN and try again"
    return 1
  fi
  _saveaccountconf_mutable TIGRON_TOKEN "$TIGRON_TOKEN"

  _info "Deleting resource record $record"
  response="$(_get "$TIGRON_API?token=$TIGRON_TOKEN&record=${record}&value=${value}&action=delete")"
  if _contains "${response}" 'success'; then
    return 0
  fi
  _err "Could not delete record"
  _err "${response}"
  return 1
}
