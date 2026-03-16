# Composer Fingerprinting: A Multi-Layer Feature Approach for Lieder Authorship Attribution

## Abstract

This project investigates whether individual composer style can be captured through computational analysis of symbolic music representations. We propose a three-layer feature framework combining **tonal tension** (Spiral Array Model), **harmonic complexity** (pitch class entropy), and **pianistic texture** (onset density) to classify Lieder by Franz Schubert, Robert Schumann, and Johannes Brahms. Our experiments demonstrate that carefully designed handcrafted features (60 dimensions) achieve 74.4% balanced accuracy, significantly outperforming pretrained transformer embeddings (47.1% for MidiBERT-768D) on this limited corpus of 264 pieces.

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

### 2. Handmade Features (60D)
Comprehensive statistical descriptors across four musical dimensions:

| Category | Features | Musical Interpretation |
|----------|----------|----------------------|
| Pitch | f1-f10 | Range, register preference, pitch class distribution |
| Velocity | f11-f15 | Dynamic range, expressive marking adherence |
| Rhythm/Duration | f16-f23 | Note density, articulation (staccato/legato) |
| Intervals | f24-f30, f52-f60 | Melodic motion preferences (stepwise vs. leaps) |
| Texture | f47-f50 | Chord thickness, simultaneity |
| Higher-order | f31-f34, f35-f46 | Skewness, kurtosis, pitch class histogram |

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

**Extract 60D Handmade Features:**
```bash
python 60.py
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

**Handmade Features (60D):**
```bash
python 60.py
```

**MidiBERT Embeddings (768D):**
```bash
python 768classificationmean.py
```

**Combined Features (12+60=72D):**
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

| Feature Set | Dimensions | Balanced Accuracy | Std Dev |
|-------------|------------|-------------------|---------|
| Statistical (12D) | 12 | 49.3% | 4.7% |
| Handmade Basic (30D) | 30 | ~65% | - |
| Handmade Extended (60D) | 60 | **74.4%** | 2.9% |
| MidiBERT (768D) | 768 | 47.1% | 2.5% |
| Combined (12+60) | 72 | **74.4%** | 2.9% |

### Key Findings

1. **Handcrafted features outperform pretrained embeddings** on small datasets
2. **Top discriminative features**: velocity range (f13), note count (f1), unison ratio (f27)
3. **Optimal subset**: ~23 features achieve peak performance
4. **Tonal tension features** show moderate discriminability (p < 0.05)

### Top 10 Most Important Features (Random Forest Importance)

| Rank | Feature | Importance | Musical Meaning |
|------|---------|------------|-----------------|
| 1 | f13_vel_range | 0.038 | Dynamic range within piece |
| 2 | f1_note_count | 0.031 | Total note count (piece length) |
| 3 | f27_unison_ratio | 0.029 | Repeated notes in melody |
| 4 | pt_std | 0.027 | Texture variation |
| 5 | f24_interval_mean | 0.026 | Average melodic interval size |
| 6 | mc_std | 0.025 | Melodic contour variation |
| 7 | f11_vel_mean | 0.025 | Average dynamics |
| 8 | f3_pitch_std | 0.024 | Pitch range dispersion |
| 9 | f4_pitch_range | 0.024 | Total pitch span |
| 10 | f28_stepwise_ratio | 0.023 | Stepwise melodic motion |

## Project Structure

```
symbolic_2026/
├── README.md                    # This file
├── 12.py                        # Statistical features classification
├── 30.py                        # 30D handmade feature extraction
├── 60.py                        # 60D handmade feature extraction
├── 768classificationmean.py     # MidiBERT classification
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
- Higher velocity variance (f12) indicates expressive dynamic contrasts
- Lower simultaneity (f47) suggests arpeggiated piano textures
- Complex rhythmic patterns (f20_ioi_std) reflect poetic declamation

**Johannes Brahms:**
- Higher pitch range (f4) and note density (f21) indicate richer textures
- Conservative interval patterns (lower f29_leap_ratio)
- Dense chordal writing (higher f50_thick_chord_ratio)

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
