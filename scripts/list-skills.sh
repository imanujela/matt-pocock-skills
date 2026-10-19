#!/usr/bin/env bash
set -euo pipefail

# List from the repo root so the paths do not depend on the caller's cwd.
cd "$(cd "$(dirname "$0")/.." && pwd)"

find . -name SKILL.md -not -path '*/node_modules/*' | sed 's|^\./||' | sort
