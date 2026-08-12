#!/usr/bin/env bash
set -euo pipefail

VERSION=$(python --version | awk '{print $2}')

echo "$VERSION" | awk 'BEGIN {FS="."} {print $1 "." $2}'
