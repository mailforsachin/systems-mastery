#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TOPICS_FILE="$BASE_DIR/topics.txt"
DAY_FILE="$BASE_DIR/day.txt"

# Initialize day counter
if [ ! -f "$DAY_FILE" ]; then
  echo "1" > "$DAY_FILE"
fi

DAY="$(cat "$DAY_FILE")"

# Extract topic + question
ENTRY=$(awk -v d="Day $DAY:" '
  $0 ~ d {found=1; topic=$0}
  found && /^Question:/ {
    print topic "|" substr($0, index($0,$2))
    exit
  }
' "$TOPICS_FILE")

if [ -z "$ENTRY" ]; then
  echo "🎉 No more topics found. Course complete."
  exit 0
fi

TOPIC="$(echo "$ENTRY" | cut -d'|' -f1 | sed 's/Day [0-9]*: //')"
QUESTION="$(echo "$ENTRY" | cut -d'|' -f2)"

echo "📅 Day $DAY"
echo "🎯 Topic   : $TOPIC"
echo "❓ Question: $QUESTION"
echo ""

"$BASE_DIR/scripts/new-daily.sh" "$DAY" "$TOPIC" "$QUESTION"
"$BASE_DIR/scripts/new-guides.sh" "$DAY" "$TOPIC" "$(date +%Y%m%d)" "$BASE_DIR"

# Update index
"$BASE_DIR/scripts/update-index.sh"

# Git auto-commit
"$BASE_DIR/scripts/git-daily.sh" "$DAY" "$TOPIC"

# Increment day
echo $((DAY + 1)) > "$DAY_FILE"
