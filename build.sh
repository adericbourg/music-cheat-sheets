#!/usr/bin/env bash
# Build the sheets locally, like the CI does. PDFs land in output/.
# Usage: ./build.sh [sheet...]   (default: every sheet)
# A sheet is a top-level directory containing <dir>/<dir>.tex.
set -euo pipefail
cd "$(dirname "$0")"

# --- Prerequisites ---------------------------------------------------------
missing=()
if ! command -v lualatex > /dev/null; then
  missing+=("lualatex")
else
  # shortcut: only checks for kpsewhich-visible files, upgrade if sheets use more packages
  for f in extarticle.cls fontspec.sty babel.sty french.ldf tikz.sty xcolor.sty \
           tabularx.sty colortbl.sty enumitem.sty multicol.sty luacode.sty; do
    kpsewhich "$f" > /dev/null || missing+=("$f")
  done
fi
# Not `fc-list | grep -q`: grep exits early, fc-list gets SIGPIPE and pipefail fails the check.
fonts=$(fc-list : family 2> /dev/null || true)
if ! grep -qix 'Inter\(,.*\)\?' <<< "$fonts"; then
  missing+=("Inter font")
fi
if [ ${#missing[@]} -gt 0 ]; then
  echo "Missing prerequisites: ${missing[*]}" >&2
  echo "On Debian/Ubuntu: sudo apt install texlive-luatex texlive-latex-extra texlive-lang-french texlive-pictures lmodern fonts-inter" >&2
  exit 1
fi

# --- Sheets ----------------------------------------------------------------
if [ $# -gt 0 ]; then
  sheets=("$@")
else
  sheets=()
  for d in */; do d=${d%/}; [ -f "$d/$d.tex" ] && sheets+=("$d"); done
fi
[ ${#sheets[@]} -gt 0 ] || { echo "No sheet found" >&2; exit 1; }

for s in "${sheets[@]}"; do
  s=${s%/}
  [ -f "$s/$s.tex" ] || { echo "Unknown sheet: $s (no $s/$s.tex)" >&2; exit 1; }
done

mkdir -p output
for s in "${sheets[@]}"; do
  s=${s%/}
  echo "== $s"
  (cd "$s" && lualatex -interaction=nonstopmode -halt-on-error "$s.tex" > "$s.build.log" 2>&1) \
    || { echo "Build failed, see $s/$s.build.log" >&2; exit 1; }
  cp "$s/$s.pdf" output/
  echo "output/$s.pdf"
done
