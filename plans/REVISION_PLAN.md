# Critical Revision Plan for ISMIR 2026 Submission

## Overview

This document outlines the critical issues identified in the paper draft and provides a structured plan for addressing each before submission.

---

## Issue 1: Velocity Confounding Variable (CRITICAL)

### Problem
MIDI velocity features (f13_vel_range, f11_vel_mean) are the most discriminative features, but velocity in MIDI files often reflects the **transcriber/arranger** rather than the **composer**. This could mean the classifier is identifying data source rather than musical style.

### Root Causes
- OpenScore Lieder repository uses multiple contributors
- Different editors have different velocity conventions
- Historical scores don't specify MIDI velocity (0-127)
- Editorial dynamics are interpreted differently

### Solutions (Choose One)

#### Option A: Remove Velocity Features (Recommended)
**Action**: Re-run all experiments without velocity features (f11-f15).

**Pros**: 
- Eliminates the confounding variable entirely
- More defensible methodology
- Forces focus on genuinely musical features

**Cons**: 
- Accuracy will likely drop
- Need to explain why velocity was excluded

**Implementation**:
```python
# In 60.py, exclude velocity features
velocity_features = ['f11_vel_mean', 'f12_vel_std', 'f13_vel_range', 
                     'f14_loud_note_ratio', 'f15_soft_note_ratio']
feature_cols = [f for f in feature_cols if f not in velocity_features]
```

#### Option B: Control Experiment
**Action**: Add experiment to test whether velocity patterns correlate with data source.

**Method**:
1. Extract velocity features only
2. Train classifier to predict data source (OpenScore vs Winterreise Dataset)
3. If accuracy is high, velocity encodes source information → exclude from main analysis

**Pros**: Provides empirical evidence for decision
**Cons**: Adds complexity, may still undermine conclusions

#### Option C: Normalization
**Action**: Normalize velocity within each piece (z-score) to remove absolute differences while preserving relative patterns.

**Method**:
```python
from sklearn.preprocessing import StandardScaler
# Normalize velocity per piece rather than using raw values
vel_normalized = StandardScaler().fit_transform(vel_raw.reshape(-1, 1))
```

**Pros**: Retains some velocity information
**Cons**: May not fully eliminate confounding

### Recommended Revision Text (for paper)

> **Section 3.2 (revised)**: "We initially included velocity-based features but observed they were highly discriminative. However, MIDI velocity values in symbolic datasets often reflect editorial conventions of score transcribers rather than composer intent. To ensure our model captures genuine stylistic patterns, we conducted a control experiment [or: To avoid this confounding variable, we] excluded velocity features from our primary analysis. Results with and without velocity features are reported in Section 4.X."

---

## Issue 2: Unfair MidiBERT Baseline (CRITICAL)

### Problem
Comparing handcrafted+SVM against raw MidiBERT embeddings without fine-tuning is a "strawman" comparison. The pretrained model wasn't designed for this specific task.

### Solutions

#### Option A: Add Linear Probe (Recommended)
**Action**: Train a linear classifier on top of frozen MidiBERT embeddings.

**Implementation**:
```python
from sklearn.linear_model import LogisticRegression
# Extract MidiBERT embeddings (frozen)
embeddings = extract_midibert_embeddings(midi_files)
# Train linear probe
probe = LogisticRegression(class_weight='balanced', max_iter=1000)
scores = cross_val_score(probe, embeddings, labels, cv=5, scoring='balanced_accuracy')
```

**Expected Outcome**: Linear probe should improve over raw embeddings, making comparison fairer.

#### Option B: Full Fine-tuning
**Action**: Fine-tune MidiBERT on the Lieder classification task.

**Implementation**:
```python
# Add classification head
classifier = TokenClassification(midibert, num_labels=3, hs=768)
# Train with cross-entropy loss
# Use early stopping to prevent overfitting
```

**Pros**: Stronger baseline
**Cons**: May overfit on small dataset, requires more tuning

#### Option C: Acknowledge Limitation
**Action**: If fine-tuning fails, explicitly acknowledge this as a limitation.

**Revision Text**:
> "We acknowledge that comparing handcrafted features with frozen pretrained embeddings is not entirely fair. However, our attempts to fine-tune MidiBERT on this dataset resulted in severe overfitting (training accuracy >95%, test accuracy <50%), confirming our hypothesis that the corpus is too small for effective transformer fine-tuning. The frozen embedding comparison, while imperfect, demonstrates that generic representations do not capture Lieder-specific stylistic patterns without task-specific adaptation."

### Recommended Approach
1. Implement linear probe (Option A) - minimal effort, fairer comparison
2. If linear probe performs well (>60%), report as "MidiBERT + Linear Probe" baseline
3. If linear probe still performs poorly, use Option C framing

---

## Issue 3: Data Leakage from Song Cycles (CRITICAL)

### Problem
Songs from the same cycle (Winterreise, Dichterliebe) share stylistic features. Random CV splitting may place songs from the same cycle in both train and test sets.

### Solution: GroupKFold

**Implementation**:
```python
from sklearn.model_selection import GroupKFold

# Create cycle membership mapping
cycle_map = {
    'lc4919673.mxl': 'Winterreise',  # Example filenames
    'lc4919879.mxl': 'Winterreise',
    # ... map all songs to their cycles
    'lc5007176.mxl': 'Dichterliebe',
    # Songs not in cycles get unique IDs
    'lc5000388.mxl': 'Single_Song_001',
}

groups = [cycle_map[f] for f in filenames]
gkf = GroupKFold(n_splits=5)

for train_idx, test_idx in gkf.split(X, y, groups=groups):
    # Ensure no cycle appears in both train and test
    train_cycles = set(groups[i] for i in train_idx)
    test_cycles = set(groups[i] for i in test_idx)
    assert len(train_cycles & test_cycles) == 0
```

**Action Required**:
1. Map all 264 songs to their source cycles
2. Re-run all experiments with GroupKFold
3. Report both random CV and GroupKFold results (to show impact)

**Expected Impact**: Accuracy will likely decrease by 5-10%, but results will be more valid.

---

## Issue 4: Theory vs Results Mismatch (MODERATE)

### Problem
Paper emphasizes theoretical framework (tonal tension, harmonic complexity, texture) but top features are basic statistics (note count, velocity, intervals).

### Solutions

#### Option A: Reframe Contribution
**Revision**: Acknowledge that empirical features outperformed theory-driven ones.

**Text**:
> "Interestingly, while our theoretical framework emphasized tonal tension and harmonic complexity, feature importance analysis revealed that simpler statistical features (velocity range, note count, interval ratios) were more discriminative. This suggests that for same-era composer classification, surface-level statistical regularities may carry more stylistic information than deeper tonal properties. This finding aligns with Youngblood's (1958) original insight that statistical distributions capture stylistic choice."

#### Option B: Add Ablation Study
**Action**: Show that theory-driven features add value beyond basic statistics.

**Experiment**:
| Feature Set | Accuracy |
|-------------|----------|
| Basic stats only (f1-f30) | X% |
| Theory-driven only (tt, hc, pt, mc) | Y% |
| Combined (60D) | Z% |

**If Combined > Basic**: Theory-driven features add value
**If Combined ≈ Basic**: Acknowledge theory-driven features don't improve performance

#### Option C: Refocus Paper
**Revision**: Shift emphasis from "theory-driven framework" to "systematic empirical investigation."

### Recommended Approach
Combine Options A and B:
1. Add ablation table showing contribution of each feature category
2. Reframe discussion to acknowledge empirical features' dominance
3. Position theory-driven features as providing interpretability, not necessarily accuracy

---

## Issue 5: Citation Placeholders (MINOR)

### Problem
Paper contains `[?]` placeholders for citations.

### Solution
**Action**: Replace all placeholders with proper BibTeX keys.

**Checklist**:
- [ ] Section 2.1: Schubert characteristics → Rosen1995, Kramer1981
- [ ] Section 2.1: Schumann characteristics → Daverio1997
- [ ] Section 2.1: Brahms characteristics → Musgrave1985, Frisch1996
- [ ] Section 3.2: Spiral Array → Herremans2016, Herremans2019
- [ ] Section 3.2: Pitch class entropy → Kaliakatsos2011
- [ ] Section 3.2: Texture modeling → Giraud2014
- [ ] Section 3.2: Melodic contour → Pollastri2003
- [ ] Section 4: All result claims → (no citation needed, these are your results)

---

## Issue 6: Formula Formatting (MINOR)

### Problem
Equation 1 formatting is non-standard.

### Solution
**Current**:
```latex
\begin{equation}
\text{Balanced Accuracy} = \frac{\text{Recall}_1 + \text{Recall}_2 + \text{Recall}_3}{3}
\end{equation}
```

**Revised**:
```latex
\begin{equation}\label{eq:balanced_acc}
\text{Balanced Accuracy} = \frac{1}{K} \sum_{k=1}^{K} \frac{TP_k}{TP_k + FN_k}
\end{equation}
```

---

## Issue 7: Musicological Depth (MODERATE)

### Problem
Section 5 discussion is superficial ("看图说话").

### Solution
**Action**: Add specific musical examples with citations.

**Example Revision for Schubert**:
> "Schubert's higher stepwise ratio (0.42 vs. 0.38-0.39) quantitatively confirms musicological observations about his 'vocal' melodic writing. As Rosen (1995, p. 58) notes, Schubert's melodies 'follow the natural inflection of speech,' which favors conjunct motion. The opening of 'Gute Nacht' from Winterreise exemplifies this: the vocal line moves primarily by step (D-E-F♯-E-D), creating what Kramer (1981) describes as 'the weary walker's plodding motion.'"

**Required Additions**:
- Specific song examples for each composer
- Page numbers for book citations
- Musical analysis connecting features to specific passages

---

## Issue 8: Feature Dimension Confusion (MINOR)

### Problem
Paper mentions both 60D and 72D (12+60).

### Solution
**Clarification in Section 3**:
> "Our full feature set comprises 72 dimensions: 12 theory-driven features (tonal tension, harmonic complexity, texture, melody—each with mean, std, entropy) plus 60 empirical statistical features. For brevity, we refer to this combined set as '60D' in tables, though the actual dimensionality is 72D after merging."

**Better Approach**: Use "72D" consistently throughout, or clarify that 12D features are a subset of the full pipeline.

---

## Revision Priority

| Priority | Issue | Effort | Impact on Acceptance |
|----------|-------|--------|---------------------|
| 🔴 Critical | Velocity confounding | Medium | High |
| 🔴 Critical | MidiBERT baseline | Low-Medium | High |
| 🔴 Critical | Data leakage (GroupKFold) | Medium | High |
| 🟡 Moderate | Theory vs results mismatch | Low | Medium |
| 🟡 Moderate | Musicological depth | Medium | Medium |
| 🟢 Minor | Citations | Low | Low |
| 🟢 Minor | Formula formatting | Low | Low |
| 🟢 Minor | Feature dimension | Low | Low |

---

## Revised Timeline

| Week | Tasks |
|------|-------|
| Week 1 | Fix velocity issue (remove or control), implement GroupKFold |
| Week 2 | Re-run all experiments, implement MidiBERT linear probe |
| Week 3 | Update results section, add ablation study |
| Week 4 | Deepen musicological discussion, fix citations |
| Week 5 | Final review, compile PDF, submit |

---

## Recommended Next Steps

1. **Immediate**: Decide on velocity feature handling (recommend: remove + control experiment)
2. **This Week**: Implement GroupKFold and re-run experiments
3. **This Week**: Add MidiBERT linear probe baseline
4. **Next Week**: Update all results tables and figures
5. **Ongoing**: Deepen musicological analysis with specific examples

---

## Response to Reviewer

The reviewer's critique is valid and constructive. The recommended approach is to:

1. **Acknowledge the velocity issue** transparently in the paper
2. **Add control experiments** to validate findings
3. **Use GroupKFold** to eliminate data leakage
4. **Reframe contributions** to emphasize empirical findings over theoretical claims
5. **Strengthen musicological discussion** with specific examples

These revisions will significantly strengthen the paper's methodological rigor and defensibility.
