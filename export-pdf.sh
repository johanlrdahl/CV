#!/usr/bin/env bash
set -euo pipefail

# Export one or more HTML CV files to A4 PDF using headless Chrome/Chromium.
# Usage:
#   ./export-pdf.sh                                # Exports default CVs (johan-dahl-cv.html & johan-dahl-cv-detailed.html)
#   ./export-pdf.sh johan-dahl-cv.html             # Exports johan-dahl-cv.pdf
#   ./export-pdf.sh path/to/custom-cv.html out.pdf # Exports custom-cv.html to out.pdf

find_browser() {
  local candidates=(
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
    "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
    "google-chrome"
    "chromium"
  )
  for bin in "${candidates[@]}"; do
    if command -v "$bin" >/dev/null 2>&1 || [ -x "$bin" ]; then
      echo "$bin"
      return 0
    fi
  done
  return 1
}

BROWSER="$(find_browser || true)"
if [ -z "$BROWSER" ]; then
  echo "Error: Could not find Google Chrome, Brave, Edge, or Chromium to render PDF." >&2
  exit 1
fi

render_pdf() {
  local html_file="$1"
  local pdf_file="${2:-${html_file%.html}.pdf}"

  if [ ! -f "$html_file" ]; then
    echo "Error: HTML file not found: $html_file" >&2
    return 1
  fi

  local abs_html
  abs_html="$(cd "$(dirname "$html_file")" && pwd)/$(basename "$html_file")"
  local abs_pdf
  abs_pdf="$(cd "$(dirname "$pdf_file")" && pwd)/$(basename "$pdf_file")"

  echo "Rendering $html_file -> $pdf_file ..."
  "$BROWSER" \
    --headless \
    --disable-gpu \
    --no-pdf-header-footer \
    --print-to-pdf="$abs_pdf" \
    "file://$abs_html" 2>/dev/null

  echo "Created: $pdf_file"
}

if [ "$#" -eq 0 ]; then
  for default_file in "johan-dahl-cv.html" "johan-dahl-cv-detailed.html"; do
    if [ -f "$default_file" ]; then
      render_pdf "$default_file"
    fi
  done
elif [ "$#" -eq 1 ]; then
  render_pdf "$1"
elif [ "$#" -eq 2 ]; then
  render_pdf "$1" "$2"
else
  echo "Usage: $0 [input.html] [output.pdf]" >&2
  exit 1
fi
