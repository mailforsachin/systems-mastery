#!/bin/bash
set -e

if [ "$#" -lt 4 ]; then
  echo "Usage: $0 <day> <topic> <date> <base_dir>"
  exit 1
fi

DAY="$1"
TOPIC="$2"
DATE="$3"
BASE_DIR="$4"

# Clean topic for filenames
SAFE_TOPIC="$(echo "$TOPIC" | tr ' ' '-' | tr -cd '[:alnum:]-' | sed 's/--*/-/g')"

# Create directories if they don't exist
mkdir -p "$BASE_DIR/assets"
mkdir -p "$BASE_DIR/concepts" 
mkdir -p "$BASE_DIR/diagrams"
mkdir -p "$BASE_DIR/labs"
mkdir -p "$BASE_DIR/templates"

# Create guide files
create_guide() {
  local type="$1"
  local dir="$2"
  local filename="${DATE}-day${DAY}-${SAFE_TOPIC}_${type}.md"
  local filepath="$dir/$filename"
  
  cat > "$filepath" << GUIDE
# Day ${DAY}: ${TOPIC} - ${type}
**Date:** ${DATE}

## 📋 Overview
*(Add ${type} overview here)*

## 🎯 Key Points
1. 
2. 
3. 

## 🔍 Details
*(Add detailed ${type} content here)*

## 💡 Examples
\`\`\`
# Example code or configuration
\`\`\`

## 📚 References
- 
GUIDE
  
  echo "Created ${type}: $(basename "$filepath")"
}

# Create all guide types
create_guide "ASSETS" "$BASE_DIR/assets"
create_guide "CONCEPTS" "$BASE_DIR/concepts"
create_guide "DIAGRAMS" "$BASE_DIR/diagrams"
create_guide "LABS" "$BASE_DIR/labs"
create_guide "TEMPLATES" "$BASE_DIR/templates"

# Also create section index.html files if they don't exist
for dir in assets concepts diagrams labs templates; do
  if [ ! -f "$BASE_DIR/$dir/index.html" ]; then
    cat > "$BASE_DIR/$dir/index.html" << HTML
<!DOCTYPE html>
<html>
<head>
    <title>${dir^} - Systems Mastery</title>
    <style>
        body { font-family: sans-serif; margin: 40px; }
        h1 { color: #333; }
        ul { list-style: none; padding: 0; }
        li { margin: 10px 0; }
        a { color: #0366d6; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>📁 ${dir^}</h1>
    <ul>
        <!-- Files will be listed here by update-index.sh -->
    </ul>
    <p><a href="../index.html">← Back to Home</a></p>
</body>
</html>
HTML
  fi
done
