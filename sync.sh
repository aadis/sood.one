#!/usr/bin/env bash
# Copies notes tagged `publish: true` from the Obsidian vault into content/
# Run this before committing/pushing: ./sync.sh

set -euo pipefail

# Default vault path (work laptop). Override per machine via .vault-path.local (git-ignored).
# To set up on a new machine: echo "/path/to/vault" > .vault-path.local
VAULT="/Users/aaditya.consultant/vaults/cautious-wiki"
if [[ -f "$(dirname "$0")/.vault-path.local" ]]; then
  VAULT="$(cat "$(dirname "$0")/.vault-path.local")"
fi
CONTENT="$(dirname "$0")/content"

# Wipe and rebuild content/ (keeps index.md)
find "$CONTENT" -name "*.md" ! -name "index.md" -delete

count=0
while IFS= read -r -d '' file; do
  if grep -qE '^publish:\s*true' "$file"; then
    # Relative path from vault root
    rel="${file#$VAULT/}"
    # Strip a leading numeric "N-" prefix from the top-level folder and lowercase
    # it, so 5-Posts/foo.md publishes at /posts/foo.md. Root files are untouched.
    if [[ "$rel" == */* ]]; then
      top="${rel%%/*}"
      rest="${rel#*/}"
      if [[ "$top" =~ ^[0-9]+-(.*)$ ]]; then
        top="$(printf '%s' "${BASH_REMATCH[1]}" | tr '[:upper:]' '[:lower:]')"
        rel="$top/$rest"
      fi
    fi
    dest="$CONTENT/$rel"
    mkdir -p "$(dirname "$dest")"
    cp "$file" "$dest"
    ((count++))
  fi
done < <(find "$VAULT" -name "*.md" -not -path "*/.obsidian/*" -print0)

echo "Synced $count note(s) to content/"
