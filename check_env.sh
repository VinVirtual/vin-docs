#!/usr/bin/env bash
# What vin-docs needs, and how to fix anything missing.
set -u
ok=1
say() { printf '%-5s %s\n' "$1" "$2"; }
if command -v node >/dev/null 2>&1 && [ "$(node -p 'process.versions.node.split(".")[0]')" -ge 22 ]; then say ok "node $(node -v)"; else say FAIL "Node.js 22+ is needed: https://nodejs.org"; ok=0; fi
command -v pdftotext >/dev/null 2>&1 && command -v pdfinfo >/dev/null 2>&1 && say ok "pdftotext and pdfinfo" || say warn "no poppler: PDF input will not work (sudo apt install poppler-utils / brew install poppler); DOCX, XLSX, PPTX and HTML still do"
[ "$ok" = 1 ] && echo "vin-docs is ready." || { echo "Fix the FAIL lines above."; exit 1; }
