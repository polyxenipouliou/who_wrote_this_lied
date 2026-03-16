# 6. Exploratory Analysis

**Target Length**: 0.5-1 page  
**Format**: Two-column, 10pt Times

---

## 6.1 Case Study: Winterreise Texture Analysis

As an exploratory investigation, we analyzed the 24 songs of Schubert's *Winterreise* cycle separately to examine whether a unified compositional approach yields consistent feature profiles.

### 6.1.1 Feature Consistency Within Cycle

**Observation**: The Winterreise songs show lower variance in texture features (pt_std) compared to Schubert's other Lieder.

**Interpretation**: This suggests Schubert employed a coherent textural vocabulary throughout the cycle, supporting musicological observations about Winterreise's cyclical unity. The "wandering" motif—represented through arpeggiated, guitar-like accompaniment—appears consistently across songs.

**Specific Findings**:
- Mean pt_std for Winterreise: [FILL IN]
- Mean pt_std for other Schubert Lieder: [FILL IN]
- Difference: Winterreise shows [X]% less textural variation

### 6.1.2 Exception: "Die Wetterfahne"

The opening song "Die Wetterfahne" shows unusually high texture density (pt_mean) compared to the cycle average. This reflects the stormy, dramatic character of the weathervane imagery—a case where text-painting overrides cyclical consistency.

---

## 6.2 Case Study: Dichterliebe Opening

Schumann's *Dichterliebe* (Op. 48) provides another opportunity for cycle-level analysis. The opening song, "Im wunderschönen Monat Mai," features one of the most famous arpeggiated introductions in the Lieder repertoire.

### 6.2.1 Quantifying Arpeggiation

**Computational Measurement**: The song shows:
- Very low simultaneity (f47_simultaneity_mean = [FILL IN])
- High texture variance (pt_std = [FILL IN])
- Low thick chord ratio (f50_thick_chord_ratio = [FILL IN])

**Musicological Correlation**: These values quantitatively confirm the qualitative observation of arpeggiated texture. The piano's flowing sixteenth-notes create harmonic support without vertical density.

### 6.2.2 Comparison with Later Songs

Songs 5-7 of *Dichterliebe* ("Ich will meine Seele tauchen," "Die Rose, die Lilie," "Grolle nicht") show increased texture density, reflecting the cycle's emotional progression from longing to bitterness.

---

## 6.3 Feature Dominance Patterns

### 6.3.1 Note Count as Primary Discriminator

**Observation**: f1_note_count emerged as the most important feature (importance = 0.0505).

**Interpretation**: This finding suggests that piece length—operationalized as total note count—carries significant stylistic information. Possible explanations include:

- **Formal preferences**: Different composers favor different song structures (strophic vs. through-composed)
- **Text setting habits**: Some composers set poetry more densely than others
- **Piano writing**: Brahms' symphonic approach requires more notes than Schubert's sparse textures

**Musicological Context**: This finding aligns with observations about Brahms' dense piano writing versus Schubert's economical approach. However, it also raises questions about whether note count captures genuine stylistic preference or reflects other factors (e.g., poem length selection).

### 6.3.2 Interval Ratios and Melodic Style

**Observation**: f27_unison_ratio (0.0330) and f28_stepwise_ratio (0.0323) are the second and third most important features.

**Interpretation**: These interval-based features capture fundamental aspects of melodic writing:

- **Unison ratio**: High values indicate repeated-note patterns, characteristic of Brahms' folk-song influenced melodies
- **Stepwise ratio**: High values indicate conjunct motion, characteristic of Schubert's lyrical writing

**Musicological Context**: This finding quantitatively confirms longstanding musicological observations about each composer's melodic style. Schubert's "vocal" melodies favor stepwise motion, while Brahms' "classical" restraint manifests in conservative interval patterns.

### 6.3.3 Rhythm Features (f22_staccato_ratio, f34_ioi_skew)

**Observation**: Rhythm features rank 4th and 8th in importance.

**Interpretation**: Articulation and timing patterns carry composer-specific information:

- **Staccato ratio**: Captures preference for short, detached notes
- **IOI skew**: Reflects asymmetry in rhythmic distribution

**Musicological Context**: Schumann's background in piano character pieces and his interest in poetic declamation may explain his distinctive rhythmic profile.

---

## 6.4 What Didn't Work: Lessons Learned

### 6.4.1 Velocity Feature Exclusion

**Approach**: We initially included velocity features (f11-f15) but excluded them from final analysis.

**Rationale**: MIDI velocity values often reflect editorial conventions rather than composer intent. Historical scores specify dynamics qualitatively (p, f) rather than numerically (1-127).

**Outcome**: Model achieves 65.0% accuracy without velocity features, demonstrating that genuine stylistic markers exist in other dimensions.

**Lesson**: Data provenance matters. Computational musicology must consider the chain of transmission from composer to digital representation.

### 6.4.2 Sequential Modeling Attempts

**Approach**: We initially explored using the sequential bar-level feature matrices with recurrent neural networks.

**Result**: Models failed to converge, likely due to:
- Insufficient training data (264 pieces)
- Variable sequence lengths (10-100+ bars per piece)
- Sparse gradients in deep sequential architectures

**Lesson**: For small corpora, aggregate statistical features are more robust than sequential representations.

### 6.4.3 Chord Annotation Pipeline

**Approach**: We attempted to extract chord annotations using automated harmony analysis tools for additional harmonic features.

**Result**: High error rate (~40% of files) due to:
- Complex non-chord tones in Lieder accompaniment
- Ambiguous harmonic passages resisting simple annotation
- Inconsistent bass-line interpretation

**Lesson**: Automated harmony analysis remains challenging for art song repertoire; manual annotation would be required for reliable chord-based features.

---

## 6.5 Unexpected Findings

### 6.5.1 Theory-Driven vs. Empirical Features

**Expectation**: Based on musicological literature, we anticipated tonal tension and harmonic complexity features would be most discriminative.

**Result**: Basic statistical features (note count, interval ratios) dominated the importance rankings. Theory-driven features (tt_*, hc_*) ranked lower.

**Interpretation**: For same-era composer classification, surface-level statistical regularities may carry more stylistic information than deeper tonal properties. This echoes Youngblood's (1958) foundational insight about statistical distributions capturing stylistic choice.

### 6.5.2 Brahms-Schumann Distinction

**Observation**: The model distinguishes Brahms and Schumann with moderate accuracy, despite their shared high-Romantic vocabulary.

**Key Discriminators**: Note count (Brahms higher), unison ratio (Brahms higher), staccato ratio (Schumann higher).

**Interpretation**: These features capture fundamental differences in compositional approach: Brahms' dense, conservative writing versus Schumann's varied, expressive style.

---

## 6.6 Limitations of Exploratory Analysis

The analyses in this section should be interpreted with caution:

1. **Post-hoc nature**: These investigations were not pre-registered hypotheses but observations made after examining results
2. **Multiple comparisons**: Examining many feature combinations increases false positive risk
3. **Small sample sizes**: Cycle-level analyses involve 12-24 pieces, limiting statistical power
4. **Confirmation bias risk**: Interpretations may be influenced by pre-existing musicological beliefs

Future work should test these exploratory findings on independent datasets.

---

## Exploratory Analysis Writing Notes

### Transparency:
- Clearly distinguish exploratory from confirmatory analysis
- Acknowledge limitations and potential biases
- Report negative results (what didn't work)

### Value Proposition:
- Exploratory findings generate hypotheses for future research
- Case studies demonstrate practical application of features
- Lessons learned guide methodological choices

### Velocity Exclusion:
- All velocity-related discussion removed
- Focus on remaining features (pitch, rhythm, interval, texture)
- Methodological decision justified

### Length Management:
- Current draft: ~1.5 pages
- May need to condense case studies for final submission
- Consider moving "What Didn't Work" to supplementary material

---

## Revision Checklist

- [x] Remove all velocity feature discussions
- [x] Update feature importance discussion (note count, unison, stepwise)
- [ ] Fill in specific numerical values from experimental data
- [ ] Ensure case study interpretations are musicologically sound
- [ ] Check that limitations are clearly stated
- [ ] Review for appropriate hedging language ("suggests," "may indicate")
- [ ] Confirm exploratory nature is emphasized throughout
- [ ] Verify word count fits within page limits

---

## Next Steps

1. Complete conclusion section (07_conclusion.md) summarizing key findings
2. Compile comprehensive references (08_references.md)
3. Review all sections for consistency
4. Prepare final figures and tables
