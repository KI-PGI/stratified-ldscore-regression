#!/usr/bin/env bash
#
# calc_ld.sh
#
# Iterate over all BED files in a directory and compute LD‑scores
# for each cell type by calling the helper script
# `cell-type-ldscores.sh`.
#
# Usage:
#   ./calc_ld.sh /path/to/bed_directory
#
# Output:
#   /path/to/bed_directory/ldscores/<celltype_name>/
#
# Requirements:
#   - GNU coreutils (realpath)
#   - The script `cell-type-ldscores.sh` must be executable
#   - stratified-ldscore-regression environment set‑up
#

set -euo pipefail

# ----------------------------------------------------------------------
# 1 Input checking
# ----------------------------------------------------------------------
if [[ $# -ne 1 ]]; then
    echo "Error: Exactly one argument required – path to BED directory." >&2
    echo "Usage: $0 <BED_DIR>" >&2
    exit 1
fi

BED_DIR=$(realpath "$1")
OUTDIR="${BED_DIR}/ldscores"
mkdir -p "$OUTDIR"


LDS_DIR=$(dirname $0)
CELLTYPE_SCRIPT="$LDS_DIR/cell-type-ldscores.sh"

# ----------------------------------------------------------------------
# 2 Main loop
# ----------------------------------------------------------------------
shopt -s nullglob               # Make *.bed expand to nothing if no match
for BED_FILE in "${BED_DIR}"/*.bed; do
    [[ -f "$BED_FILE" ]] || continue

    FULL_PATH=$(realpath "$BED_FILE")
    CELLTYPE_NAME=$(basename "$BED_FILE" .bed)

    echo "Processing ${CELLTYPE_NAME}…" >&2
    sh "$CELLTYPE_SCRIPT" "$FULL_PATH" "${OUTDIR}/${CELLTYPE_NAME}"
done
shopt -u nullglob