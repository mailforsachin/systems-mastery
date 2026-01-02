#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE="$BASE_DIR/templates/section-index.html"

declare -A ICON
declare -A TITLE
declare -A DESC

ICON[daily]="📅"
TITLE[daily]="Daily Notes"
DESC[daily]="Chronological learning log"

ICON[concepts]="📁"
TITLE[concepts]="Concepts"
DESC[concepts]="Concept deep dives"

ICON[labs]="🧪"
TITLE[labs]="Labs"
DESC[labs]="Experiments and prototypes"

ICON[diagrams]="🖼️"
TITLE[diagrams]="Diagrams"
DESC[diagrams]="Visual understanding"

ICON[templates]="📄"
TITLE[templates]="Templates"
DESC[templates]="Reusable patterns"

ICON[assets]="📦"
TITLE[assets]="Assets"
DESC[assets]="Supporting material"

ICON[scripts]="⚙️"
TITLE[scripts]="Scripts"
DESC[scripts]="Automation tools"

for dir in "${!TITLE[@]}"; do
  OUT="$BASE_DIR/$dir/index.html"

  FILES=$(ls "$BASE_DIR/$dir"/*.md 2>/dev/null || true)

  if [ -z "$FILES" ]; then
    CONTENT='<p class="empty">No files yet. Start adding content!</p>'
  else
    CONTENT="<ul>"
    for f in $FILES; do
      name="$(basename "$f")"
      CONTENT="$CONTENT<li><a href=\"$name\">$name</a></li>"
    done
    CONTENT="$CONTENT</ul>"
  fi

  sed \
    -e "s|{{ICON}}|${ICON[$dir]}|g" \
    -e "s|{{TITLE}}|${TITLE[$dir]}|g" \
    -e "s|{{DESCRIPTION}}|${DESC[$dir]}|g" \
    -e "s|{{CONTENT}}|$CONTENT|g" \
    "$TEMPLATE" > "$OUT"
done

echo "✅ Section indexes regenerated"
