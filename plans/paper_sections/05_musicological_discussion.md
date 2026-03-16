# 5. Musicological Discussion

**Target Length**: 1 page  
**Format**: Two-column, 10pt Times

---

## 5.1 Interpreting Computational Findings

The results presented in Section 4 raise a fundamental question: what do these computational features tell us about the musical style of Schubert, Schumann, and Brahms? This section bridges the gap between statistical patterns and musicological understanding, offering interpretive hypotheses grounded in both domains.

---

## 5.2 What Features Reveal About Schubert

### 5.2.1 High Stepwise Ratio (f28_stepwise_ratio)

**Computational Finding**: Schubert Lieder show higher proportion of stepwise melodic motion (intervals of 1-2 semitones).

**Musicological Interpretation**: This finding aligns with longstanding observations about Schubert's vocal writing. His melodies are renowned for their:

- **Lyrical quality**: Stepwise motion creates singable, memorable lines that mirror natural speech inflection
- **Folk song influence**: Many Schubert melodies evoke *Volkslied* simplicity through conjunct motion
- **Text sensitivity**: Stepwise writing allows clear text declamation without wide leaps disrupting syllable setting

**Example**: The opening of "Gute Nacht" from *Winterreise* moves primarily by step (D-E-F#-E-D), creating the weary walker's plodding motion.

### 5.2.2 Lower Texture Density

**Computational Finding**: Schubert shows lower values for simultaneity features (f47_simultaneity_mean).

**Musicological Interpretation**: This reflects Schubert's characteristic accompaniment patterns:

- **Guitar-like arpeggiation**: Broken chord patterns (as in "Die Forelle") create harmonic support without dense vertical sonorities
- **Bass-melody texture**: Many accompaniments feature single-line bass with sparse inner voices
- **Textural restraint**: Even in dramatic songs, Schubert often maintains transparent textures

**Example**: "Der Lindenbaum" uses flowing triplet arpeggios throughout, rarely employing full chordal writing.

### 5.2.3 Moderate Harmonic Complexity

**Computational Finding**: Schubert's pitch class entropy falls between Schumann and Brahms.

**Musicological Interpretation**: This intermediate position reflects Schubert's unique harmonic approach:

- **Expressive chromaticism**: Chromatic alterations serve text-painting (e.g., "Irrlicht"'s wandering harmony)
- **Structural diatonicism**: Despite surface chromaticism, underlying tonal structure remains clear
- **Third relationships**: Schubert's characteristic mediant modulations add color without saturating pitch class space

---

## 5.3 What Features Reveal About Schumann

### 5.3.1 High Velocity Variance (f12_vel_std)

**Computational Finding**: Schumann Lieder show greatest variation in dynamic markings.

**Musicological Interpretation**: This finding captures Schumann's expressive intensity:

- **Psychological dynamics**: Dynamic changes reflect inner emotional states rather than formal structure
- **Sudden contrasts**: Characteristic abrupt shifts from *piano* to *forte* mirror mood swings
- **Detailed markings**: Schumann provides more specific dynamic instructions than his contemporaries

**Example**: "Im Rhein, im heiligen Strome" from *Dichterliebe* shows rapid dynamic shifts reflecting the speaker's ironic tone.

### 5.3.2 Lower Simultaneity, Higher Variation (pt_std)

**Computational Finding**: Schumann shows moderate mean simultaneity but highest variance.

**Musicological Interpretation**: This pattern reflects Schumann's diverse accompaniment styles:

- **Arpeggiated textures**: Flowing patterns (as in *Dichterliebe*'s opening) create low simultaneity
- **Contrasting sections**: Within-song textural changes produce high variance
- **Piano independence**: Elaborate postludes and interludes vary texture beyond vocal sections

**Example**: The piano postlude of "Ich groll' nicht" transforms from chordal declaration to arpeggiated dissolution.

### 5.3.3 Complex Rhythmic Patterns (f20_ioi_std)

**Computational Finding**: Schumann shows higher variance in inter-onset intervals.

**Musicological Interpretation**: This captures Schumann's rhythmic sophistication:

- **Poetic declamation**: Rhythmic flexibility follows natural speech patterns
- **Syncopation**: Characteristic off-beat accents create rhythmic interest
- **Hemiola effects**: Metric displacement adds complexity to surface rhythm

---

## 5.4 What Features Reveal About Brahms

### 5.4.1 High Pitch Range (f4_pitch_range) and Note Density (f21_note_density)

**Computational Finding**: Brahms Lieder employ wider pitch spans and more notes per unit time.

**Musicological Interpretation**: These features reflect Brahms' rich musical language:

- **Symphonic piano writing**: Dense textures evoke orchestral sonorities
- **Wide register exploitation**: Piano parts span full keyboard range
- **Continuous motion**: Inner voices maintain rhythmic activity throughout

**Example**: "Wie Melodien zieht es mir" features rich piano texture with continuous sixteenth-note motion.

### 5.4.2 Conservative Interval Patterns (Lower f29_leap_ratio)

**Computational Finding**: Brahms shows lower proportion of large leaps (>4 semitones).

**Musicological Interpretation**: This finding supports the characterization of Brahms as classically restrained:

- **Folk song influence**: *Volkslied*-inspired melodies favor conjunct motion
- **Classical balance**: Wide leaps used sparingly for specific expressive effects
- **Vocal writing**: Brahms' understanding of vocal limits constrains melodic range

### 5.4.3 Dense Chordal Writing (High f50_thick_chord_ratio)

**Computational Finding**: Brahms shows higher proportion of beats with 4+ simultaneous notes.

**Musicological Interpretation**: This captures Brahms' characteristic piano style:

- **Four-part writing**: Piano textures often resemble string quartet voicing
- **Full harmonies**: Rich chordal sonorities fill harmonic space
- **Contrapuntal density**: Multiple independent voices create vertical complexity

---

## 5.5 Why Handcrafted Features Outperform MidiBERT

### 5.5.1 Domain Specificity

**Finding**: 60D handcrafted features (74.4%) significantly outperform 768D MidiBERT embeddings (47.1%).

**Interpretation**: This result illuminates the tension between general and specialized representations:

- **Task mismatch**: MidiBERT trained on diverse MIDI data (popular music, piano pieces) may not capture Lieder-specific features
- **Feature relevance**: Handcrafted features encode musicological hypotheses about what distinguishes composers
- **Signal-to-noise**: 768 dimensions include many features irrelevant to composer style, diluting discriminative signal

### 5.5.2 The Small Corpus Problem

**Finding**: Pretrained model underperforms despite theoretical advantages.

**Interpretation**: The 264-piece corpus is insufficient for effective fine-tuning:

- **Parameter ratio**: 768-dimensional embeddings require thousands of samples for reliable classification
- **Overfitting risk**: High-dimensional space allows model to memorize training data rather than learn generalizable patterns
- **Domain shift**: Pretraining on different musical genres creates representation gap

### 5.5.3 Knowledge Encoding

**Finding**: Theory-driven 12D features (49.3%) approach random chance, while extended 60D features excel.

**Interpretation**: Pure theory-driven design may miss important discriminative features:

- **Incomplete theory**: Tonal tension, while musicologically motivated, may not capture composer-specific patterns
- **Empirical value**: Data-driven features (velocity statistics, interval categories) add discriminative power
- **Hybrid approach**: Best results come from combining theoretical grounding with empirical feature discovery

---

## 5.6 Limitations of Current Approach

### 5.6.1 Binary Texture Model

Our onset density measure captures vertical thickness but not:

- **Voice-leading quality**: How individual voices move independently
- **Articulation patterns**: Staccato vs. legato affects perceived texture
- **Pedaling**: Piano pedaling creates sustained sonorities not captured in symbolic data

### 5.6.2 Absence of Chord Function Analysis

We measure harmonic complexity but not:

- **Functional progression**: Tonic-dominant relationships
- **Modulation patterns**: Key change strategies
- **Chord annotation**: Requires manual or automated harmonic analysis

### 5.6.3 Meter-Level Aggregation

Aggregating to piece-level statistics loses:

- **Local detail**: Moment-to-moment variation in features
- **Structural patterns**: Section-level organization (verse vs. chorus)
- **Temporal evolution**: How features change throughout the piece

---

## 5.7 Synthesis: Computational Musicology as Hypothesis Generator

The value of this computational approach lies not in definitive attribution but in hypothesis generation:

1. **Velocity features are most discriminative** → Further study of dynamic marking practices across composers
2. **Texture variation distinguishes Schumann** → Detailed analysis of accompaniment pattern taxonomy
3. **Tonal tension less discriminative than expected** → Re-evaluation of Spiral Array parameters for Lieder

These hypotheses can guide future musicological research, creating a productive dialogue between computational and traditional approaches.

---

## Musicological Discussion Writing Notes

### Balance:
- Equal treatment of all three composers
- Connection between computational findings and musicological literature
- Acknowledgment of interpretive limitations

### Evidence Quality:
- Specific musical examples cited where possible
- Claims grounded in established musicological understanding
- Clear distinction between observation and interpretation

### Critical Perspective:
- Limitations honestly acknowledged
- Alternative interpretations considered
- Avoidance of computational determinism

### Length Management:
- Current draft: ~2 pages
- May need to condense composer-specific sections
- Consider moving detailed examples to appendix

---

## Revision Checklist

- [ ] Verify musicological claims against scholarly literature
- [ ] Ensure musical examples are accurate and representative
- [ ] Check that computational findings are correctly interpreted
- [ ] Review for balance across composers
- [ ] Confirm limitations section is comprehensive
- [ ] Verify word count fits within page limits

---

## Next Steps

1. Complete exploratory analysis section (06_exploratory_analysis.md) with case studies
2. Cross-reference discussion claims with results section data
3. Prepare musical examples for potential figures
4. Ensure references section includes all musicological sources cited
