#!/usr/bin/env bash
set -euo pipefail

# Installs skills from https://github.com/imanujela/matt-pocock-skills
# into:
#   ~/.claude/skills                         Claude Code (flat)
#   ~/.agents/skills                         Codex and other Agent Skills harnesses (flat)
#   $HERMES_HOME/skills/<bucket>/<name>      Hermes (keeps the bucket)
#
# Run from a checkout of this repo, or from anywhere. If this script is not
# inside the repo, it clones imanujela/matt-pocock-skills and links that.
# deprecated/ is skipped. misc/ is included so simplify-diff installs.
# in-progress/ is included so pressure-check installs.

CANONICAL="https://github.com/imanujela/matt-pocock-skills.git"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/../skills/engineering/deepen-picked/SKILL.md" ]; then
  REPO="$(cd "$SCRIPT_DIR/.." && pwd)"
else
  REPO="${XDG_CACHE_HOME:-$HOME/.cache}/imanujela-matt-pocock-skills"
  if [ -d "$REPO/.git" ]; then
    git -C "$REPO" pull --ff-only
  else
    git clone --depth 1 "$CANONICAL" "$REPO"
  fi
fi

FLAT_DESTS=("$HOME/.claude/skills" "$HOME/.agents/skills")

if [ -n "${HERMES_HOME:-}" ]; then
  HERMES_SKILLS="$HERMES_HOME/skills"
elif [ -n "${LOCALAPPDATA:-}" ]; then
  HERMES_SKILLS="$LOCALAPPDATA/hermes/skills"
else
  HERMES_SKILLS="$HOME/.hermes/skills"
fi

names=()
srcs=()
buckets=()
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  rel="${src#"$REPO/skills/"}"
  bucket="${rel%%/*}"
  names+=("$(basename "$src")")
  srcs+=("$src")
  buckets+=("$bucket")
done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -print0)

link_one() {
  local src="$1"
  local target="$2"
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    rm -rf "$target"
  fi
  ln -sfn "$src" "$target"
}

for dest in "${FLAT_DESTS[@]}"; do
  if [ -L "$dest" ]; then
    resolved="$(readlink -f "$dest" || true)"
    case "$resolved" in
      "$REPO"|"$REPO"/*)
        echo "error: $dest is a symlink into this repo ($resolved)." >&2
        exit 1
        ;;
    esac
  fi
  i=0
  while [ "$i" -lt "${#names[@]}" ]; do
    link_one "${srcs[$i]}" "$dest/${names[$i]}"
    echo "linked ${names[$i]} -> ${srcs[$i]} ($dest)"
    i=$((i + 1))
  done
done

i=0
while [ "$i" -lt "${#names[@]}" ]; do
  link_one "${srcs[$i]}" "$HERMES_SKILLS/${buckets[$i]}/${names[$i]}"
  echo "linked ${buckets[$i]}/${names[$i]} -> ${srcs[$i]} ($HERMES_SKILLS)"
  i=$((i + 1))
done

echo "installed from $CANONICAL"
echo "new: deepen-picked rewrite-agent-docs pressure-check simplify-diff"
