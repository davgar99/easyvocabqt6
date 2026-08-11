#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

# Ensure dependencies are installed and ready to go.
"$SCRIPT_DIR/install_deps.sh"

cd "$REPO_ROOT"

# Clean out Python bytecode caches to prevent their inclusion.
find . -type d -name '__pycache__' -prune -exec rm -rf -- {} +
find . -type f \( -name '*.pyc' -o -name '*.pyo' \) -delete

# Build deployment archive.
zip -9 -r easyvocab.ankiaddon \
    *.py \
    src/*.py \
    manifest.json \
    src/ui/*.py \
    src/assets/* \
    site-packages
