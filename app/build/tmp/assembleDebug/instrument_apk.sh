#!/bin/bash

# Usage: main APKIN APKOUT SPECS [APKSIGNER_ARGS...]
#
# Env vars required:
#   - TMPDIR: temporary directory for exclusive use by this script
#   - INSTRUMENTOR: path to instrumentor binary
#   - REDEX_PY: path to redex.py
#   - REDEX_CONFIG: path to a redex config.json file
#
# Other env vars:
#   - SIGN: sign APK if set
#   - DEBUG: be verbose if set
set -o errexit
set -o nounset
set -o pipefail

if [[ "${DEBUG:-undefined}" != undefined ]]; then
	set -o xtrace
fi

main() {
	apk_in="$1"
	shift
	apk_out="$1"
	shift
	specs="$1"
	shift

	in_dir="${TMPDIR}/in"
	out_dir="${TMPDIR}/out"
	mkdir -p "$in_dir" "$out_dir"

	/usr/bin/env python -- "$REDEX_PY" \
	        --redex-binary="$INSTRUMENTOR" \
		--config "$REDEX_CONFIG" \
		-SInstrumentAppPass.extraSpecs="$specs" \
		-o "$apk_out" \
		"$apk_in"

	if [[ "${SIGN:-undefined}" != undefined ]]; then
		apksigner sign "$@" "$apk_out"
	fi
}

main "$@"
