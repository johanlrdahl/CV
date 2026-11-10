# CV — Johan L. R. Dahl

Public repository for my CV, maintained directly in HTML and published via GitHub Pages:
- **Live 1-Page CV:** [https://johanlrdahl.github.io/CV/](https://johanlrdahl.github.io/CV/) (`johan-dahl-cv.html`)
- **Live Detailed CV:** [https://johanlrdahl.github.io/CV/johan-dahl-cv-detailed.html](https://johanlrdahl.github.io/CV/johan-dahl-cv-detailed.html) (`johan-dahl-cv-detailed.html`)

---

## Repository Structure

| Path | Purpose |
| :--- | :--- |
| `index.html` | Entry point for GitHub Pages (redirects to `johan-dahl-cv.html`). |
| `johan-dahl-cv.html` | **1-Page Summary CV** — concise executive/pitch layout tuned to fit strictly on a single A4 page. |
| `johan-dahl-cv-detailed.html` | **Detailed CV** — expanded 2-page layout with comprehensive role narratives, consulting assignments, and technical depth. |
| `export-pdf.sh` | Bash script that converts any HTML CV into an A4 PDF using headless Chrome. |

---

## Generating PDFs from HTML

HTML is the single source of truth. PDFs are generated on demand and ignored by git (`*.pdf` in `.gitignore`) so outdated binary files are never committed.

### Option 1: Using `export-pdf.sh` (Recommended)

Run the included script from the repository root (requires Google Chrome, Brave, Edge, or Chromium):

```bash
# Export both default CVs (creates johan-dahl-cv.pdf and johan-dahl-cv-detailed.pdf)
./export-pdf.sh

# Export a specific HTML file (creates <filename>.pdf alongside the HTML file)
./export-pdf.sh johan-dahl-cv.html

# Export an HTML file to a custom output PDF path
./export-pdf.sh path/to/custom-cv.html path/to/output.pdf
```

### Option 2: Printing from Browser

1. Open `johan-dahl-cv.html` or `johan-dahl-cv-detailed.html` in Chrome.
2. Press `Cmd + P` (macOS) or `Ctrl + P` (Windows/Linux).
3. Set **Destination** to **Save as PDF**, **Paper size** to **A4**, enable **Background graphics**, and uncheck **Headers and footers**.
