#!/usr/bin/env bash
#
# Generate rh-manifest.txt file.
# Run from repository root.
set -e
set -u

WORKING_FILE="$(mktemp /tmp/rh-manifest.XXXXXXXX)"

find . -name package.json -execdir yarn list --silent --json \; | \
	jq -r '.. | objects | .name? | select(. != null)' \
	   >>"${WORKING_FILE}"

sort "${WORKING_FILE}" | uniq > rh-manifest.txt
