#!/bin/sh
set -eu
: "${CORTEZA_ADMIN_EMAIL:?CORTEZA_ADMIN_EMAIL is required}"
: "${CORTEZA_ADMIN_PASSWORD:?CORTEZA_ADMIN_PASSWORD is required}"
mkdir -p "${STORAGE_PATH:-/data/store}"

corteza-server upgrade
if ! corteza-server users list | grep -Fq "$CORTEZA_ADMIN_EMAIL"; then
  corteza-server users add "$CORTEZA_ADMIN_EMAIL" --password "$CORTEZA_ADMIN_PASSWORD" --role super-admin --role admin --role low-code-admin
fi

unset CORTEZA_ADMIN_PASSWORD
exec corteza-server serve-api
