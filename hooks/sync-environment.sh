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

    # Copy skill directories — handle both real dirs and broken plugin symlinks
    if [ "$dir" = "skills" ]; then
      # Use ls to get all entries including broken symlinks (glob skips them)
      while IFS= read -r skill_name; do
        skill_path="$src/$skill_name"
        if [ -d "$skill_path" ]; then
          # Valid directory or resolvable symlink — copy with symlink dereferencing
          mkdir -p "$dest/$skill_name"
          rsync -aL --exclude='.git' "$skill_path/" "$dest/$skill_name/" 2>/dev/null || \
            cp -rL "$skill_path/" "$dest/$skill_name/" 2>/dev/null || true
        elif [ -L "$skill_path" ]; then
          # Broken symlink — resolve target relative to ~/.claude
          target=$(readlink "$skill_path")
          normalized="${target#../../}"
          normalized="${normalized#../}"
          resolved="$CLAUDE_DIR/$normalized"
          if [ -d "$resolved" ]; then
            mkdir -p "$dest/$skill_name"
            rsync -a --exclude='.git' "$resolved/" "$dest/$skill_name/" 2>/dev/null || \
              cp -r "$resolved/" "$dest/$skill_name/" 2>/dev/null || true
          else
            # Version mismatch — search plugin cache for the skill dir by name
            found=$(find "$CLAUDE_DIR/plugins/cache" -type d -name "$skill_name" 2>/dev/null | head -1)
            if [ -n "$found" ]; then
              mkdir -p "$dest/$skill_name"
              rsync -a --exclude='.git' "$found/" "$dest/$skill_name/" 2>/dev/null || \
                cp -r "$found/" "$dest/$skill_name/" 2>/dev/null || true
            fi
          fi
        fi
      done < <(ls "$src")
    fi

    # Copy agent files — dereference symlinks including broken relative paths
    if [ "$dir" = "agents" ]; then
      for agent_file in "$src"/*.md; do
        name=$(basename "$agent_file")
        if [ -f "$agent_file" ]; then
          # Valid file or resolvable symlink — copy directly
          cp -L "$agent_file" "$dest/$name"
        elif [ -L "$agent_file" ]; then
          # Broken symlink — try resolving relative to ~/.claude instead
          target=$(readlink "$agent_file")
          # Strip any number of leading ../ segments and resolve from ~/.claude
          normalized="${target#../../}"
          normalized="${normalized#../}"
          resolved="$CLAUDE_DIR/$normalized"
          if [ -f "$resolved" ]; then
            cp "$resolved" "$dest/$name"
          else
            # Version mismatch — search plugin cache for the file by name
            found=$(find "$CLAUDE_DIR/plugins/cache" -name "$name" -type f 2>/dev/null | head -1)
            if [ -n "$found" ]; then
              cp "$found" "$dest/$name"
            fi
          fi
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
