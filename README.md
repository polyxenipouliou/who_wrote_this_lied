# Composer Fingerprinting: A Multi-Layer Feature Approach for Lieder Authorship Attribution

## Abstract

This project investigates whether individual composer style can be captured through computational analysis of symbolic music representations. We propose a three-layer feature framework combining **tonal tension** (Spiral Array Model), **harmonic complexity** (pitch class entropy), and **pianistic texture** (onset density) to classify Lieder by Franz Schubert, Robert Schumann, and Johannes Brahms. Our experiments demonstrate that carefully designed handcrafted features (55 dimensions, velocity features excluded to avoid editorial bias) achieve 65.0% balanced accuracy using a Support Vector Machine classifier, with peak performance of ~70% using only the top 21 features. This significantly outperforms pretrained transformer embeddings (45.3% for MidiBERT-768D with MLP) on this limited corpus of 264 pieces.

## Dataset

| Composer | Number of Lieder | Percentage |
|----------|------------------|------------|
| Franz Schubert | 84 | 31.8% |
| Johannes Brahms | 109 | 41.3% |
| Robert Schumann | 71 | 26.9% |
| **Total** | **264** | **100%** |

**Data Sources:**
- [OpenScore Lieder Repository](https://github.com/OpenScore/Lieder)
- [Schubert Winterreise Dataset](https://winterreise.org/)

## Feature Sets

### 1. Statistical Features (12D)
Derived from the three-layer theoretical framework:
- **Tonal Tension** (`tt_mean`, `tt_std`, `tt_entropy`): Euclidean distance in Spiral Array space
- **Harmonic Complexity** (`hc_mean`, `hc_std`, `hc_entropy`): Pitch class distribution entropy
- **Melodic Contour** (`mc_mean`, `mc_std`, `mc_entropy`): Interval succession statistics
- **Pianistic Texture** (`pt_mean`, `pt_std`, `pt_entropy`): Onset density per beat

### 2. Handmade Features (55D)
Comprehensive statistical descriptors across four musical dimensions. **Note:** Velocity features (f11-f15) were excluded to avoid editorial bias in MIDI transcriptions.

| Category | Features | Count | Musical Interpretation |
|----------|----------|-------|----------------------|
| Pitch | f1-f10 | 10 | Range, register preference, pitch class distribution |
| Rhythm/Duration | f16-f23 | 8 | Note density, articulation (staccato/legato) |
| Intervals | f24-f30, f52-f60 | 17 | Melodic motion preferences (stepwise vs. leaps) |
| Texture | f47-f50 | 4 | Chord thickness, simultaneity |
| Higher-order | f31-f34, f35-f46 | 16 | Skewness, kurtosis, pitch class histogram |
| **Total** | | **55** | |

### 3. MidiBERT Embeddings (768D)
Pre-trained transformer representations extracted using [Adversarial-MidiBERT](https://github.com/RS2002/Adversarial-MidiBERT).

## Installation

### Requirements
```
Python 3.8+
music21>=8.0
pandas>=1.5
numpy>=1.21
scikit-learn>=1.0
scipy>=1.7
matplotlib>=3.5
seaborn>=0.11
torch>=1.9
transformers>=4.0
```

### Install Dependencies
```bash
pip install music21 pandas numpy scikit-learn scipy matplotlib seaborn
pip install torch transformers
```

## Usage

### Feature Extraction

**Extract 55D Handmade Features (no velocity):**
```bash
python 60.py  # Note: velocity features excluded in analysis
```

**Extract MidiBERT Embeddings:**
```bash
cd Adversarial-MidiBERT
python get_feature.py
```

### Classification Experiments

**Statistical Features (12D):**
```bash
python 12.py
```

**Handmade Features (55D, no velocity):**
```bash
python see_importance.py  # Feature selection + SVM classification
```

**MidiBERT Embeddings (768D) with MLP:**
```bash
python training.py  # MLP classification
```

**Combined Features (12+55=67D):**
```bash
python conbine_features.py  # Merge features first
python see_importance.py    # Feature selection + classification
```

### Analysis

**ANOVA Discriminability Analysis:**
```bash
python anova_12.py
```

**Feature Importance & Selection Curve:**
```bash
python see_importance.py
```

## Results Summary

### Classification Performance (Balanced Accuracy)

| Feature Set | Dimensions | Balanced Accuracy | Std Dev | Notes |
|-------------|------------|-------------------|---------|-------|
| Statistical (12D) | 12 | 49.3% | 4.7% | Theory-driven only |
| Handmade (55D, no vel) | 55 | **65.0%** | 5.6% | All features |
| Handmade (21D, top) | 21 | **~70%** | ~5% | Feature selection |
| MidiBERT (768D) + MLP | 768 | 45.3% | - | Pretrained embeddings |

### Key Findings

1. **Handcrafted features outperform pretrained embeddings** on small datasets (65.0% vs 45.3%)
2. **Top discriminative features**: note count (f1), unison ratio (f27), stepwise ratio (f28), staccato ratio (f22), pitch std (f3)
3. **Optimal feature subset**: ~21 features achieve peak performance (~70%)
4. **Velocity features excluded** to avoid editorial bias in MIDI transcriptions

### Top 10 Most Important Features (Random Forest Importance, 55D no velocity)

| Rank | Feature | Importance | Category | Musical Meaning |
|------|---------|------------|----------|-----------------|
| 1 | f1_note_count | 0.0505 | Pitch | Total note count (piece length) |
| 2 | f27_unison_ratio | 0.0330 | Interval | Repeated notes in melody |
| 3 | f28_stepwise_ratio | 0.0323 | Interval | Stepwise melodic motion |
| 4 | f22_staccato_ratio | 0.0315 | Rhythm | Short note proportion |
| 5 | f3_pitch_std | 0.0306 | Pitch | Pitch range dispersion |
| 6 | f24_interval_mean | 0.0306 | Interval | Average melodic interval size |
| 7 | f4_pitch_range | 0.0305 | Pitch | Total pitch span |
| 8 | f34_ioi_skew | 0.0289 | Rhythm | IOI distribution asymmetry |
| 9 | f5_unique_pitches | 0.0281 | Pitch | Number of unique pitches |
| 10 | f25_interval_std | 0.0270 | Interval | Interval size variation |

## Project Structure

```
symbolic_2026/
├── README.md                    # This file
├── 12.py                        # Statistical features classification
├── 30.py                        # 30D handmade feature extraction
├── 60.py                        # 60D (55D used) handmade feature extraction
├── 768classificationmean.py     # MidiBERT classification with SVM
├── training.py                  # MLP classification
├── conbine_features.py          # Feature merging
├── anova_12.py                  # ANOVA analysis
├── see_importance.py            # Feature importance analysis
├── clean_data.py                # Data preprocessing
├── Adversarial-MidiBERT/        # MidiBERT model & extraction
│   ├── model.py
│   ├── get_feature.py
│   └── Octuple.pkl
├── dataset/                     # Original MusicXML scores
│   └── *.mxl
├── midi_files/                  # Converted MIDI files
│   └── *.mid
├── features/                    # Extracted feature CSVs
│   ├── features_statistical.csv
│   ├── features_sequential.csv
│   └── midibert_768d_features.csv
└── musif_output/                # musif library output
    └── jsymbolic_output/
```

## Musicological Interpretation

### What Features Reveal About Composer Style

**Franz Schubert:**
- Higher stepwise ratio (f28) reflects lyrical, vocal melody writing
- Lower texture density aligns with guitar-like accompaniment patterns
- Moderate harmonic complexity supports text expression

**Robert Schumann:**
- Higher rhythm variance (f22_staccato_ratio) indicates varied articulation
- Lower simultaneity suggests arpeggiated piano textures
- Complex rhythmic patterns reflect poetic declamation

**Johannes Brahms:**
- Higher pitch range (f4) and note density (f1) indicate richer textures
- Conservative interval patterns (f27_unison_ratio) reflect classical influence
- Dense chordal writing (f50_thick_chord_ratio) shows symphonic piano writing

## Velocity Feature Exclusion

**Important Methodological Note:** This study explicitly excludes velocity features (f11-f15) from analysis. MIDI velocity values in symbolic datasets often reflect editorial conventions of score transcribers rather than composer intent, as historical scores from the Romantic era specify dynamics qualitatively (e.g., `p`, `f`) rather than as numerical values (1-127). To ensure our model captures genuine stylistic patterns rather than data source artifacts, velocity features were excluded from all primary analyses.

## Citation

If you use this code or dataset, please cite:

```bibtex
@unpublished{wu2026composer,
  title={Composer Fingerprinting: A Multi-Layer Feature Approach for Lieder Authorship Attribution},
  author={Wu, Yuhang and Pouliou, Jenny},
  note={Course Project, 2026},
  year={2026}
}
```

## License

This project is for educational and research purposes. Data sources (OpenScore, Winterreise Dataset) have their respective licenses.

## Acknowledgments

- [OpenScore](https://openscore.nl/) for the Lieder corpus
- [Adversarial-MidiBERT](https://github.com/RS2002/Adversarial-MidiBERT) team for the pretrained model
- Herremans & Chew for the Spiral Array Model implementation guidance
