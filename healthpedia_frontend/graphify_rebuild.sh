#!/bin/bash
# Graphify Rebuild Script
# This script ensures graphify is installed and runs the extraction pipeline.

echo "🔍 Checking Graphify installation..."

# Step 1: Detect Python & Ensure graphify is installed
GRAPHIFY_BIN=$(which graphify 2>/dev/null)
if [ -n "$GRAPHIFY_BIN" ]; then
    PYTHON=$(head -1 "$GRAPHIFY_BIN" | tr -d '#!')
    case "$PYTHON" in
        *[!a-zA-Z0-9/_.-]*) PYTHON="python3" ;;
    esac
else
    PYTHON="python3"
fi

# Attempt install if missing
"$PYTHON" -c "import graphify" 2>/dev/null || {
    echo "📦 Installing graphifyy..."
    "$PYTHON" -m pip install graphifyy -q --break-system-packages 2>/dev/null || \
    "$PYTHON" -m pip install graphifyy -q 2>/dev/null || \
    echo "❌ Failed to install graphifyy via pip. Please ensure python3-pip is available."
}

# Write interpreter path
mkdir -p graphify-out
"$PYTHON" -c "import sys; open('graphify-out/.graphify_python', 'w').write(sys.executable)"

# Step 2: Detect files
echo "📂 Detecting files..."
$($PYTHON -c "import sys; print(open('graphify-out/.graphify_python').read())") -c "
import json
from graphify.detect import detect
from pathlib import Path
result = detect(Path('.'))
print(json.dumps(result))
" > graphify-out/.graphify_detect.json

# Step 3: Minimal Summary (to console)
$($PYTHON -c "import sys; print(open('graphify-out/.graphify_python').read())") -c "
import json
from pathlib import Path
d = json.loads(Path('graphify-out/.graphify_detect.json').read_text())
print(f'Corpus: {d[\"total_files\"]} files · ~{d[\"total_words\"]} words')
"

echo "✅ Graphify initialized. Agent ready to run full pipeline."
