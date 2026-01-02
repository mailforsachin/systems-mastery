#!/bin/bash
set -e

DAY="$1"
TOPIC="$2"
QUESTION="$3"

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DATE="$(date +%Y%m%d)"

if [ -z "$DAY" ] || [ -z "$TOPIC" ] || [ -z "$QUESTION" ]; then
  echo "Usage: new-daily.sh <day> <topic> <question>"
  exit 1
fi

mkdir -p "$BASE_DIR/daily"

CLEAN_TOPIC="$(echo "$TOPIC" | tr ' ' '-' | tr -cd '[:alnum:]-_')"
OUT="$BASE_DIR/daily/${DATE}-day${DAY}-${CLEAN_TOPIC}.md"

if [ -f "$OUT" ]; then
  echo "⚠️  Note already exists:"
  echo "   $OUT"
  exit 0
fi

cat > "$OUT" <<EOF_NOTE
# Day $DAY: $TOPIC
## Date: $DATE

## Today's Question
$QUESTION

## My Understanding
[Explain in your own words]

## Commands I Ran
\`\`\`bash
# commands here
\`\`\`

## Related to My Production Setup
- myjournal.omchat.ovh
- Nginx / VPS

## Questions for AI Architect
1.
2.

## Tomorrow's Focus
[What's next?]
EOF_NOTE

echo "📝 Created daily note:"
echo "   $OUT"
