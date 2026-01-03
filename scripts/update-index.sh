#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Function to create index for a directory
create_index() {
  local dir="$1"
  local title="$2"
  local pattern="$3"
  
  if [ ! -d "$dir" ]; then
    return
  fi
  
  cat > "$dir/index.html" << HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - Systems Mastery</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; 
               max-width: 1000px; margin: 40px auto; padding: 20px; line-height: 1.6; 
               color: #333; background: #f8f9fa; }
        .header { text-align: center; margin-bottom: 40px; padding: 20px; 
                  background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #2c3e50; margin-bottom: 10px; }
        .subtitle { color: #7f8c8d; font-size: 1.1em; }
        .file-list { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); 
                     gap: 20px; margin-top: 20px; }
        .file-card { background: white; border-radius: 10px; padding: 20px; 
                     box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: transform 0.2s; }
        .file-card:hover { transform: translateY(-2px); box-shadow: 0 4px 20px rgba(0,0,0,0.15); }
        .file-name { font-weight: 600; margin-bottom: 10px; color: #2c3e50; }
        .file-date { color: #95a5a6; font-size: 0.9em; margin-bottom: 10px; }
        .file-link { display: inline-block; padding: 8px 16px; background: #3498db; 
                     color: white; text-decoration: none; border-radius: 6px; 
                     font-weight: 500; transition: background 0.2s; }
        .file-link:hover { background: #2980b9; }
        .empty-state { text-align: center; padding: 40px; color: #95a5a6; }
        .back-link { display: inline-block; margin-top: 30px; color: #3498db; 
                     text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="header">
        <h1>${title}</h1>
        <div class="subtitle">Systems Mastery Journey</div>
    </div>
    
    <div class="file-list">
HTML
  
  # Find and list files
  local files=$(find "$dir" -name "$pattern" ! -name "index.html" | sort -r)
  
  if [ -z "$files" ]; then
    cat >> "$dir/index.html" << HTML
        <div class="empty-state" style="grid-column: 1 / -1;">
            <div>📁</div>
            <h3>No files yet</h3>
            <p>Files will appear here as you create them.</p>
        </div>
HTML
  else
    for file in $files; do
      local basename=$(basename "$file")
      local display_name="${basename%.md}"
      local date_part=$(echo "$basename" | cut -d'-' -f1)
      local readable_date=$(date -d "${date_part:0:8}" "+%b %d, %Y" 2>/dev/null || echo "$date_part")
      
      cat >> "$dir/index.html" << HTML
        <div class="file-card">
            <div class="file-name">${display_name}</div>
            <div class="file-date">${readable_date}</div>
            <a href="${basename}" class="file-link">Open</a>
        </div>
HTML
    done
  fi
  
  cat >> "$dir/index.html" << HTML
    </div>
    
    <a href="../index.html" class="back-link">← Back to Home</a>
</body>
</html>
HTML
  
  echo "Updated index: $dir/index.html"
}

# Create indexes for all sections
create_index "$BASE_DIR/daily" "Daily Notes" "*.md"
create_index "$BASE_DIR/assets" "Assets" "*.md"
create_index "$BASE_DIR/concepts" "Concepts" "*.md"
create_index "$BASE_DIR/diagrams" "Diagrams" "*.md"
create_index "$BASE_DIR/labs" "Labs" "*.md"
create_index "$BASE_DIR/templates" "Templates" "*.md"

# Create main index.html
cat > "$BASE_DIR/index.html" << HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Systems Mastery</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; 
               max-width: 800px; margin: 40px auto; padding: 20px; line-height: 1.6; 
               color: #333; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); 
               min-height: 100vh; }
        .container { background: white; border-radius: 15px; padding: 40px; 
                     box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .header { text-align: center; margin-bottom: 40px; }
        h1 { color: #2c3e50; font-size: 2.5em; margin-bottom: 10px; }
        .subtitle { color: #7f8c8d; font-size: 1.2em; margin-bottom: 30px; }
        .stats { display: flex; justify-content: center; gap: 30px; margin-bottom: 40px; 
                 text-align: center; }
        .stat-item { padding: 20px; background: #f8f9fa; border-radius: 10px; 
                     min-width: 150px; }
        .stat-number { font-size: 2em; font-weight: bold; color: #3498db; }
        .stat-label { color: #7f8c8d; font-size: 0.9em; margin-top: 5px; }
        .sections { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); 
                    gap: 20px; margin-bottom: 40px; }
        .section-card { background: #f8f9fa; border-radius: 10px; padding: 25px; 
                        text-align: center; transition: all 0.3s; border: 2px solid transparent; }
        .section-card:hover { transform: translateY(-5px); border-color: #3498db; 
                              box-shadow: 0 5px 20px rgba(52, 152, 219, 0.2); }
        .section-icon { font-size: 2.5em; margin-bottom: 15px; }
        .section-title { font-size: 1.3em; font-weight: 600; margin-bottom: 10px; 
                         color: #2c3e50; }
        .section-desc { color: #7f8c8d; font-size: 0.95em; margin-bottom: 20px; }
        .section-link { display: inline-block; padding: 10px 20px; background: #3498db; 
                        color: white; text-decoration: none; border-radius: 6px; 
                        font-weight: 500; transition: background 0.2s; }
        .section-link:hover { background: #2980b9; }
        .day-info { background: #e8f4fc; border-radius: 10px; padding: 25px; 
                    margin-bottom: 30px; text-align: center; }
        .day-title { font-size: 1.4em; font-weight: 600; color: #2c3e50; margin-bottom: 10px; }
        .day-topic { font-size: 1.1em; color: #7f8c8d; margin-bottom: 15px; }
        .day-button { display: inline-block; padding: 12px 25px; background: #27ae60; 
                      color: white; text-decoration: none; border-radius: 6px; 
                      font-weight: 500; transition: background 0.2s; }
        .day-button:hover { background: #219653; }
        .footer { text-align: center; margin-top: 40px; padding-top: 20px; 
                  border-top: 1px solid #eee; color: #95a5a6; font-size: 0.9em; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Systems Mastery</h1>
            <div class="subtitle">365-Day Infrastructure & AI Learning Journey</div>
        </div>
        
        <div class="stats">
            <div class="stat-item">
                <div class="stat-number" id="current-day">Loading...</div>
                <div class="stat-label">Current Day</div>
            </div>
            <div class="stat-item">
                <div class="stat-number" id="total-files">0</div>
                <div class="stat-label">Files Created</div>
            </div>
            <div class="stat-item">
                <div class="stat-number" id="total-days">365</div>
                <div class="stat-label">Total Days</div>
            </div>
        </div>
        
        <div class="day-info">
            <div class="day-title">📅 Today's Focus</div>
            <div class="day-topic" id="today-topic">Loading today's topic...</div>
            <a href="./scripts/today.sh" class="day-button">Generate Today's Notes</a>
        </div>
        
        <div class="sections">
            <div class="section-card">
                <div class="section-icon">📘</div>
                <div class="section-title">Daily Notes</div>
                <div class="section-desc">Main learning notes and AI tasks</div>
                <a href="./daily/" class="section-link">Browse Daily</a>
            </div>
            <div class="section-card">
                <div class="section-icon">🛠️</div>
                <div class="section-title">Assets</div>
                <div class="section-desc">Resources, files, and materials</div>
                <a href="./assets/" class="section-link">Browse Assets</a>
            </div>
            <div class="section-card">
                <div class="section-icon">🧠</div>
                <div class="section-title">Concepts</div>
                <div class="section-desc">Theoretical concepts explained</div>
                <a href="./concepts/" class="section-link">Browse Concepts</a>
            </div>
            <div class="section-card">
                <div class="section-icon">📊</div>
                <div class="section-title">Diagrams</div>
                <div class="section-desc">Visual explanations and diagrams</div>
                <a href="./diagrams/" class="section-link">Browse Diagrams</a>
            </div>
            <div class="section-card">
                <div class="section-icon">🔬</div>
                <div class="section-title">Labs</div>
                <div class="section-desc">Hands-on exercises and experiments</div>
                <a href="./labs/" class="section-link">Browse Labs</a>
            </div>
            <div class="section-card">
                <div class="section-icon">📋</div>
                <div class="section-title">Templates</div>
                <div class="section-desc">Reusable templates and patterns</div>
                <a href="./templates/" class="section-link">Browse Templates</a>
            </div>
        </div>
        
        <div class="footer">
            <p>Systems Mastery Journey • Updated on: <span id="current-date"></span></p>
            <p><a href="https://github.com/mailforsachin/systems-mastery" style="color: #3498db;">View on GitHub</a></p>
        </div>
    </div>
    
    <script>
        // Set current date
        document.getElementById('current-date').textContent = new Date().toLocaleDateString();
        
        // Try to get current day from day.txt
        fetch('./day.txt')
            .then(response => response.text())
            .then(day => {
                document.getElementById('current-day').textContent = day.trim();
                // Try to get today's topic
                return fetch('./topics.txt');
            })
            .then(response => response.text())
            .then(text => {
                const lines = text.split('\\n');
                const currentDay = document.getElementById('current-day').textContent;
                let found = false;
                
                for (let i = 0; i < lines.length; i++) {
                    if (lines[i].startsWith('Day ' + currentDay + ':')) {
                        const topic = lines[i].replace('Day ' + currentDay + ': ', '');
                        document.getElementById('today-topic').textContent = topic;
                        found = true;
                        
                        // Try to get the question
                        if (i + 1 < lines.length && lines[i + 1].startsWith('Question:')) {
                            const question = lines[i + 1].replace('Question: ', '');
                            document.getElementById('today-topic').textContent = topic + ' - ' + question;
                        }
                        break;
                    }
                }
                
                if (!found) {
                    document.getElementById('today-topic').textContent = 'Day ' + currentDay + ' topic';
                }
            })
            .catch(error => {
                console.log('Error loading data:', error);
                document.getElementById('current-day').textContent = '1';
            });
        
        // Count total files
        function countFiles() {
            let total = 0;
            const sections = ['daily', 'assets', 'concepts', 'diagrams', 'labs', 'templates'];
            
            sections.forEach(section => {
                // This would require server-side counting, so we'll approximate
                // For now, we'll just count daily files
                if (section === 'daily') {
                    fetch('./daily/')
                        .then(response => response.text())
                        .then(html => {
                            // Simple count of .md links
                            const count = (html.match(/href=".*\.md"/g) || []).length;
                            document.getElementById('total-files').textContent = count;
                        })
                        .catch(() => {
                            document.getElementById('total-files').textContent = '?';
                        });
                }
            });
        }
        
        countFiles();
    </script>
</body>
</html>
HTML

echo "✅ Updated all indexes"
