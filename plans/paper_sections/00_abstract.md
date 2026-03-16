# Abstract

**Target Length**: 150-200 words  
**Position**: Top left column (ISMIR format)

---

## Draft Abstract (Revised - Velocity Excluded)

Classifying musical compositions by their composer remains a challenging task in computational musicology, particularly when distinguishing between composers working within the same historical period and genre. This exploratory study investigates whether individual composer style can be captured through computational analysis of symbolic music representations in German Lieder. We propose a three-layer feature framework combining **tonal tension** (computed via the Spiral Array Model), **harmonic complexity** (measured as pitch class entropy), and **pianistic texture** (operationalized as onset density) to classify 264 Lieder by Franz Schubert, Robert Schumann, and Johannes Brahms. Our experiments demonstrate that carefully designed handcrafted features (55 dimensions, velocity features excluded to avoid editorial bias in MIDI transcriptions) achieve **65.0% balanced accuracy** using a Support Vector Machine classifier, with peak performance of approximately **70% using only the top 21 features**. This significantly outperforms pretrained transformer embeddings with MLP classifier (45.3% for 768-dimensional MidiBERT features) on this limited corpus. Feature importance analysis reveals that **note count, unison ratio, and stepwise melodic motion** are the most discriminative attributes. ANOVA results confirm significant between-composer variance in texture and melody features ($p < 0.05$). These findings suggest that domain-specific, interpretable features encoding musicological knowledge may be more effective than general-purpose pretrained representations when working with small, specialized corpora.

**Keywords**: composer classification, computational musicology, feature extraction, German Lieder, symbolic music analysis

---

## Abstract Writing Notes

### Key Elements Covered:
1. ✅ **Problem**: Composer classification difficulty within same period
2. ✅ **Method**: Three-layer feature framework (55D, velocity excluded)
3. ✅ **Dataset**: 264 Lieder, three composers
4. ✅ **Key Result**: 65.0% (55D SVM), ~70% (21D top features), vs 45.3% (MidiBERT MLP)
5. ✅ **Implication**: Domain-specific features > pretrained for small corpora

### Word Count Check:
- Current draft: ~200 words
- ISMIR requirement: 150-200 words ✓

### Musicological Framing:
- Emphasizes "exploratory" nature
- Connects features to musical concepts (tonal tension, texture)
- Acknowledges shared tradition (same period/genre)
- Notes velocity exclusion rationale

### Revision Checklist:
- [x] Remove velocity feature mentions
- [x] Update accuracy numbers (65.0%, ~70%, 45.3%)
- [x] Update top features (note count, unison ratio, stepwise ratio)
- [x] Add MLP classifier mention
- [ ] Ensure third-person perspective (double-blind)
- [ ] Verify all statistics match final experimental data

---

## Key Changes from Original

| Aspect | Original | Revised |
|--------|----------|---------|
| Feature dimensions | 60D | 55D (no velocity) |
| Best accuracy | 74.4% | 65.0% (55D), ~70% (21D) |
| Top features | velocity range, note count, unison ratio | note count, unison ratio, stepwise ratio |
| MLP baseline | Not mentioned | 45.3% (MidiBERT) |
| Velocity note | Not mentioned | Explicitly excluded (editorial bias) |
