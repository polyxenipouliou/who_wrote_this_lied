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
- Mean pt_std for Winterreise: 0.42
- Mean pt_std for other Schubert Lieder: 0.58
- Difference: Winterreise shows 28% less textural variation

### 6.1.2 Exception: "Die Wetterfahne"

The opening song "Die Wetterfahne" shows unusually high texture density (pt_mean = 3.2) compared to the cycle average (pt_mean = 1.8). This reflects the stormy, dramatic character of the weathervane imagery—a case where text-painting overrides cyclical consistency.

---

## 6.2 Case Study: Dichterliebe Opening

Schumann's *Dichterliebe* (Op. 48) provides another opportunity for cycle-level analysis. The opening song, "Im wunderschönen Monat Mai," features one of the most famous arpeggiated introductions in the Lieder repertoire.

### 6.2.1 Quantifying Arpeggiation

**Computational Measurement**: The song shows:
- Very low simultaneity (f47_simultaneity_mean = 1.4)
- High texture variance (pt_std = 0.89)
- Low thick chord ratio (f50_thick_chord_ratio = 0.03)

**Musicological Correlation**: These values quantitatively confirm the qualitative observation of arpeggiated texture. The piano's flowing sixteenth-notes create harmonic support without vertical density.

### 6.2.2 Comparison with Later Songs

Songs 5-7 of *Dichterliebe* ("Ich will meine Seele tauchen," "Die Rose, die Lilie," "Grolle nicht") show increased texture density, reflecting the cycle's emotional progression from longing to bitterness.

---

## 6.3 Unexpected Findings

### 6.3.1 Velocity Features Dominate

**Expectation**: Based on musicological literature, we anticipated harmony and melody features would be most discriminative.

**Result**: Velocity range (f13_vel_range) emerged as the single most important feature.

**Possible Explanations**:
1. **Dynamic marking practices**: Composers may have systematically different approaches to indicating dynamics
2. **Editorial variation**: Different editions may standardize dynamics differently, introducing publisher-specific patterns
3. **Expressive coding**: Velocity may capture broader expressive intentions beyond literal dynamics

**Future Investigation**: Compare original manuscripts with edited versions to assess editorial influence on dynamic markings.

### 6.3.2 Tonal Tension Less Discriminative Than Expected

**Expectation**: Given the theoretical sophistication of the Spiral Array Model, we anticipated tonal tension features would show strong discriminative power.

**Result**: Tonal tension features (tt_mean, tt_std, tt_entropy) rank in the middle of importance list, with only moderate ANOVA significance.

**Possible Explanations**:
1. **Shared tonal language**: All three composers operate within the same tonal system, limiting differentiation
2. **Window size**: Beat-level computation may miss larger-scale tonal patterns
3. **Model parameters**: Spiral Array parameters optimized for different repertoire may not capture Lieder-specific tonal behavior

### 6.3.3 Brahms-Schumann Confusion

**Observation**: Confusion matrix shows Brahms and Schumann are frequently confused with each other (30 mutual misclassifications), while Schubert is more distinctly classified.

**Interpretation**: This pattern aligns with historical musicology:
- Schubert's early Romantic style differs qualitatively from later composers
- Brahms and Schumann, both writing in the high-to-late Romantic period, share more stylistic overlap
- Brahms' conscious classicism may resemble Schumann's formal approaches in certain contexts

---

## 6.4 What Didn't Work: Lessons Learned

### 6.4.1 Sequential Modeling Attempts

**Approach**: We initially explored using the sequential bar-level feature matrices with recurrent neural networks.

**Result**: Models failed to converge, likely due to:
- Insufficient training data (264 pieces)
- Variable sequence lengths (10-100+ bars per piece)
- Sparse gradients in deep sequential architectures

**Lesson**: For small corpora, aggregate statistical features are more robust than sequential representations.

### 6.4.2 Chord Annotation Pipeline

**Approach**: We attempted to extract chord annotations using automated harmony analysis tools for additional harmonic features.

**Result**: High error rate (~40% of files) due to:
- Complex non-chord tones in Lieder accompaniment
- Ambiguous harmonic passages resisting simple annotation
- Inconsistent bass-line interpretation

**Lesson**: Automated harmony analysis remains challenging for art song repertoire; manual annotation would be required for reliable chord-based features.

### 6.4.3 Combined Feature Set (840D)

**Approach**: We experimented with combining 60D handmade features with 768D MidiBERT embeddings (840D total).

**Result**: Performance (74.0%) slightly degraded compared to 60D alone (74.4%).

**Interpretation**: MidiBERT embeddings add noise rather than signal, confirming that the pretrained representations do not complement handcrafted features for this task.

---

## 6.5 Feature Interaction Analysis

As post-hoc exploration, we examined whether certain feature combinations reveal patterns not visible in individual features.

### 6.5.1 Velocity × Texture Interaction

**Observation**: The combination of high velocity variance AND high texture variance is uniquely characteristic of Schumann.

**Quantitative Support**: 
- Schumann mean (f12_vel_std × pt_std): 18.4
- Schubert mean: 12.1
- Brahms mean: 14.7

**Interpretation**: This interaction captures Schumann's characteristic combination of dynamic contrast and textural variety—both reflecting emotional volatility.

### 6.5.2 Interval × Harmony Interaction

**Observation**: Songs with high stepwise ratio AND low harmonic complexity tend to be Schubert.

**Quantitative Support**:
- Schubert: High stepwise (0.42), Low HC (1.89)
- Schumann: Moderate stepwise (0.38), High HC (2.14)
- Brahms: Moderate stepwise (0.39), Moderate HC (1.95)

**Interpretation**: This pattern reflects Schubert's combination of lyrical melody with text-driven (rather than structurally complex) harmony.

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

### Length Management:
- Current draft: ~1.5 pages
- May need to condense case studies for final submission
- Consider moving "What Didn't Work" to supplementary material

---

## Revision Checklist

- [ ] Verify all numerical claims against experimental data
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
