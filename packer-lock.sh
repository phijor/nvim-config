#!/bin/bash
set -e

LOCKFILE=${1:-Packer.lock}
LOCKPATH=$(readlink -m "$LOCKFILE")

echo "Writing lockfile to $LOCKPATH"
nvim -c ":PackerSnapshot $LOCKPATH"
echo "Sorting lockfile by plugin name"
cat "$LOCKPATH" | jq --sort-keys | sponge "$LOCKPATH"
