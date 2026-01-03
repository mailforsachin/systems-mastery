#!/bin/bash
set -e

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <day> <topic>"
  exit 1
fi

DAY="$1"
TOPIC="$2"
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

cd "$BASE_DIR"

echo "🔍 Checking for changes..."

# Check if there are any changes
if git diff --quiet && git diff --cached --quiet; then
  echo "📭 No changes to commit."
  exit 0
fi

# First, try to pull any remote changes
echo "🔄 Checking for remote updates..."
if git remote get-url origin >/dev/null 2>&1; then
  echo "📡 Pulling from remote..."
  if ! git pull --rebase origin master 2>/dev/null; then
    echo "⚠️  Could not rebase. Trying merge strategy..."
    git pull origin master --strategy-option=theirs || git pull origin master
  fi
else
  echo "ℹ️  No remote repository configured."
fi

# Add all changes
echo "➕ Adding changes..."
git add .

# Commit
COMMIT_MSG="Day ${DAY} — ${TOPIC}"
echo "💾 Committing: $COMMIT_MSG"
git commit -m "$COMMIT_MSG" || {
  echo "⚠️  Commit failed (maybe no changes to commit?)"
  exit 0
}

# Push if remote exists
if git remote get-url origin >/dev/null 2>&1; then
  echo "🚀 Pushing to GitHub..."
  if git push origin master; then
    echo "✅ Successfully pushed to GitHub!"
  else
    echo "⚠️  Push failed. Trying with force..."
    git pull origin master
    git push origin master || echo "❌ Push still failed. Check your git configuration."
  fi
else
  echo "ℹ️  No remote configured. Changes committed locally."
fi
