#!/bin/bash

OUTPUT_FILE="./public/_redirects"

echo "" > "$OUTPUT_FILE"

if [[ -n "$REDIRECTS_JSON" ]]; then
  echo "$REDIRECTS_JSON" | \
  sed -E 's/^\[|\]$//g' | \
  tr '}' '\n' | \
  sed -nE 's/.*"route":"([^"]+)","target":"([^"]+)".*/\1  \2  301/p' \
  >> "$OUTPUT_FILE"
fi
