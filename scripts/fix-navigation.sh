#!/bin/bash
# This creates proper index.html files for web navigation

BASE="$(cd "$(dirname "$0")/.." && pwd)"

# Function to create index.html for a directory
create_index() {
    local dir="$1"
    local title="$2"
    local description="$3"
    
    cat > "$dir/index.html" << HTML
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>$title - Systems Mastery</title>
    <style>
        body { font-family: sans-serif; max-width: 800px; margin: 40px auto; padding: 20px; }
        a { color: #2563eb; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .back { margin-bottom: 20px; display: inline-block; padding: 5px 10px; background: #f3f4f6; border-radius: 5px; }
        ul { list-style: none; padding: 0; }
        li { margin: 8px 0; padding: 5px; }
        li:hover { background: #f9fafb; }
        .empty { color: #6b7280; font-style: italic; }
    </style>
</head>
<body>
    <div class="back">
        <a href="../">← Back to Home</a>
    </div>
    
    <h1>📁 $title</h1>
    <p>$description</p>
    
    <ul>
HTML

    # List all files (except index.html) and directories
    local has_content=false
    
    # List directories first
    find "$dir" -maxdepth 1 -type d ! -name "." ! -path "$dir" | sort | while read -r subdir; do
        has_content=true
        subdir_name=$(basename "$subdir")
        echo "        <li>📁 <a href=\"$subdir_name/\">$subdir_name/</a></li>" >> "$dir/index.html"
    done
    
    # List files
    find "$dir" -maxdepth 1 -type f ! -name "index.html" ! -name ".*" | sort | while read -r file; do
        has_content=true
        filename=$(basename "$file")
        # URL encode spaces for links
        encoded_filename=$(echo "$filename" | sed 's/ /%20/g')
        echo "        <li>📄 <a href=\"$encoded_filename\">$filename</a></li>" >> "$dir/index.html"
    done
    
    if [ "$has_content" = false ]; then
        echo "        <li class=\"empty\">No files yet. Start adding content!</li>" >> "$dir/index.html"
    fi
    
    cat >> "$dir/index.html" << HTML
    </ul>
</body>
</html>
HTML
}

# Main index.html
cat > "$BASE/index.html" << HTML
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Systems Mastery Knowledge Base</title>
    <style>
        body { font-family: sans-serif; max-width: 800px; margin: 40px auto; padding: 20px; }
        a { color: #2563eb; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .dir { margin: 15px 0; padding: 10px 15px; background: #f9fafb; border-radius: 8px; border-left: 4px solid #2563eb; }
        .dir:hover { background: #f3f4f6; }
        .desc { color: #6b7280; font-size: 0.95em; margin-left: 5px; }
    </style>
</head>
<body>
    <h1>📚 Systems Mastery Knowledge Base</h1>
    <p>Minimal structure. Maximum learning. Zero overhead.</p>
    
    <div class="dir"><strong>📅 <a href="daily/">daily/</a></strong><span class="desc">Daily learning notes</span></div>
    <div class="dir"><strong>📖 <a href="concepts/">concepts/</a></strong><span class="desc">Concept deep dives</span></div>
    <div class="dir"><strong>🔬 <a href="labs/">labs/</a></strong><span class="desc">Hands-on experiments</span></div>
    <div class="dir"><strong>📋 <a href="templates/">templates/</a></strong><span class="desc">Note templates</span></div>
    <div class="dir"><strong>⚙️ <a href="scripts/">scripts/</a></strong><span class="desc">Utility scripts</span></div>
    <div class="dir"><strong>📊 <a href="diagrams/">diagrams/</a></strong><span class="desc">Architecture diagrams</span></div>
    <div class="dir"><strong>🖼️ <a href="assets/">assets/</a></strong><span class="desc">Images & files</span></div>
</body>
</html>
HTML

# Create index for each directory
for dir in daily concepts labs templates scripts diagrams assets; do
    if [ -d "$BASE/$dir" ]; then
        case $dir in
            daily) desc="Daily learning notes" ;;
            concepts) desc="Concept deep dives" ;;
            labs) desc="Hands-on experiments" ;;
            templates) desc="Note templates" ;;
            scripts) desc="Utility scripts" ;;
            diagrams) desc="Architecture diagrams" ;;
            assets) desc="Images & files" ;;
            *) desc="Content directory" ;;
        esac
        create_index "$BASE/$dir" "$(echo $dir | tr '[:lower:]' '[:upper:]')" "$desc"
    fi
done

echo "✅ Navigation fixed! Refresh your browser."
HTML
