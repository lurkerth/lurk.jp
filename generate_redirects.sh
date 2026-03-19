#!/bin/bash

OUTPUT_FILE="./public/_redirects"
: > "$OUTPUT_FILE"

if [[ -n "$REDIRECTS_JSON" ]]; then
  if command -v jq &>/dev/null; then
    echo "$REDIRECTS_JSON" | jq -r '.[] | "\(.route)  \(.target)  301"' >> "$OUTPUT_FILE"
  else
    echo "$REDIRECTS_JSON" | \
    sed -E 's/^\[|\]$//g' | \
    tr '}' '\n' | \
    sed -nE 's/.*"route":"([^"]+)","target":"([^"]+)".*/\1  \2  301/p' \
    >> "$OUTPUT_FILE"
  fi
fi
