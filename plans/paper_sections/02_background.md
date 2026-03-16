# 2. Background and Related Work

**Target Length**: 1.5 pages  
**Format**: Two-column, 10pt Times

---

## 2.1 The German Lieder Tradition

The German Lied (art song) represents one of the most intimate and expressive genres of Western classical music. Emerging in the late 18th century and flourishing throughout the Romantic period (1800-1900), the Lied combines poetry and music in a partnership between voice and piano that demands both technical sophistication and emotional depth.

### 2.1.1 Historical Context

**Franz Schubert (1797-1828)** stands as the foundational figure of the German Lied tradition. Over his short life, Schubert composed more than 600 Lieder, establishing many of the genre's conventions. His song cycles *Die schöne Müllerin* (1823) and *Winterreise* (1827) remain cornerstones of the repertoire. Musicologically, Schubert's Lieder are characterized by:

- **Lyrical melody**: Stepwise, singable lines that mirror natural speech rhythms
- **Guitar-like accompaniment**: Arpeggiated patterns evoking folk instrument traditions
- **Text-driven harmony**: Chromaticism employed for expressive word-painting rather than structural purposes
- **Strophic and through-composed forms**: Flexible approaches to musical structure based on poetic form

**Robert Schumann (1810-1856)** represents the high Romantic approach to Lieder composition. His famous year of song (1840) produced masterpieces including the cycle *Dichterliebe*. Schumann's style is distinguished by:

- **Piano independence**: The piano part achieves equal status with the voice, often carrying postludes of substantial length
- **Arpeggiated textures**: Flowing, virtuosic piano writing that creates atmospheric backgrounds
- **Psychological depth**: Musical gestures that reflect the inner emotional state of the poetic speaker
- **Cyclic unity**: Thematic connections across songs within a cycle

**Johannes Brahms (1833-1897)** composed nearly 200 Lieder while maintaining a conscious connection to classical forms. His approach reflects:

- **Conservative harmony**: Diatonic language with carefully controlled chromaticism
- **Dense texture**: Rich, chordal piano writing reflecting symphonic sensibilities
- **Folk song influence**: Simple, direct melodies inspired by *Volkslieder*
- **Classical restraint**: Emotional expression channeled through formal control

### 2.1.2 The Classification Challenge

The shared tradition of these three composers presents a particular challenge for computational classification. All three worked within:

- The same tonal system (major-minor key organization)
- Similar formal conventions (strophic, through-composed, modified strophic)
- Comparable instrumental forces (voice and piano)
- Related poetic traditions (Goethe, Heine, Rückert)

Yet musicologists and performers recognize distinct stylistic fingerprints. The central question of this research is whether computational methods can capture these subtle but perceptible differences.

---

## 2.2 Computational Composer Classification

### 2.2.1 Early Statistical Approaches

The statistical characterization of musical style dates to Youngblood's (1958) pioneering work, which applied information-theoretic measures to classify composers based on pitch and rhythm distributions. Youngblood's approach established the fundamental premise that composer style could be quantified through statistical regularities in musical surfaces.

Simonetta (2025) traces the evolution from these early statistical methods to modern computational approaches, noting that the field shifted from purely statistical descriptions to machine learning-based classification in the 1990s. Key milestones include:

- **N-gram representations**: Modeling sequences of musical events (notes, intervals, chords) as probabilistic transitions
- **Hidden Markov Models**: Capturing temporal structure in melodic and harmonic progressions
- **Support Vector Machines**: Finding optimal decision boundaries in high-dimensional feature spaces

### 2.2.2 Feature-Based Approaches

Recent work has explored diverse feature representations for composer classification:

**Tonal Features**: The Tonal Interval Vector (TIV) framework provides a geometric representation of pitch class distributions that captures harmonic content independent of absolute pitch. TIV-based features have shown effectiveness for harmony-related classification tasks.

**Melodic Features**: Pollastri and Simoncelli (2003) demonstrated that melodic contour—represented as sequences of interval directions and sizes—contains significant composer-specific information. Their work established melody as a primary carrier of stylistic identity.

**Rhythmic Features**: Duration distributions, note density, and temporal patterns have been employed as complementary features, though rhythmic style appears less discriminative than pitch-based features for same-era composers.

**Texture Features**: Giraud et al. (2014) proposed modeling musical texture in layers (melodic vs. accompaniment), recognizing that the relationship between voices carries stylistic information beyond individual pitch content.

### 2.2.3 Machine Learning Architectures

The choice of classification model has evolved alongside feature engineering:

| Study | Features | Classifier | Dataset | Accuracy |
|-------|----------|------------|---------|----------|
| Alvarez et al. (2024) | Melodic n-grams | SVM | Multi-era | ~85% |
| Kaliakatsos et al. (2011) | Pitch class entropy | Various | Bach chorales | ~70% |
| HMM-based (2001) | Melodic sequences | HMM | Classical era | ~75% |

*Table 1: Representative composer classification studies. Note that era-level classification typically achieves higher accuracy than same-era classification.*

---

## 2.3 Deep Learning vs. Handcrafted Features

### 2.3.1 The Rise of Pretrained Music Models

The success of transformer-based models in natural language processing inspired similar approaches for symbolic music. Key developments include:

**MusicBERT**: Adapted from BERT architecture for music understanding, using tokenized musical sequences and masked language modeling objectives.

**MidiBERT-Piano**: Extended the MusicBERT approach with piano-specific tokenization and larger training corpora.

**Adversarial-MidiBERT** (Zhao, 2025): Introduced adversarial training objectives to improve representation learning, achieving state-of-the-art results on several music understanding benchmarks.

These pretrained models offer the advantage of learning representations from large-scale data without manual feature engineering. However, their effectiveness depends critically on:

1. **Training data scale**: Models with millions of parameters require substantial training data
2. **Domain match**: Pretraining corpus should resemble target application domain
3. **Fine-tuning capacity**: Sufficient labeled data needed for task-specific adaptation

### 2.3.2 The Small Corpus Problem

Classical music corpora present unique challenges for deep learning approaches:

- **Limited availability**: High-quality symbolic representations of classical works are scarce compared to popular music
- **Annotation cost**: Expert musicological labeling is expensive and time-consuming
- **Class imbalance**: Some composers have vastly more surviving works than others

This creates a scenario where handcrafted features encoding domain knowledge may outperform general pretrained representations—a hypothesis we test in this study.

### 2.3.3 Feature Libraries

Several software libraries facilitate automated feature extraction from symbolic music:

**jSymbolic** (McKay & Fujinaga, 2006): Extracts over 300 features from MIDI files, including pitch, rhythm, dynamics, and texture descriptors. Widely used in music information retrieval research.

**musif** (Llorens et al., 2023): Python library for feature extraction from MusicXML, offering modern implementation and extensibility.

Our approach differs from these general-purpose tools in its theoretical grounding: each feature is selected based on musicological hypotheses about composer style rather than comprehensive coverage.

---

## 2.4 Gap Identification

Our literature review reveals several gaps in existing research:

1. **Limited same-era studies**: Most composer classification work focuses on distinguishing different historical periods rather than individual styles within a shared tradition.

2. **Insufficient musicological interpretation**: Many computational studies report classification accuracy without connecting findings to musicological understanding of composer style.

3. **Black-box features**: Deep learning approaches sacrifice interpretability for performance, making it difficult to understand what musical characteristics drive classification decisions.

4. **Lieder underrepresentation**: Despite the genre's importance in classical music, computational analysis of Lieder remains limited compared to instrumental music.

This project addresses these gaps by:
- Focusing specifically on same-era Lieder classification
- Providing detailed musicological interpretation of computational findings
- Using interpretable, theory-grounded features
- Releasing a curated Lieder dataset with extracted features

---

## Background Section Writing Notes

### Key Citations:
- Youngblood (1958) - Foundational statistical approach
- Simonetta (2025) - Comprehensive survey
- Herremans & Chew (2016, 2019) - Spiral Array Model
- Pollastri & Simoncelli (2003) - Melodic contour
- Giraud et al. (2014) - Texture modeling
- Kaliakatsos et al. (2011) - Pitch class entropy
- Alvarez et al. (2024) - Recent n-gram approach
- Zhao (2025) - Adversarial-MidiBERT
- McKay & Fujinaga (2006) - jSymbolic
- Llorens et al. (2023) - musif

### Musicological Depth:
- Each composer's stylistic characteristics clearly articulated
- Connection between musical traits and computational features established
- Historical context provides framework for interpretation

### Balance:
- Equal coverage of musicological and computational perspectives
- Critical evaluation of both handcrafted and deep learning approaches
- Clear identification of research gaps

### Length Management:
- Current draft: ~2 pages
- May need to condense Table 1 or reduce composer descriptions
- Consider moving some technical details to methodology section

---

## Revision Checklist

- [ ] Verify all citations are accurate and in IEEE format
- [ ] Ensure composer descriptions align with musicological literature
- [ ] Check that gap identification leads naturally to our methodology
- [ ] Confirm table formatting meets ISMIR requirements
- [ ] Review for double-blind compliance
- [ ] Verify word count fits within page limits

---

## Next Steps

1. Complete methodology section (03_methodology.md) with detailed feature descriptions
2. Ensure results section references background literature appropriately
3. Cross-reference musicological claims with discussion section
4. Verify all citations appear in references section (08_references.md)
