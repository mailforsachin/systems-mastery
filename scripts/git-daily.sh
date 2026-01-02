#!/bin/bash
set -e

DAY="$1"
TOPIC="$2"

git add .

if git diff --cached --quiet; then
  echo "No changes to commit"
  exit 0
fi

git commit -m "Day $DAY — $TOPIC"
git push origin master
