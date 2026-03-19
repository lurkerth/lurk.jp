#!/bin/bash
# builds netlify _redirects from REDIRECTS_JSON env var
# falls back to sed if jq isn't around

out="./public/_redirects"
: > "$out"

if [[ -n "$REDIRECTS_JSON" ]]; then
  if command -v jq &>/dev/null; then
    echo "$REDIRECTS_JSON" | jq -r '.[] | "\(.route)  \(.target)  301"' >> "$out"
  else
    echo "$REDIRECTS_JSON" |
      sed -E 's/^\[|\]$//g' |
      tr '}' '\n' |
      sed -nE 's/.*"route":"([^"]+)","target":"([^"]+)".*/\1  \2  301/p' >> "$out"
  fi
fi
