#!/bin/bash
cd ~/systems-mastery

echo "=== Systems Mastery Setup Verification ==="
echo ""

echo "📅 Day counter:"
cat day.txt
echo ""

echo "📚 Topics file:"
head -10 topics.txt | grep -E "(Day|Question|AI Task)"
echo ""

echo "📁 Directory structure:"
echo "Directories created:"
for dir in daily assets concepts diagrams labs templates scripts _archive; do
  if [ -d "$dir" ]; then
    echo "  ✓ $dir/"
  else
    echo "  ✗ $dir/ (MISSING)"
  fi
done
echo ""

echo "🌐 Web files:"
if [ -f "index.html" ]; then
  echo "  ✓ index.html (main page)"
else
  echo "  ✗ index.html (MISSING)"
fi

for dir in daily assets concepts diagrams labs templates; do
  if [ -f "$dir/index.html" ]; then
    echo "  ✓ $dir/index.html"
  else
    echo "  ✗ $dir/index.html (MISSING)"
  fi
done
echo ""

echo "🤖 Scripts:"
for script in today.sh new-daily.sh new-guides.sh update-index.sh git-daily.sh; do
  if [ -x "scripts/$script" ]; then
    echo "  ✓ scripts/$script (executable)"
  else
    echo "  ✗ scripts/$script (MISSING or not executable)"
  fi
done
echo ""

echo "📊 File counts:"
echo "Daily files: $(find daily -name "*.md" 2>/dev/null | wc -l)"
echo "Assets files: $(find assets -name "*.md" 2>/dev/null | wc -l)"
echo "Concepts files: $(find concepts -name "*.md" 2>/dev/null | wc -l)"
echo "Diagrams files: $(find diagrams -name "*.md" 2>/dev/null | wc -l)"
echo "Labs files: $(find labs -name "*.md" 2>/dev/null | wc -l)"
echo "Templates files: $(find templates -name "*.md" 2>/dev/null | wc -l)"
echo ""

echo "💾 Git status:"
if [ -d ".git" ]; then
  echo "Git repository: ✓"
  echo "Remote URL: $(git remote get-url origin 2>/dev/null || echo "Not configured")"
  echo "Changes: $(git status --short | wc -l) files"
else
  echo "Git repository: ✗ (Not initialized)"
fi
echo ""

echo "✅ Setup complete! Visit: http://$(hostname -I | awk '{print $1}')/systems-mastery/"
