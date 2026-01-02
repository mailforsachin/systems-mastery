#!/bin/bash
set -e

DAY="$1"
TOPIC="$2"
DATE="$3"
BASE_DIR="$4"

SAFE_TOPIC="$(echo "$TOPIC" | tr ' ' '-' | tr -cd '[:alnum:]-_')"

create() {
  DIR="$1"
  SUFFIX="$2"
  CONTENT="$3"

  mkdir -p "$BASE_DIR/$DIR"
  FILE="$BASE_DIR/$DIR/${DATE}-day${DAY}-${SAFE_TOPIC}_${SUFFIX}.md"

  if [ ! -f "$FILE" ]; then
    cat > "$FILE" <<EOF_FILE
# $TOPIC — $SUFFIX

$CONTENT
EOF_FILE
  fi
}

create "concepts" "CONCEPTS" \
"## ONLY WHEN A PATTERN EMERGES

Create a concept **only if** you notice this thought:

> “Ah… this keeps coming up.”

### Triggers
- You’ve written about this 3–4 times
- You keep explaining it to yourself
- It finally feels *stable*

### Goal
A calm, reusable explanation future-you can rely on.
"

create "labs" "LABS" \
"## ONLY WHEN YOU EXPERIMENT

Create a lab **only if** you actually test something.

### Examples
- Change a config
- Break something on purpose
- Compare behaviors
- Measure performance

### Each lab answers:
- What did I try?
- What did I expect?
- What actually happened?
- What surprised me?
"

create "templates" "TEMPLATES" \
"## ONLY WHEN STRUCTURE REPEATS

Create a template if you think:

> “I don’t want to think about format again.”

Examples:
- Lab write-up
- Incident report
- Design analysis
"

create "diagrams" "DIAGRAMS" \
"## ONLY WHEN A VISUAL HELPS

Create a diagram if:
- Words feel insufficient
- Flow/order matters
- You’re explaining relationships

Hand-drawn → photo → SVG later is fine.
"

create "assets" "ASSETS" \
"## ONLY WHEN YOU COLLECT RESOURCES

Store:
- PDFs
- Reference screenshots
- External notes
- Sample files

Do NOT dump links here blindly.
"
