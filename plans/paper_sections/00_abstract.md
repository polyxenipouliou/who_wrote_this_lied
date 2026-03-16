# Abstract

**Target Length**: 150-200 words  
**Position**: Top left column (ISMIR format)

---

## Draft Abstract

Classifying musical compositions by their composer remains a challenging task in computational musicology, particularly when distinguishing between composers working within the same historical period and genre. This exploratory study investigates whether individual composer style can be captured through computational analysis of symbolic music representations in German Lieder. We propose a three-layer feature framework combining **tonal tension** (computed via the Spiral Array Model), **harmonic complexity** (measured as pitch class entropy), and **pianistic texture** (operationalized as onset density) to classify 264 Lieder by Franz Schubert, Robert Schumann, and Johannes Brahms. Our experiments demonstrate that carefully designed handcrafted features (60 dimensions) achieve 74.4% balanced accuracy using a Support Vector Machine classifier, significantly outperforming pretrained transformer embeddings from Adversarial-MidiBERT (47.1% for 768-dimensional features) on this limited corpus. Feature importance analysis reveals that velocity range, note count, and melodic interval statistics are the most discriminative attributes. ANOVA results confirm significant between-composer variance in texture and melody features (p < 0.05). These findings suggest that domain-specific, interpretable features encoding musicological knowledge may be more effective than general-purpose pretrained representations when working with small, specialized corpora—a common scenario in classical music research. The complete experimental pipeline and extracted features are made publicly available to support reproducible research in computational style analysis.

**Keywords**: composer classification, computational musicology, feature extraction, German Lieder, symbolic music analysis

---

## Abstract Writing Notes

### Key Elements Covered:
1. ✅ **Problem**: Composer classification difficulty within same period
2. ✅ **Method**: Three-layer feature framework
3. ✅ **Dataset**: 264 Lieder, three composers
4. ✅ **Key Result**: 74.4% (60D) vs 47.1% (MidiBERT)
5. ✅ **Implication**: Domain-specific features > pretrained for small corpora

### Word Count Check:
- Current draft: ~200 words
- ISMIR requirement: 150-200 words ✓

### Musicological Framing:
- Emphasizes "exploratory" nature
- Connects features to musical concepts (tonal tension, texture)
- Acknowledges shared tradition (same period/genre)

### Revision Checklist:
- [ ] Ensure third-person perspective (double-blind)
- [ ] Verify no self-citations to unpublished work
- [ ] Check keyword relevance for ISMIR audience
- [ ] Confirm numerical accuracy (74.4%, 47.1%, 264 pieces)

---

## Alternative Abstract Versions

### Version A (More Technical Focus):
*Emphasizes methodology and experimental design*

### Version B (More Musicological Focus):
*Emphasizes stylistic questions and interpretive value*

### Version C (Balanced - Recommended):
*Current version balances both perspectives*

---

## Next Steps

1. Finalize abstract after completing all sections
2. Ensure consistency between abstract claims and results
3. Verify all statistics match final experimental data
4. Get feedback on musicological framing
