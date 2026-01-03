#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TOPICS_FILE="$BASE_DIR/topics.txt"
DAY_FILE="$BASE_DIR/day.txt"

echo "DEBUG: BASE_DIR = $BASE_DIR"
echo "DEBUG: TOPICS_FILE = $TOPICS_FILE"
echo "DEBUG: DAY_FILE = $DAY_FILE"

# Initialize day counter
if [ ! -f "$DAY_FILE" ]; then
  echo "DEBUG: Creating day.txt with 1"
  echo "1" > "$DAY_FILE"
fi

DAY="$(cat "$DAY_FILE")"
echo "DEBUG: DAY = $DAY"

# Show what we're looking for
echo "DEBUG: Looking for 'Day $DAY:' in topics.txt"

# Show topics.txt content
echo "=== topics.txt content ==="
cat -n "$TOPICS_FILE"
echo "=========================="

# Debug awk command
echo "DEBUG: Running awk command..."
awk -v d="Day $DAY:" '
  BEGIN { print "DEBUG: Looking for pattern:", d }
  $0 ~ d { 
    print "DEBUG: Found matching line:", $0
    found=1; topic=$0; getline; next
  }
  found && /^Question:/ {
    print "DEBUG: Found Question line:", $0
    question=substr($0, index($0,":")+2)
    getline
    if (/^AI Task:/) {
      print "DEBUG: Found AI Task line:", $0
      ai_task=substr($0, index($0,":")+2)
      print topic "|" question "|" ai_task
      exit
    }
  }
' "$TOPICS_FILE"

