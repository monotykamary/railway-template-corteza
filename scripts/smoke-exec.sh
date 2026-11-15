#!/bin/sh
set -eu
b=/railway-emul/busybox
base=${BASE_URL:-http://127.0.0.1:80}
state=${SMOKE_STATE:-/data/railway-product-proof}
phase=${SMOKE_PHASE:?}
case "$phase" in boot|upgrade|redeploy) ;; *) exit 2;; esac
token=${CORTEZA_TOKEN:-$(corteza-server auth jwt "$CORTEZA_ADMIN_EMAIL" 2>/dev/null | "$b" tail -n 1)}
[ -n "$token" ]
tmp=/tmp/corteza-proof-$$
"$b" mkdir -p "$tmp"
trap '"$b" rm -rf "$tmp"' EXIT INT TERM
api() {
  method=$1; path=$2; data=${3:-}
  if [ "$method" = POST ]; then
    "$b" wget -q -O "$tmp/response" --header "Authorization: Bearer $token" --header 'Content-Type: application/json' --post-data "$data" "$base/api/compose/$path"
  else
    "$b" wget -q -O "$tmp/response" --header "Authorization: Bearer $token" "$base/api/compose/$path"
  fi
  if "$b" grep -q '"error":{' "$tmp/response"; then echo 'Product API returned an error' >&2; exit 1; fi
}
id() { "$b" grep -o "\"$1\":\"[0-9]*\"" "$tmp/response" | "$b" head -n 1 | "$b" tr -cd '0-9'; }
if "$b" wget -q -O /dev/null "$base/api/compose/namespace/"; then echo 'Anonymous API request unexpectedly accepted' >&2; exit 1; fi
if [ "$phase" = boot ]; then
  [ ! -e "$state" ] || { echo 'Refusing to replace original state' >&2; exit 1; }
  api POST namespace/ '{"name":"Railway proof 20261115","slug":"railway-proof-20261115","enabled":true}'
  ns=$(id namespaceID); [ -n "$ns" ]
  api POST "namespace/$ns/module/" '{"name":"Proof","handle":"proof","fields":[{"name":"marker","kind":"String","isMulti":false}]}'
  mod=$(id moduleID); [ -n "$mod" ]
  api POST "namespace/$ns/module/$mod/record/" '{"values":[{"name":"marker","value":"railway-persistence-20261115"}]}'
  rec=$(id recordID); [ -n "$rec" ]
  printf '%s %s %s\n' "$ns" "$mod" "$rec" > "$state"
else
  [ -s "$state" ] || { echo 'Missing original seed: refusing to reseed' >&2; exit 1; }
  set -- $("$b" cat "$state"); ns=$1; mod=$2; rec=$3
fi
api GET "namespace/$ns/module/$mod/record/$rec"
"$b" grep -q 'railway-persistence-20261115' "$tmp/response"
echo "PASS Corteza namespace/module/record API persistence: $phase"
