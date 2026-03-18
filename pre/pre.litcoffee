---
marp: true
theme: default
paginate: true
backgroundColor: #ffffff
style: |
  h1 { color: #2c3e50; }
  h2 { color: #34495e; border-bottom: 2px solid #ecf0f1; padding-bottom: 0.2em; }
  strong { color: #e74c3c; }
---

# Composer Identification in the German Romantic Lied
**A Comparative Study of Handcrafted Symbolic Features vs. Pre-trained Large Models**

Speaker: [Your Name]
Date: [Date]

---

## 1. Introduction & Motivation

* **A Classic MIR Task**: Composer Identification.
* **The Challenge**: Cross-era classification (e.g., Baroque vs. Romantic) is highly successful, but fine-grained, same-era, and same-genre classification remains remarkably difficult.
* **The Gap**: The *Lied* (art song for voice and piano) reached its peak in the 19th century, yet has received surprisingly little computational attention for composer attribution.
* **Objective**: Distinguishing the compositional styles of three core figures of the German Romantic tradition: Franz Schubert, Robert Schumann, and Johannes Brahms.

---

## 2. Dataset

**A custom dataset built from the OpenScore Lieder Corpus**
Total of **264** symbolic music pieces (converted from .mscx to MusicXML):

* 🎼 **Franz Schubert**: 84 songs
* 🎼 **Johannes Brahms**: 109 songs
* 🎼 **Robert Schumann**: 71 songs

**Processing**: Extracted using the `music21` Python library, quantized and parsed at the eighth-note level to accommodate complex meters.

---

## 3. Exploratory Data Analysis (EDA): Music & Text

Multimodal exploration revealed **extreme stylistic homogeneity**:
* **Musical Properties**: Time signatures, piece length, and vocal ranges overlap heavily among the three composers.
* **Lyric Topic Analysis (LDA)**: Clustered into 4 topics (Night/Longing, Sleep/Spirituality, Love/Emotions, Folk/Nature). The topic distributions are nearly identical across composers.
* **Text-Music Alignment**: We found distinct "text painting" habits (e.g., Schubert pairs high pitches with "Heart/Maria"; Brahms pairs low pitches with "Death").
* *Conclusion: Due to high lyric semantic overlap, the downstream classification task strictly focuses on symbolic music features.*

---

## 4. Methodology : Domain-Driven Handcrafted Features

To capture subtle compositional signatures without overwhelming the classifier, we designed 4 low-dimensional features, summarized by 3 statistical descriptors (mean, std, entropy) into a **12D vector**:

1. **Tonal Tension**: Euclidean distance of chords from the tonal center (Spiral Array Model).
2. **Harmonic Complexity**: Shannon entropy of the pitch class distribution per beat.
3. **Pianistic Texture**: Onset density in the accompaniment (distinguishes thick block chords from sparse arpeggios).
4. **Melodic Contour**: Categorical encoding of vocal interval motion (leap, step, unison, etc.).




---

## 5. Deep Learning Baseline: Adversarial-MidiBERT


* **State-of-the-Art Performance**: A BERT-based symbolic music model pre-trained on massive MIDI datasets (>15,000 compositions).

* **Our Implementation**: We utilized this highly capable pre-trained model as a feature extractor, generating **768-dimensional deep embeddings** for each Lied to feed into our downstream classifiers.

<center>
  <img src="./midibert.png" width="100%">
</center>



---
## 6. Methodology :  Model Details

* **Deep Embeddings**: Extracted **768D** semantic features using Adversarial-MidiBERT.
* **Classifier Configurations**:
  1. **SVM**: Trained on the 12D handcrafted features.
  2. **SVM**: Trained on the 768D MidiBERT embeddings.
  3. **2-layer MLP** (128->64 neurons, L2 regularization): Trained on 768D MidiBERT.
* **Evaluation**: Rigorous Stratified 5-fold Cross-Validation.

---

## 7. Sanity Check: Is the model broken, or is the task hard?

If accuracy is low, is the pipeline flawed? To test this, we ran the same baseline (MidiBERT + SVM) on a stylistically distinct early music dataset:

* **Test Data**: Baroque/Renaissance (Palestrina: 100, Monteverdi: 97, Bach: 100).
* **Results**: Balanced Accuracy of **98.96%** (F1-scores > 0.98 for all classes).

**The classification pipeline works perfectly**

---

## 8. Results

On the 264-song Lied dataset, **low-dimensional handcrafted features outperformed high-dimensional deep embeddings**:

| Feature Config | Classifier | Dimensions | Balanced Accuracy |
| :--- | :---: | :---: | :--- | 
| **Ours** | **SVM** | **12D** |  **0.4935** (std: 0.0465) |
| MidiBERT | SVM | 768D |  0.4709 (std: 0.0252) | 
| MidiBERT | MLP | 768D |  0.4528  |

*(Note: All results are significantly above the 0.33 random baseline)*

---

## 9. Discussion: Why did small features win?

1. **The Robustness of Domain Knowledge**: In small-sample (n=264) datasets with high stylistic overlap, an MLP with ~100k parameters suffers from the curse of dimensionality. The 12D handcrafted features act as a focused filter, capturing core musicological intuition while resisting noise.
2. **The "Brahms Advantage"**: Brahms achieved the highest F1 score (0.61) in the handcrafted model. This perfectly aligns with musicological consensus: his distinctive, thick chordal block accompaniments were successfully captured by the *Pianistic Texture* (onset density) feature.

---

## 10. Core Contributions

1. **Defining a highly challenging MIR benchmark**
   Same-era Romantic Lied classification is incredibly difficult. A pipeline that scores ~99% on Baroque data drops to ~49% here, highlighting extreme intra-genre convergence.
2. **Proving the value of handcrafted features in data-constrained tasks**
   In tasks demanding high domain expertise but lacking massive datasets, lightweight and interpretable features (12D) are not just computationally cheaper—they can rival or exceed large pre-trained deep learning embeddings (768D).

---



# Thank you for listening!
**Q & A**

