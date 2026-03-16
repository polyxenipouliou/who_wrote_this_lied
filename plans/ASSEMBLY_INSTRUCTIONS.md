# Paper Assembly Instructions

## Overview

This document provides instructions for assembling the complete ISMIR 2026 paper from the individual section files.

---

## File Structure

```
plans/
├── outline.md                      # Overall structure and writing plan
├── ASSEMBLY_INSTRUCTIONS.md        # This file
└── paper_sections/
    ├── 00_abstract.md              # Abstract (200 words)
    ├── 01_introduction.md          # Introduction (1 page)
    ├── 02_background.md            # Background & Related Work (1.5 pages)
    ├── 03_methodology.md           # Methodology (1.5 pages)
    ├── 04_results.md               # Results (1 page)
    ├── 05_musicological_discussion.md  # Discussion (1 page)
    ├── 06_exploratory_analysis.md  # Exploratory Analysis (0.5 page)
    ├── 07_conclusion.md            # Conclusion (0.5 page)
    └── 08_references.md            # References (unlimited pages)
```

---

## Assembly Steps

### Step 1: Create Main Document

Create a new document `paper_main.tex` (LaTeX) or `paper_main.docx` (Word) using the ISMIR 2026 template.

**LaTeX:**
```latex
\documentclass{article}
\usepackage{ismir2026}
\begin{document}
% Content from sections goes here
\end{document}
```

**Download Template:** https://ismir2026.ismir.net/templates

### Step 2: Combine Sections in Order

Copy content from each section file in numerical order:

1. **Title Block** (create new based on ISMIR template)
   - Title: Composer Fingerprinting: A Multi-Layer Feature Approach for Lieder Authorship Attribution
   - Authors: Anonymous (for double-blind review)
   - Affiliation: Anonymous

2. **Abstract** (from 00_abstract.md)
   - Place in left column at top of first page
   - Ensure 150-200 words

3. **Introduction** (from 01_introduction.md)
   - Section 1

4. **Background** (from 02_background.md)
   - Section 2

5. **Methodology** (from 03_methodology.md)
   - Section 3

6. **Results** (from 04_results.md)
   - Section 4

7. **Discussion** (from 05_musicological_discussion.md)
   - Section 5

8. **Exploratory Analysis** (from 06_exploratory_analysis.md)
   - Can be merged with Section 5 or kept as Section 6

9. **Conclusion** (from 07_conclusion.md)
   - Section 7

10. **References** (from 08_references.md)
    - Use BibTeX for LaTeX or formatted bibliography for Word

### Step 3: Add Figures and Tables

**Required Figures:**
1. Feature extraction pipeline diagram (Mermaid or similar)
2. Feature selection accuracy curve (from `feature_accuracy_curve_60.png`)
3. ANOVA distribution boxplots (from `feature_distribution_anova.png`)
4. Confusion matrix heatmaps (generate from results)

**Required Tables:**
1. Dataset composition (Section 3.1.2)
2. Classification performance comparison (Section 4.1.1)
3. Per-composer metrics (Section 4.1.2)
4. Top 10 feature importance (Section 4.2.1)
5. ANOVA significance results (Section 4.3.1)
6. Confusion matrices (Section 4.4)

### Step 4: Format According to ISMIR Guidelines

**Key Requirements:**
- Two-column format
- 10pt Times font
- A4 page size (21.0cm × 29.7cm)
- Text area: 17.2cm × 25.2cm
- Margins: 1.9cm left/right, 2.0cm top, 2.5cm bottom
- Column width: 8.2cm each, 0.8cm gutter
- Maximum 6 pages of technical content + references

**Heading Styles:**
- Section titles: 10pt bold, centered
- Subsection titles: 10pt bold, flush left
- Sub-subsection titles: 10pt italic, flush left

### Step 5: Verify Citations

Cross-reference all in-text citations with the reference list:
- Ensure numerical order (first citation = [1], second = [2], etc.)
- Verify all DOIs resolve correctly
- Check author names and publication years

### Step 6: Final Checks

**Before Submission:**
- [ ] Page count ≤ 6 pages (excluding references)
- [ ] File size ≤ 10MB
- [ ] All figures readable in grayscale
- [ ] No headers, footers, or page numbers
- [ ] Double-blind compliant (no author names, no self-citations)
- [ ] All tables and figures referenced in text
- [ ] Consistent terminology throughout

---

## Page Budget

| Section | Target Pages | Notes |
|---------|--------------|-------|
| Abstract | 0.25 | Top of first page |
| Introduction | 1.0 | May need condensation |
| Background | 1.5 | May need condensation |
| Methodology | 1.5 | Core technical content |
| Results | 1.0 | Essential tables/figures |
| Discussion | 1.0 | Musicological interpretation |
| Exploratory | 0.5 | Can merge with Discussion |
| Conclusion | 0.5 | |
| **Subtotal** | **6.75** | **Need to reduce by ~0.75 pages** |
| References | Unlimited | Does not count toward limit |

**Strategies for Reduction:**
1. Condense Background section (remove some historical detail)
2. Merge Exploratory Analysis into Discussion
3. Reduce table sizes (use single-column where possible)
4. Move detailed feature descriptions to appendix/supplementary

---

## Supplementary Materials

Consider creating supplementary materials for:
- Full feature importance rankings (all 72 features)
- Additional confusion matrices
- Complete ANOVA results
- Feature extraction code documentation

Host supplementary materials on GitHub repository linked in paper.

---

## Timeline

| Task | Target Date | Status |
|------|-------------|--------|
| Section drafts complete | Week 1 | ✅ Done |
| First assembly | Week 2 | Pending |
| Revision for length | Week 2 | Pending |
| Figure preparation | Week 3 | Pending |
| Final review | Week 3 | Pending |
| Submission | Week 4 | Pending |

---

## Contact Information

For ISMIR 2026 submission questions:
- Email: ismir2026-papers@ismir.net
- Website: https://ismir2026.ismir.net

---

## Notes

- This paper is designed as an **exploratory course project**
- Emphasize musicological interpretation over technical novelty
- Acknowledge limitations honestly
- Focus on reproducibility and open science practices
