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

# Sync directories — copy real files only (skip broken symlinks, .git dirs)
for dir in "${SYNC_DIRS[@]}"; do
  src="$CLAUDE_DIR/$dir"
  dest="$REPO_DIR/$dir"
  if [ -d "$src" ]; then
    # Clear destination to remove stale files
    rm -rf "$dest"
    mkdir -p "$dest"

    # Copy skill directories (each contains SKILL.md and possibly data/)
    if [ "$dir" = "skills" ]; then
      for skill_dir in "$src"/*/; do
        skill_name=$(basename "$skill_dir")
        # Skip if it's a broken symlink
        if [ -d "$skill_dir" ]; then
          # Remove embedded .git dirs before copying
          mkdir -p "$dest/$skill_name"
          rsync -a --exclude='.git' "$skill_dir" "$dest/$skill_name/" 2>/dev/null || \
            cp -R "$skill_dir" "$dest/$skill_name/" 2>/dev/null || true
        fi
      done
    fi

    # Copy agent files (only real files, not broken symlinks)
    if [ "$dir" = "agents" ]; then
      for agent_file in "$src"/*.md; do
        if [ -f "$agent_file" ] && [ ! -L "$agent_file" ]; then
          cp "$agent_file" "$dest/"
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
