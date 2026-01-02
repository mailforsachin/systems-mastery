#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DAILY_DIR="$BASE_DIR/daily"
OUT="$DAILY_DIR/index.html"

echo "🛠 Updating daily index..."

{
cat <<'HTML'
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Daily Notes</title>
  <style>
    body {
      font-family: system-ui, -apple-system, sans-serif;
      max-width: 800px;
      margin: 40px auto;
      padding: 20px;
    }
    a { color: #2563eb; text-decoration: none; }
    a:hover { text-decoration: underline; }
    .back {
      display: inline-block;
      margin-bottom: 20px;
      padding: 6px 12px;
      background: #f3f4f6;
      border-radius: 6px;
    }
    h1 { margin-top: 10px; }
    h2 {
      margin-top: 30px;
      border-bottom: 1px solid #e5e7eb;
      padding-bottom: 4px;
    }
    ul { list-style: none; padding-left: 0; }
    li { margin: 6px 0; }
  </style>
</head>
<body>

<div class="back">
  <a href="../">← Back to Home</a>
</div>

<h1>📅 Daily Notes</h1>
<p>Chronological learning log</p>

HTML

# Group files by date
ls *.md 2>/dev/null | sort | awk -F- '
{
  date=$1
  if (date != last) {
    if (last != "") print "</ul>"
    print "<h2>" substr(date,1,4) "-" substr(date,5,2) "-" substr(date,7,2) "</h2>"
    print "<ul>"
    last=date
  }
  printf "<li><a href=\"%s\">%s</a></li>\n", $0, $0
}
END { if (last != "") print "</ul>" }
'

cat <<'HTML'
</body>
</html>
HTML
} > "$OUT"

echo "✅ Daily index updated."
