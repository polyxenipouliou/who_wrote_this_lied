# Composer Fingerprinting: Paper Structure & Writing Plan

## Overview

This document outlines the structure for an exploratory course project investigating computational approaches to composer style analysis in German Lieder. The paper follows ISMIR 2026 format guidelines.

---

## Paper Structure

### Section Files (in `plans/paper_sections/`)

| File | Section | Target Length | Key Content |
|------|---------|---------------|-------------|
| `00_abstract.md` | Abstract | 200 words | Problem, method, key finding, implication |
| `01_introduction.md` | Introduction | 1 page | Research questions, contributions, exploratory framing |
| `02_background.md` | Background & Related Work | 1.5 pages | Musicological context, computational approaches, gap identification |
| `03_methodology.md` | Methodology | 1.5 pages | Dataset, feature design rationale, extraction pipeline, evaluation |
| `04_results.md` | Results | 1 page | Classification performance, feature importance, ANOVA |
| `05_musicological_discussion.md` | Musicological Discussion | 1 page | What features reveal about Schubert, Schumann, Brahms |
| `06_exploratory_analysis.md` | Exploratory Analysis | 0.5 page | Case studies, limitations, unexpected findings |
| `07_conclusion.md` | Conclusion | 0.5 page | Summary, future directions |
| `08_references.md` | References | 1+ pages | IEEE style bibliography |

---

## Detailed Section Outlines

### 00_abstract.md

**Purpose**: Concise summary of entire study

**Key Points**:
- Problem: Composer classification remains challenging at individual level
- Method: Three-layer feature framework (tonal tension, harmonic complexity, texture)
- Dataset: 264 Lieder by Schubert, Brahms, Schumann
- Key Result: 60D handcrafted features achieve 74.4% vs 47.1% for MidiBERT
- Implication: Domain-specific features outperform general pretrained models on small corpora

**Musicological Angle**: Exploratory investigation into whether computational features can capture stylistic individuality within shared Romantic era vocabulary

---

### 01_introduction.md

**Purpose**: Frame the research problem and establish exploratory nature

**Subsections**:

#### 1.1 Problem Statement
- Classifying composers within same period remains difficult (Alvarez et al., 2024)
- Most research focuses on era-level differences, not individual style
- German Lieder present unique challenge: shared poetic-musical tradition

#### 1.2 Research Questions (Exploratory)
- RQ1: Can symbolic features capture composer-specific patterns in Lieder?
- RQ2: Which musical dimensions (harmony, texture, melody) best differentiate composers?
- RQ3: How do handcrafted features compare to pretrained representations for limited data?

#### 1.3 Contributions
1. Multi-layer feature framework combining music-theoretic and statistical approaches
2. Systematic comparison of handcrafted vs. pretrained features for composer classification
3. Open-source implementation and reproducible experimental pipeline
4. Musicological interpretation of computational findings

#### 1.4 Paper Organization
- Brief roadmap of remaining sections

---

### 02_background.md

**Purpose**: Dual perspective - musicological and computational

**Subsections**:

#### 2.1 The German Lieder Tradition
- Historical context: Schubert (early Romantic), Schumann (high Romantic), Brahms (late Romantic)
- Shared vocabulary: strophic/through-composed forms, piano-voice texture
- Individual stylistic markers (musicological literature)

#### 2.2 Computational Composer Classification
- Early work: Youngblood (1958) statistical approach
- Simonetta (2025) computational framing
- Feature-based approaches: n-grams, TIV, entropy measures
- Machine learning: SVM, HMM, shallow classifiers

#### 2.3 Deep Learning vs. Handcrafted Features
- MusicBERT, MidiBERT family
- When do pretrained models help? (data requirements)
- The small corpus problem in classical music

#### 2.4 Gap Identification
- Limited work on individual composer style within same era
- Lack of musicological interpretation in computational studies
- Need for interpretable, theory-grounded features

---

### 03_methodology.md

**Purpose**: Detailed description of experimental design with musical rationale

**Subsections**:

#### 3.1 Dataset
- Sources: OpenScore Lieder, Winterreise Dataset
- Composition: 264 pieces (Schubert: 84, Brahms: 109, Schumann: 71)
- Preprocessing: voice separation, meter detection, quality filtering

#### 3.2 Feature Design Rationale (Musicological Foundation)

**3.2.1 Tonal Tension**
- Theoretical basis: Schenkerian tonal prolongation, Lerdahl & Krumhansl
- Spiral Array Model (Herremans & Chew, 2016, 2019)
- Hypothesis: Each composer has distinct approach to harmonic instability

**3.2.2 Harmonic Complexity**
- Theoretical basis: Pitch class distribution, chromatic saturation
- Shannon entropy as measure of harmonic density
- Hypothesis: Brahms more conservative, Schumann more chromatic

**3.2.3 Pianistic Texture**
- Theoretical basis: Accompaniment patterns in Lieder
- Onset density: block chords vs. arpeggiation
- Hypothesis: Schubert guitar-like vs. Schumann arpeggiated vs. Brahms dense

**3.2.4 Melodic Contour**
- Theoretical basis: Vocal writing, text setting
- Interval succession patterns
- Hypothesis: Schubert more stepwise (lyrical), others more varied

#### 3.3 Feature Extraction Pipeline
- Metric grid alignment (quarter-note vs. eighth-note based on meter)
- Bar-level matrices → piece-level statistics
- 12D statistical features (mean, std, entropy per layer)
- 60D handmade features (detailed breakdown)

#### 3.4 MidiBERT Feature Extraction
- Model description (Adversarial-MidiBERT)
- Octuple representation
- Average pooling for piece-level embeddings

#### 3.5 Classification Framework
- SVM with RBF kernel
- Balanced class weights (addressing class imbalance)
- 5-fold stratified cross-validation
- Balanced accuracy as primary metric

#### 3.6 Analysis Methods
- Random Forest feature importance
- ANOVA for feature discriminability
- Incremental feature selection experiments

---

### 04_results.md

**Purpose**: Present experimental findings objectively

**Subsections**:

#### 4.1 Classification Performance Comparison
- Table: All feature sets (12D, 30D, 60D, 768D, combined)
- Key finding: 60D achieves 74.4%, MidiBERT 47.1%
- Statistical significance discussion

#### 4.2 Feature Importance Analysis
- Top 20 features table with importance scores
- Feature selection curve (accuracy vs. number of features)
- Optimal subset: ~23 features

#### 4.3 ANOVA Discriminability Analysis
- Features with significant between-composer variance (p < 0.05)
- Boxplot visualization description
- Most discriminative: velocity range, interval statistics

#### 4.4 Confusion Matrix Analysis
- Per-composer precision, recall, F1
- Common confusions and patterns

---

### 05_musicological_discussion.md

**Purpose**: Interpret computational findings through musicological lens

**Subsections**:

#### 5.1 What Features Reveal About Schubert
- High stepwise ratio (f28): lyrical, vocal melody writing
- Lower texture density: guitar-like accompaniment (think Winterreise)
- Moderate harmonic complexity: text-driven harmony

#### 5.2 What Features Reveal About Schumann
- High velocity variance (f12): expressive dynamic contrasts
- Lower simultaneity (f47): arpeggiated textures (Dichterliebe opening)
- Complex rhythm (f20_ioi_std): poetic declamation patterns

#### 5.3 What Features Reveal About Brahms
- High pitch range (f4), note density (f21): richer textures
- Conservative intervals (low f29_leap_ratio): classical influence
- Dense chords (high f50_thick_chord_ratio): symphonic piano writing

#### 5.4 Why Handcrafted Features Outperform MidiBERT
- Domain specificity vs. general representation
- Small dataset problem (264 pieces insufficient for 768D fine-tuning)
- Feature design encodes musicological knowledge

#### 5.5 Limitations of Current Approach
- Binary texture model (doesn't capture voice-leading)
- No chord function analysis
- Meter-level aggregation loses local detail

---

### 06_exploratory_analysis.md

**Purpose**: Present unexpected findings and case studies

**Subsections**:

#### 6.1 Case Study: Winterreise Texture Analysis
- Schubert's cyclic approach reflected in feature consistency
- Comparison with other Schubert Lieder

#### 6.2 Case Study: Dichterliebe Opening
- Schumann's arpeggiated texture quantified
- Contrast with block-chord sections

#### 6.3 Unexpected Findings
- Velocity features more important than expected
- Tonal tension less discriminative than hypothesized
- Possible explanations

#### 6.4 What Didn't Work
- Sequential modeling attempts (data too sparse)
- Chord annotation pipeline (too error-prone)
- Future improvements

---

### 07_conclusion.md

**Purpose**: Summarize and look forward

**Subsections**:

#### 7.1 Summary of Findings
- Handcrafted features effective for small corpus composer classification
- Texture and melody features most discriminative
- Musicological interpretation validates computational approach

#### 7.2 Future Work
- Chord tonal distance (requires annotation)
- Larger corpus (expand to other Romantic composers)
- Multi-modal fusion (audio + symbolic)
- Sequential modeling with attention mechanisms

#### 7.3 Broader Implications
- Computational musicology as hypothesis generation tool
- Balance between domain knowledge and data-driven approaches

---

### 08_references.md

**Purpose**: Complete bibliography in IEEE style

**Key References**:
1. Youngblood (1958) - Statistical style analysis
2. Herremans & Chew (2016, 2019) - Spiral Array, tonal tension
3. Simonetta (2025) - Computational composer classification survey
4. Kaliakatsos et al. (2011) - Pitch class entropy
5. Giraud et al. (2014) - Texture modeling
6. Alvarez et al. (2024) - N-gram composer classification
7. Zhao (2025) - Adversarial-MidiBERT
8. McKay & Fujinaga (2006) - jSymbolic
9. Llorens et al. (2023) - musif library
10. Pollastri & Simoncelli (2003) - Melodic contour

---

## Writing Schedule

| Phase | Sections | Target Date |
|-------|----------|-------------|
| 1 | 00_abstract, 01_introduction | Week 1 |
| 2 | 02_background, 03_methodology | Week 2 |
| 3 | 04_results, 05_musicological_discussion | Week 3 |
| 4 | 06_exploratory_analysis, 07_conclusion, 08_references | Week 4 |

---

## Notes for Writing

1. **Tone**: Exploratory, not definitive - use "suggests", "indicates", "may reflect"
2. **Musicological Depth**: Connect every feature to theoretical concepts
3. **Visual Elements**: Plan figures for each results section
4. **Citation Style**: IEEE format, numbered references
5. **Double-Blind**: Write in third person, no self-citations to unpublished work
