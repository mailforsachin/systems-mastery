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

echo "🔍 Looking for Day $DAY in topics.txt..."

# Simple bash-based parsing instead of awk
TOPIC=""
QUESTION=""
AI_TASK=""
FOUND_DAY=0

while IFS= read -r line; do
  # Look for Day line
  if [[ "$line" =~ ^Day[[:space:]]+$DAY:[[:space:]]*(.*) ]]; then
    FOUND_DAY=1
    TOPIC="${BASH_REMATCH[1]}"
    continue
  fi
  
  if [ $FOUND_DAY -eq 1 ]; then
    # Look for Question
    if [[ "$line" =~ ^Question:[[:space:]]*(.*) ]]; then
      QUESTION="${BASH_REMATCH[1]}"
      continue
    fi
    
    # Look for AI Task
    if [[ "$line" =~ ^AI[[:space:]]+Task:[[:space:]]*(.*) ]]; then
      AI_TASK="${BASH_REMATCH[1]}"
      break
    fi
  fi
done < "$TOPICS_FILE"

if [ -z "$TOPIC" ] || [ -z "$QUESTION" ]; then
  echo "🎉 No more topics found. Course complete."
  exit 0
fi

echo ""
echo "═══════════════════════════════════════════════════"
echo "📅 DAY $DAY"
echo "═══════════════════════════════════════════════════"
echo "🎯 TOPIC:    $TOPIC"
echo "❓ QUESTION: $QUESTION"
if [ -n "$AI_TASK" ]; then
  echo "🤖 AI TASK:  $AI_TASK"
fi
echo "═══════════════════════════════════════════════════"
echo ""

# Create the daily files
echo "📝 Creating daily files..."
"$BASE_DIR/scripts/new-daily.sh" "$DAY" "$TOPIC" "$QUESTION" "$AI_TASK"

# Create guide files
echo "📚 Creating guide files..."
"$BASE_DIR/scripts/new-guides.sh" "$DAY" "$TOPIC" "$(date +%Y%m%d)" "$BASE_DIR"

# Update indexes
echo "🔄 Updating indexes..."
"$BASE_DIR/scripts/update-index.sh"

# Git commit and push
echo "💾 Committing to Git..."
"$BASE_DIR/scripts/git-daily.sh" "$DAY" "$TOPIC"

# Increment day
echo $((DAY + 1)) > "$DAY_FILE"

echo ""
echo "✅ Day $DAY completed successfully!"
echo "📁 Files created in:"
echo "   - daily/"
echo "   - assets/"
echo "   - concepts/"
echo "   - diagrams/"
echo "   - labs/"
echo "   - templates/"
echo ""
echo "🌐 View at: http://$(hostname -I | awk '{print $1}')/systems-mastery/"
echo ""
echo "Next up: Day $((DAY + 1))"
