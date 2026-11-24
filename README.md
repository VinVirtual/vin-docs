# vin-docs

[![ci](https://github.com/VinVirtual/vin-docs/actions/workflows/ci.yml/badge.svg)](https://github.com/VinVirtual/vin-docs/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Turn PDF, Word, Excel, PowerPoint and HTML files into clean Markdown on your own machine.

Convert once, then read, search, quote or summarise the Markdown. PDFs keep page markers and
column-aligned blocks; Office tables become Markdown tables; HTML keeps the main content and drops
scripts and navigation. The full Markdown goes to a file and a short preview is printed.

It is a [Claude Code](https://claude.com/claude-code) skill: `SKILL.md` tells Claude to use it when
you point at a document. It works the same by hand.

## Install

As a Claude Code plugin from the [VinSkills](https://github.com/VinVirtual/vinskills) marketplace:

```bash
claude plugin marketplace add VinVirtual/vinskills
```

```
/plugin install vin-docs@vinskills        # this skill alone
/plugin install vin-core@vinskills         # or all eight vin-core skills
```

Or as a plain skill folder:

```bash
git clone https://github.com/VinVirtual/vin-docs ~/.claude/skills/vin-docs
~/.claude/skills/vin-docs/check_env.sh
```

Needs Node.js 22 or newer. PDF input also needs `pdftotext` and `pdfinfo` from poppler
(`sudo apt install poppler-utils` or `brew install poppler`). DOCX, XLSX, PPTX and HTML need
nothing else: the ZIP and XML readers are built in.

## Quick start

```bash
node scripts/vin-docs.mjs report.pdf                 # writes report.md, prints a summary and preview
node scripts/vin-docs.mjs deck.pptx -o notes/deck.md
node scripts/vin-docs.mjs table.xlsx --stdout --max 20000
node scripts/vin-docs.mjs page.html --base https://example.org/docs/
```

`--max` limits only what is printed; the file is always complete. `--max-mb` (default 50) refuses
larger inputs and `--pages` (default 300) limits PDF pages.

## Example

[examples/](examples/) has a small PDF, DOCX, XLSX and HTML file and the Markdown vin-docs wrote
for each. The spreadsheet becomes:

```markdown
## sample

| Part | Qty | Price |
| --- | --- | --- |
| Servo | 6 | 12.5 |
| Frame | 1 | 40 |
```

## What each format keeps

| Format | Kept |
| --- | --- |
| PDF | text in layout order, `<!-- page N -->` markers, runs of column-aligned lines in a fenced `text` block |
| DOCX | headings, bold and italic, lists, links, tables |
| XLSX | one Markdown table per sheet, last saved values of formulas |
| PPTX | one section per slide: title, bullets, tables, speaker notes |
| HTML | main content, headings, lists, links, code and tables; `[image: alt]` for images |

More in [references/formats.md](references/formats.md).

## Limits

- Scanned PDFs need OCR, which this skill does not do; the summary says when almost no text was found.
- Images and charts are not described. Merged Office cells are flattened.
- Old binary formats (.doc, .xls, .ppt) must be converted first, for example with `soffice --headless --convert-to docx`.
- ZIP archives that claim an unusually large expanded size are refused on purpose.

## Tests

```bash
npm test
```

The suite runs offline with Node's built-in test runner (the PDF tests are skipped when poppler is not installed). CI runs it on every push, together
with [skill-ci](https://github.com/VinVirtual/skill-ci), which lints the SKILL.md, README,
licence, secrets and scripts.

## Part of VinSkills

vin-docs is one of the eight `vin-core` skills in [VinSkills](https://github.com/VinVirtual/vinskills),
my Claude Code marketplace: [vin-house-build](https://github.com/VinVirtual/vin-house-build),
[vin-agent-orchestration](https://github.com/VinVirtual/vin-agent-orchestration),
[vin-site-qa](https://github.com/VinVirtual/vin-site-qa), [vin-meter](https://github.com/VinVirtual/vin-meter),
[vin-navigator](https://github.com/VinVirtual/vin-navigator), [vin-docs](https://github.com/VinVirtual/vin-docs),
[vin-squeeze](https://github.com/VinVirtual/vin-squeeze) and [vin-scriptlens](https://github.com/VinVirtual/vin-scriptlens).

## Licence

MIT, see [LICENSE](LICENSE).
