#!/bin/bash
# builds _redirects from REDIRECTS_JSON env var

out="./public/_redirects"
: > "$out"

if [[ -n "$REDIRECTS_JSON" ]]; then
  node -e "JSON.parse(process.env.REDIRECTS_JSON).forEach(r => console.log(r.route + '  ' + r.target + '  301'))" >> "$out"
fi
