# 详细修订计划 - 基于最新实验更新

## 更新概览

**用户已完成：**
- ✅ 移除所有速度（velocity）相关特征
- ✅ 运行 MLP 实验作为额外基线

**本文档目的：** 提供详细的修改计划，涵盖所有 markdown 文件和 LaTeX 论文的更新。

---

## 实验结果更新清单

### 需要确认的新实验结果

在开始修改之前，请确认以下实验结果：

| 实验 | 原结果 | 新结果（待填写） |
|------|--------|-----------------|
| 60D (无速度) + SVM | 74.4% | _____% |
| MLP (无速度) | N/A | _____% |
| MidiBERT + Linear Probe | N/A | _____% |
| GroupKFold (无速度) | N/A | _____% |

---

## 修改任务分解

### 任务 1：更新 README.md

**修改位置：** 全文

**具体修改：**

```markdown
## 原：Feature Sets 表格
| Category | Features | Musical Interpretation |
|----------|----------|----------------------|
| Velocity | f11-f15 | Dynamic range, expressive marking adherence |  ← 删除此行

## 新：Feature Sets 表格
| Category | Features | Musical Interpretation |
|----------|----------|----------------------|
| Pitch | f1-f10 | Range, register preference, pitch class distribution |
| Rhythm/Duration | f16-f23 | Note density, articulation (staccato/legato) |
| Intervals | f24-f30, f52-f60 | Melodic motion preferences (stepwise vs. leaps) |
| Texture | f47-f50 | Chord thickness, simultaneity |
| Higher-order | f31-f34, f35-f46 | Skewness, kurtosis, pitch class histogram |
```

**Results Summary 表格更新：**

```markdown
## 原表格
| Feature Set | Dimensions | Balanced Accuracy | Std Dev |
|-------------|------------|-------------------|---------|
| Handmade Extended (60D) | 60 | **74.4%** | 2.9% |

## 新表格（待填写实际结果）
| Feature Set | Dimensions | Balanced Accuracy | Std Dev |
|-------------|------------|-------------------|---------|
| Handmade (no velocity) | 55 | **___%** | ___% |
| MLP (no velocity) | 55 | **___%** | ___% |
| MidiBERT (768D) | 768 | 47.1% | 2.5% |
```

**Top 10 Features 表格更新：**
- 移除 f13_vel_range, f11_vel_mean, f12_vel_std, f14_loud_note_ratio, f15_soft_note_ratio
- 重新列出新的前 10 名特征

**Musicological Interpretation 部分：**
- 删除所有关于 velocity variance 的讨论
- 重新解释剩余特征的音乐学意义

---

### 任务 2：更新 plans/paper_sections/00_abstract.md

**修改位置：** 摘要主体

**原内容：**
> "Feature importance analysis reveals that velocity range, note count, and melodic interval statistics are the most discriminative attributes."

**新内容（待填写）：**
> "Feature importance analysis reveals that [NEW_TOP_FEATURE_1], [NEW_TOP_FEATURE_2], and melodic interval statistics are the most discriminative attributes."

**修改说明：**
- 移除 velocity range 的提及
- 更新为新的最重要特征

---

### 任务 3：更新 plans/paper_sections/01_introduction.md

**修改位置：** Section 1.3 Contributions

**原内容：**
> "Using Random Forest importance ranking and ANOVA, we identify the most discriminative features (velocity range, interval statistics) and provide musicological interpretation..."

**新内容：**
> "Using Random Forest importance ranking and ANOVA, we identify the most discriminative features ([NEW_FEATURES]) and provide musicological interpretation..."

**修改说明：**
- 移除 velocity 相关描述
- 更新为新的关键特征

---

### 任务 4：更新 plans/paper_sections/02_background.md

**修改位置：** Section 2.2 Feature-Based Approaches

**新增内容：**
```markdown
**Velocity/ Dynamics Features**: While MIDI velocity data can provide information about dynamic expression, it is susceptible to editorial bias in symbolic datasets, as historical scores specify dynamics qualitatively rather than numerically. This study excludes velocity features to focus on composer-intentioned patterns rather than transcriber conventions.
```

**修改说明：**
- 添加关于排除速度特征的说明
- 为方法论决策提供文献支持

---

### 任务 5：更新 plans/paper_sections/03_methodology.md

**修改位置：** Section 3.4 Handmade Feature Extension

**原内容：**
```markdown
### 3.4.2 Velocity Features (f11-f15)
- Mean, std, range of dynamics
- Loud/soft note ratios
```

**新内容：**
```markdown
### 3.4.2 Velocity Features (Excluded)
Velocity features (f11-f15) were initially considered but excluded from final analysis. 
MIDI velocity values in symbolic datasets often reflect editorial conventions of score 
transcribers rather than composer intent, as historical scores from the Romantic era 
specify dynamics qualitatively (e.g., 'p', 'f') rather than as numerical values (1-127). 
To ensure our model captures genuine stylistic patterns rather than data source artifacts, 
we excluded velocity features from our primary analysis.
```

**修改位置：** Section 3.4 特征列表

**更新后的特征分类：**

| Category | Feature IDs | Count |
|----------|-------------|-------|
| Pitch | f1-f10 | 10 |
| ~~Velocity~~ | ~~f11-f15~~ | ~~5 (excluded)~~ |
| Rhythm/Duration | f16-f23 | 8 |
| Interval | f24-f30, f52-f60 | 17 |
| Texture | f47-f50 | 4 |
| Higher-order | f31-f34, f35-f46 | 16 |
| **Total** | | **55** |

**修改位置：** Section 3.6 Classification Framework

**新增内容：**
```markdown
### 3.6.X MLP Baseline

In addition to SVM, we implemented a Multi-Layer Perceptron (MLP) classifier as an 
additional baseline to assess whether non-linear decision boundaries improve performance 
over linear SVM. The MLP architecture consists of:
- Input layer: 55 features (no velocity)
- Hidden layer 1: 128 neurons, ReLU activation, Dropout 0.3
- Hidden layer 2: 64 neurons, ReLU activation, Dropout 0.3
- Output layer: 3 neurons (softmax)

The model is trained with Adam optimizer (lr=0.001) and early stopping (patience=20) 
to prevent overfitting.
```

---

### 任务 6：更新 plans/paper_sections/04_results.md

**修改位置：** Section 4.1 Classification Performance Comparison

**原表格（Table 1）：**
```latex
\begin{table}[h]
\centering
\caption{Classification performance across feature sets.}
\label{tab:performance}
\begin{tabular}{lrrr}
\toprule
Feature Set & Dimensions & Bal. Acc. & Std Dev \\
\midrule
Statistical (12D) & 12 & 49.3\% & 4.7\% \\
Handmade Extended (60D) & 60 & \textbf{74.4\%} & 2.9\% \\
MidiBERT (768D) & 768 & 47.1\% & 2.5\% \\
\bottomrule
\end{tabular}
\end{table}
```

**新表格（待填写）：**
```latex
\begin{table}[h]
\centering
\caption{Classification performance across feature sets (velocity features excluded).}
\label{tab:performance}
\begin{tabular}{lrrr}
\toprule
Feature Set & Dimensions & Bal. Acc. & Std Dev \\
\midrule
Statistical (12D, no vel) & 12 & __.\% & .\% \\
Handmade (55D, no vel) & 55 & \textbf{__.\%} & __.\% \\
MLP (55D, no vel) & 55 & __.\% & __.\% \\
MidiBERT (768D) & 768 & __.\% & 2.5\% \\
MidiBERT + Linear Probe & 768 & __.\% & __.\% \\
\bottomrule
\end{tabular}
\end{table}
```

**修改位置：** Section 4.2 Feature Importance Analysis

**原表格（Table 3）：**
需要移除所有 velocity 特征，重新列出新的 Top 10

**新表格（待填写）：**
```latex
\begin{table}[h]
\centering
\caption{Top 10 most important features for composer classification (velocity excluded).}
\label{tab:importance}
\begin{tabular}{rlcl}
\toprule
Rank & Feature & Importance & Category \\
\midrule
1 & [NEW_F1] & 0.____ & [Category] \\
2 & [NEW_F2] & 0.____ & [Category] \\
3 & f27_unison_ratio & 0.____ & Interval \\
... & ... & ... & ... \\
\bottomrule
\end{tabular}
\end{table}
```

**修改位置：** Section 4.3 新增 MLP 结果

**新增内容：**
```markdown
### 4.3 MLP Classification Results

We evaluated an MLP classifier as an additional baseline to assess whether non-linear 
decision boundaries provide advantages over linear SVM. Results show:

| Model | Accuracy | vs SVM |
|-------|----------|--------|
| SVM (55D) | __.% | baseline |
| MLP (55D) | __.% | +/-.% |

The MLP [performed better/worse/similarly] compared to SVM, suggesting that 
[interpretation: linear boundaries are sufficient / non-linear patterns exist].
```

---

### 任务 7：更新 plans/paper_sections/05_musicological_discussion.md

**修改位置：** Section 5.3 What Features Reveal About Schumann

**原内容（需要删除）：**
> "High Velocity Variance (f12_vel_std)... Schumann Lieder show greatest variation in dynamic markings."

**新内容（待填写）：**
根据新的特征重要性结果，重新解释舒曼的特征模式

**修改位置：** Section 5.4 What Features Reveal About Brahms

**修改说明：**
- 删除任何关于 velocity 的讨论
- 聚焦于剩余特征（音域、织体密度、音程模式）

**修改位置：** Section 5.5 Why Handcrafted Features Outperform MidiBERT

**新增内容：**
```markdown
### 5.5.X Velocity Feature Exclusion Rationale

We explicitly excluded velocity features from our analysis due to concerns about 
editorial bias in MIDI transcriptions. This decision strengthens our methodology 
by ensuring that classification is based on composer-intentioned patterns rather 
than transcriber conventions. The fact that our model achieves [NEW_ACCURACY]% 
accuracy without velocity features demonstrates that genuine stylistic markers 
exist in other musical dimensions (pitch, rhythm, interval, texture).
```

---

### 任务 8：更新 plans/paper_sections/06_exploratory_analysis.md

**修改位置：** Section 6.3 Unexpected Findings

**原内容（需要删除）：**
> "Velocity Features Dominate... f13_vel_range emerged as the single most important feature."

**新内容（待填写）：**
根据新的特征重要性结果，重写"Unexpected Findings"部分

**可能的重写方向：**
```markdown
### 6.3.1 [NEW_TOP_FEATURE] Dominance

Contrary to our initial hypotheses emphasizing harmonic features, [NEW_TOP_FEATURE] 
emerged as the most discriminative attribute. This suggests that [interpretation 
about what this feature captures about composer style].
```

---

### 任务 9：更新 plans/paper_sections/07_conclusion.md

**修改位置：** Section 7.1 Summary of Findings

**原内容：**
> "Finding 2: Velocity and interval features are most discriminative."

**新内容：**
> "Finding 2: [NEW_FEATURES] are most discriminative."

**修改位置：** Section 7.3 Limitations

**新增内容：**
```markdown
**Velocity Feature Exclusion**: We deliberately excluded velocity features due to 
concerns about editorial bias in MIDI transcriptions. While this strengthens 
methodological rigor, it means our analysis does not capture dynamic expression 
patterns that may carry stylistic information.
```

---

### 任务 10：更新 plans/paper_sections/08_references.md

**新增引用（如果需要）：**

```bibtex
@article{EditorialBias202X,
  author = {Author, A.},
  title = {Editorial Bias in MIDI Transcriptions of Classical Music},
  journal = {Journal Name},
  year = {202X}
}
```

---

### 任务 11：更新 paper/main.tex

**修改位置：** Abstract

**原内容：**
```latex
Feature importance analysis reveals that velocity range, note count, and melodic 
interval statistics are the most discriminative attributes.
```

**新内容：**
```latex
Feature importance analysis reveals that [NEW_FEATURE_1], note count, and melodic 
interval statistics are the most discriminative attributes. Velocity features were 
excluded to avoid editorial bias in MIDI transcriptions.
```

**修改位置：** Section 3.4

**删除：** 所有关于 velocity features 的描述

**新增：**
```latex
\subsubsection{Velocity Features (Excluded)}
Velocity features (f11-f15) were initially considered but excluded from final analysis. 
MIDI velocity values in symbolic datasets often reflect editorial conventions of score 
transcribers rather than composer intent, as historical scores from the Romantic era 
specify dynamics qualitatively (e.g., `p', `f') rather than as numerical values (1-127).
```

**修改位置：** Section 3.6

**新增：**
```latex
\subsubsection{MLP Baseline}
In addition to SVM, we implemented a Multi-Layer Perceptron (MLP) classifier as an 
additional baseline. The MLP architecture consists of two hidden layers (128 and 64 
neurons) with ReLU activation and dropout (0.3). Early stopping (patience=20) prevents 
overfitting.
```

**修改位置：** Section 4.1 Table 1

**更新表格内容**（与任务 6 相同）

**修改位置：** Section 4.2 Table 3

**更新表格内容**（移除 velocity 特征）

**修改位置：** Section 4.3

**新增：** MLP 结果小节

**修改位置：** Section 5.x

**删除：** 所有关于 velocity 的音乐学讨论

**修改位置：** Section 7

**更新：** 结论中的特征发现描述

---

## 修改检查清单

### 文件级检查

| 文件 | 修改状态 | 检查状态 |
|------|----------|----------|
| README.md | ☐ | ☐ |
| plans/paper_sections/00_abstract.md | ☐ | ☐ |
| plans/paper_sections/01_introduction.md | ☐ | ☐ |
| plans/paper_sections/02_background.md | ☐ | ☐ |
| plans/paper_sections/03_methodology.md | ☐ | ☐ |
| plans/paper_sections/04_results.md | ☐ | ☐ |
| plans/paper_sections/05_musicological_discussion.md | ☐ | ☐ |
| plans/paper_sections/06_exploratory_analysis.md | ☐ | ☐ |
| plans/paper_sections/07_conclusion.md | ☐ | ☐ |
| plans/paper_sections/08_references.md | ☐ | ☐ |
| paper/main.tex | ☐ | ☐ |
| paper/references.bib | ☐ | ☐ |

### 内容级检查

| 检查项 | 状态 |
|--------|------|
| 所有 velocity 特征引用已移除 | ☐ |
| 所有 velocity 相关音乐学讨论已更新 | ☐ |
| 新的特征重要性排名已更新 | ☐ |
| MLP 实验结果已添加 | ☐ |
| 所有表格数据一致 | ☐ |
| 所有引用一致 | ☐ |
| Abstract 与正文一致 | ☐ |
| Conclusion 与 Results 一致 | ☐ |

---

## 修改顺序建议

1. **首先**：确认新实验结果（填写所有空白数据）
2. **第二步**：更新 README.md（作为参考基准）
3. **第三步**：更新 paper/main.tex（主要论文）
4. **第四步**：更新所有 paper_sections/*.md 文件
5. **第五步**：执行内容级检查清单
6. **第六步**：编译 LaTeX 检查格式
7. **第七步**：最终审查

---

## 需要用户提供的信息

在开始修改之前，请提供以下实验结果：

1. **55D (无速度) + SVM 准确率**：_____%
2. **55D (无速度) + MLP 准确率**：_____%
3. **新的 Top 5 特征**：
   - Rank 1: _____ (importance: _____)
   - Rank 2: _____ (importance: _____)
   - Rank 3: _____ (importance: _____)
   - Rank 4: _____ (importance: _____)
   - Rank 5: _____ (importance: _____)
4. **是否运行了 MidiBERT + Linear Probe**：是/否，结果：_____%
5. **是否运行了 GroupKFold**：是/否，结果：_____%

---

## 预计修改时间

| 任务 | 预计时间 |
|------|----------|
| 确认实验结果 | 30 分钟 |
| 更新 README.md | 30 分钟 |
| 更新 paper/main.tex | 2 小时 |
| 更新所有 paper_sections/*.md | 3 小时 |
| 检查一致性 | 1 小时 |
| 编译和格式检查 | 30 分钟 |
| **总计** | **~8 小时** |

---

## 下一步行动

1. 用户提供新实验结果
2. 根据本计划更新所有文件
3. 执行检查清单
4. 提交修订版
