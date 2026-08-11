#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
VERSION=$("$SCRIPT_DIR/python_version.sh")

cd "$REPO_ROOT"

python -m venv env
source env/bin/activate
python -m pip install -r requirements.txt

# TODO: Find a better way to get the Python version from the virtual environment.
site_packages_source="env/lib/python$VERSION/site-packages"
if [[ ! -d "$site_packages_source" ]]; then
    printf 'Expected site-packages directory was not found: %s\n' "$site_packages_source" >&2
    exit 1
fi

rm -rf -- site-packages
mkdir -p site-packages
cp -a "$site_packages_source/." site-packages/
