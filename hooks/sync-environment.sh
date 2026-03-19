#!/bin/bash
# Syncs local ~/.claude environment to the claude-environment GitHub repo.
# Runs as a Claude Code SessionStart hook — silent on no changes.

set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
REPO_DIR="$HOME/.claude/cache/claude-environment-repo"
REMOTE="https://github.com/markj81/claude-environment.git"  # Change to your fork

# Files/dirs to sync (relative to ~/.claude)
SYNC_ITEMS=(
  "CLAUDE.md"
  "settings.json"
)
SYNC_DIRS=(
  "skills"
  "agents"
)

# Ensure repo is cloned
if [ ! -d "$REPO_DIR/.git" ]; then
  git clone "$REMOTE" "$REPO_DIR" 2>/dev/null || exit 0
fi

# Pull latest
cd "$REPO_DIR"
git pull --ff-only origin main 2>/dev/null || true

# Sync files
for item in "${SYNC_ITEMS[@]}"; do
  src="$CLAUDE_DIR/$item"
  if [ -f "$src" ]; then
    cp "$src" "$REPO_DIR/$item"
  fi
done

# Sync directories — dereference symlinks so plugin-installed content is included
for dir in "${SYNC_DIRS[@]}"; do
  src="$CLAUDE_DIR/$dir"
  dest="$REPO_DIR/$dir"
  if [ -d "$src" ]; then
    # Clear destination to remove stale files
    rm -rf "$dest"
    mkdir -p "$dest"

    # Copy skill directories — follow symlinks (handles plugin-installed skills)
    if [ "$dir" = "skills" ]; then
      for skill_dir in "$src"/*/; do
        skill_name=$(basename "$skill_dir")
        # Skip broken symlinks ([ -d ] follows symlinks, so broken ones return false)
        if [ -d "$skill_dir" ]; then
          mkdir -p "$dest/$skill_name"
          # -L dereferences symlinks; --exclude='.git' avoids embedded repos
          rsync -aL --exclude='.git' "$skill_dir" "$dest/$skill_name/" 2>/dev/null || \
            cp -rL "$skill_dir" "$dest/$skill_name/" 2>/dev/null || true
        fi
      done
    fi

    # Copy agent files — follow symlinks (handles plugin-installed agents)
    if [ "$dir" = "agents" ]; then
      for agent_file in "$src"/*.md; do
        # -f follows symlinks; skip only broken symlinks (where -f returns false)
        if [ -f "$agent_file" ]; then
          cp -L "$agent_file" "$dest/"
        fi
      done
    fi
  fi
done

# Sanitize settings.json — replace absolute home paths with ~
if [ -f "$REPO_DIR/settings.json" ]; then
  sed -i '' "s|$HOME|~|g" "$REPO_DIR/settings.json" 2>/dev/null || true
fi

# Check for changes
cd "$REPO_DIR"
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  # No changes
  exit 0
fi

# Stage, commit, and push
git add -A
git commit -m "Auto-sync Claude environment $(date +%Y-%m-%d)" 2>/dev/null || exit 0
git push origin main 2>/dev/null || true
