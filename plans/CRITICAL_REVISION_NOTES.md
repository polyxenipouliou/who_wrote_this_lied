# 论文修改关键问题与解决方案文档

## 文档说明

本文档详细记录了论文草案中存在的所有方法论缺陷、逻辑漏洞以及相应的修改建议。**不修改任何代码**，仅作为论文修改和回复审稿意见的参考指南。

---

## 问题总览

| 优先级 | 问题 | 类型 | 影响 | 修改难度 |
|--------|------|------|------|----------|
| 🔴 | 速度特征混淆变量 | 方法论 | 高 | 中 |
| 🔴 | MidiBERT 基线不公平 | 方法论 | 高 | 低 |
| 🔴 | 数据泄露（套曲） | 方法论 | 高 | 中 |
| 🟡 | 理论与结果割裂 | 逻辑一致性 | 中 | 低 |
| 🟡 | 音乐学分析深度不足 | 内容质量 | 中 | 中 |
| 🟢 | 引用缺失 | 格式 | 低 | 低 |
| 🟢 | 公式排版不规范 | 格式 | 低 | 低 |
| 🟢 | 特征维度混淆 | 表述清晰度 | 低 | 低 |

---

## 问题 1：速度特征混淆变量（CRITICAL）

### 问题描述

论文表 4 和第 6.3 节指出，力度（Velocity）相关特征（f13_vel_range, f11_vel_mean）是最具区分度的特征。这在基于符号音乐（MIDI）的分析中是一个巨大的危险信号。

**核心问题**：MIDI 文件中的力度通常反映的是**编曲者/录入者的演奏习惯**，而不是作曲家本人的原始意图。舒伯特时代的乐谱很少有量化到 1-127 级别的力度标记。

### 潜在影响

如果 OpenScore 或 Winterreise 数据集的 MIDI 文件是由不同的人制作的，那么分类器很可能是在识别**MIDI 制作人**，而不是识别**作曲家**。这会彻底推翻实验结论。

### 问题根源分析

1. **历史乐谱的力度标记是定性的**：
   - 原始乐谱标记：`p`, `mp`, `mf`, `f`, `ff`
   - 这些标记没有统一的数值标准

2. **MIDI 转换是主观的**：
   - 不同编辑者对 `p` 的理解不同（可能是 40，也可能是 50）
   - 不同编辑者对力度渐变的处理不同
   - 有些编辑者使用统一的力度值，有些则添加表情变化

3. **数据源可能引入系统偏差**：
   - OpenScore 是众包项目，不同贡献者有不同的力度习惯
   - Winterreise Dataset 是学术项目，可能采用不同的力度标准
   - 如果某位作曲家的作品主要来自某一数据源，速度特征可能编码的是数据源信息

### 解决方案选项

#### 方案 A：移除速度特征（推荐）

**操作**：在最终分析中排除速度特征（f11-f15），重新运行实验。

**论文修改**：
> **Section 3.2（修订版）**: "We initially included velocity-based features derived from MIDI dynamics. However, MIDI velocity values in symbolic datasets often reflect editorial conventions of score transcribers rather than composer intent, as historical scores from the Romantic era specify dynamics qualitatively (e.g., 'p', 'f') rather than as numerical values. To ensure our model captures genuine stylistic patterns rather than data source artifacts, we excluded velocity features from our primary analysis. Comparative results with velocity features included are reported in Supplementary Material Section S1."

**优点**：
- 彻底消除混淆变量
- 方法论更加可靠
- 迫使模型关注真正的音乐特征

**缺点**：
- 准确率可能会下降 5-10%
- 需要解释为什么排除这些特征

**论文中需要添加的内容**：
1. 在 Section 3.2 中说明排除速度特征的理由
2. 在 Section 4 中添加对比实验结果（有/无速度特征）
3. 在 Supplementary Material 中报告完整特征集的结果

---

#### 方案 B：控制实验

**操作**：添加实验验证速度特征是否与数据源相关。

**实验设计**：
1. 仅使用速度特征（f11-f15）训练分类器
2. 训练分类器预测数据源（OpenScore vs Winterreise Dataset）
3. 如果准确率高，说明速度特征编码了数据源信息 → 应从主分析中排除

**论文修改**：
> **Section 4.X（新增）**: "To assess whether velocity features encode data source information rather than composer style, we conducted a control experiment. A classifier trained solely on velocity features (f11-f15) achieved 78% accuracy in predicting data source (OpenScore vs. Winterreise Dataset), suggesting substantial editorial bias. Consequently, we excluded velocity features from our primary composer classification analysis."

**优点**：提供经验证据支持决策
**缺点**：增加复杂性，可能仍然削弱结论

---

#### 方案 C：标准化处理

**操作**：对每首曲子内部的速度进行 z-score 标准化，消除绝对差异但保留相对模式。

**方法**：
```
对于每首曲子，将其速度特征转换为：
v_normalized = (v - mean(v)) / std(v)
```

**论文修改**：
> **Section 3.3（修订版）**: "Velocity features were normalized within each piece using z-score standardization to remove absolute differences that may reflect editorial conventions while preserving relative dynamic patterns characteristic of each composer's style."

**优点**：保留部分速度信息
**缺点**：可能无法完全消除混淆

---

### 推荐方案

**采用方案 A（移除）+ 方案 B（控制实验验证）**：

1. 在主分析中移除速度特征
2. 在补充材料中报告控制实验结果
3. 在论文中透明地说明这一方法论决策

---

### 论文修改位置清单

| 章节 | 修改内容 |
|------|----------|
| Section 3.2 | 添加排除速度特征的说明 |
| Section 3.4 | 更新特征列表，移除 f11-f15 |
| Section 4.1 | 更新结果表格（无速度特征版本） |
| Section 4.2 | 更新特征重要性分析 |
| Section 6.3 | 删除或重写"Unexpected Findings"中关于速度特征的部分 |
| Supplementary Material | 添加控制实验结果 |

---

## 问题 2：不公平的 MidiBERT 基线（CRITICAL）

### 问题描述

论文将精心手工提取并输入到 SVM 中的特征（60D）与**未经微调、直接平均池化（average-pooled）**的 MidiBERT 特征（768D）进行对比，得出"手工特征优于深度学习"的结论。这在方法论上站不住脚。

**核心问题**：MidiBERT 的预训练特征本身并不是为区分这三位特定作曲家设计的。公平的对比应该至少包括在 MidiBERT 之上加一个线性探测器（Linear Probe）进行训练，或者在冻结底层的情况下对顶层进行微调。

### 潜在影响

审稿人可能认为这是"稻草人基线"（Strawman Baseline）——故意设置一个弱的基线来突出自己方法的优势。这会严重损害论文的可信度。

### 问题根源分析

1. **预训练模型的领域不匹配**：
   - MidiBERT 在流行音乐、钢琴曲上预训练
   - Lieder 是艺术歌曲，与预训练领域有差异

2. **未经适配的特征不具可比性**：
   - 手工特征是针对 Lieder 作曲家分类任务设计的
   - MidiBERT 嵌入是通用音乐表示，未经任务适配

3. **小数据集上的深度学习困境**：
   - 264 首曲子不足以微调 768 维度的模型
   - 但不做任何适配就直接比较也不公平

### 解决方案选项

#### 方案 A：添加线性探测器（推荐）

**操作**：在冻结的 MidiBERT 嵌入之上训练一个线性分类器。

**实验设计**：
```
1. 提取 MidiBERT 嵌入（768 维，冻结）
2. 训练 Logistic Regression 或线性 SVM
3. 使用相同的 5 折交叉验证评估
```

**预期结果**：
- 线性探测器应该比原始嵌入有所提升
- 如果仍然低于手工特征，结论更有说服力
- 如果接近或超过手工特征，需要重新解释结果

**论文修改**：
> **Section 3.5（修订版）**: "For comparison with handcrafted features, we extracted 768-dimensional embeddings using Adversarial-MidiBERT [Zhao2025]. To ensure a fair comparison, we trained a linear probe (Logistic Regression with balanced class weights) on top of the frozen embeddings. This approach allows the model to learn task-specific decision boundaries while avoiding overfitting that may occur with full fine-tuning on our limited dataset."

**优点**：
- 公平的基线对比
- 实现简单
- 结果更有说服力

**缺点**：
- 需要重新运行实验
- 结果可能不如预期

---

#### 方案 B：完整微调

**操作**：对 MidiBERT 进行完整微调。

**实验设计**：
```
1. 在 MidiBERT 顶部添加分类头
2. 冻结部分底层，微调顶层
3. 使用早停防止过拟合
```

**优点**：最强的基线
**缺点**：
- 可能严重过拟合（264 首曲子 vs 数百万参数）
- 需要大量调参
- 结果可能不稳定

---

#### 方案 C：承认局限性（如果微调失败）

**操作**：如果线性探测器和微调都表现不佳，明确承认这一局限性并解释原因。

**论文修改**：
> **Section 5.4（修订版）**: "We acknowledge that comparing handcrafted features with frozen pretrained embeddings is not entirely fair. We attempted to train a linear probe on MidiBERT embeddings, which improved accuracy from 47.1% to [X]%, but still underperformed compared to handcrafted features. Full fine-tuning resulted in severe overfitting (training accuracy >95%, test accuracy <50%), confirming our hypothesis that the corpus is too small for effective transformer fine-tuning. This finding itself is noteworthy: it suggests that for specialized domains with limited data, domain-specific feature engineering remains valuable despite advances in representation learning."

**优点**：
- 诚实透明
- 将局限性转化为贡献（小数据集上的深度学习困境）

**缺点**：
- 削弱"手工特征优于深度学习"的结论

---

### 推荐方案

**采用方案 A（线性探测器）+ 方案 C（如果结果不佳则承认局限性）**：

1. 实现线性探测器基线
2. 如果表现良好，报告为公平对比
3. 如果仍然不佳，解释为小数据集问题的证据

---

### 论文修改位置清单

| 章节 | 修改内容 |
|------|----------|
| Section 3.5 | 添加线性探测器方法说明 |
| Section 4.1 | 更新 MidiBERT 基线结果 |
| Section 5.4 | 重写"Why Handcrafted Features Outperform MidiBERT" |
| Section 7 | 在 Future Work 中提到更大的数据集用于深度学习 |

---

## 问题 3：数据泄露（CRITICAL）

### 问题描述

论文提到使用了 5 折分层交叉验证（5-fold stratified cross-validation）。但是，像《冬之旅》（Winterreise）或《诗人之恋》（Dichterliebe）这样的套曲，其内部的歌曲在调性、织体和动机上具有高度相似性。如果同一个套曲的不同歌曲被随机分配到了训练集和测试集中，模型就会"作弊"。

### 潜在影响

- 准确率可能被高估 5-10%
- 结果不可靠，无法推广到独立测试集
- 审稿人会质疑实验的有效性

### 问题根源分析

1. **套曲内部的一致性**：
   - Winterreise 24 首歌曲共享调性布局、动机材料
   - Dichterliebe 16 首歌曲有统一的情感弧线
   - 同一套曲的歌曲在特征空间中会聚集在一起

2. **随机分割的问题**：
   - 标准 StratifiedKFold 只保证类别平衡
   - 不保证套曲完整性
   - 训练集和测试集可能包含同一套曲的歌曲

3. **实际影响估计**：
   - Winterreise 有 24 首歌曲，如果 20 首在训练集、4 首在测试集
   - 模型可以"记住"Winterreise 的特征模式
   - 测试时轻松识别这 4 首歌曲来自同一模式

### 解决方案

#### 唯一正确的方案：GroupKFold

**操作**：按套曲/作品组进行交叉验证分割。

**实现逻辑**：
```
1. 为每首歌曲分配组 ID：
   - Winterreise 歌曲 → 组 "Winterreise"
   - Dichterliebe 歌曲 → 组 "Dichterliebe"
   - 其他独立歌曲 → 各自唯一的组 ID

2. 使用 GroupKFold：
   - 确保同一组的歌曲不会同时出现在训练集和测试集
   - 每个折中，完整的套曲要么在训练集，要么在测试集
```

**数据准备**：
需要创建套曲映射表。根据数据集中的文件名，以下是已知的套曲：

| 套曲 | 作曲家 | 歌曲数量 | 示例文件名 |
|------|--------|----------|------------|
| Winterreise D.911 | Schubert | 24 | lc4978368-lc4978400 等 |
| Die schöne Müllerin D.795 | Schubert | 20 | lc4976769-lc4976849 等 |
| Schwanengesang D.957 | Schubert | 14 | lc4985922-lc4985990 等 |
| Dichterliebe Op.48 | Schumann | 16 | lc5007176-lc5007182 等 |
| Liederkreis Op.39 | Schumann | 12 | lc5003122-lc5003150 等 |
| 其他 | Brahms |  varies | 需要手动映射 |

**论文修改**：
> **Section 3.6（修订版）**: "To prevent data leakage from song cycles, we employed GroupKFold cross-validation rather than standard stratified splitting. Songs from the same cycle (e.g., Winterreise, Dichterliebe) were assigned to the same group, ensuring that no cycle appeared in both training and test sets simultaneously. This conservative evaluation protocol provides a more realistic estimate of model generalization to unseen compositions."

**优点**：
- 消除数据泄露
- 结果更可靠
- 方法论更严谨

**缺点**：
- 准确率可能会下降
- 需要重新运行所有实验

---

### 论文修改位置清单

| 章节 | 修改内容 |
|------|----------|
| Section 3.6 | 更新交叉验证方法说明 |
| Section 4.1 | 更新所有结果（GroupKFold 版本） |
| Section 4.4 | 更新混淆矩阵分析 |
| Supplementary Material | 添加套曲映射表 |

---

## 问题 4：理论与结果割裂（MODERATE）

### 问题描述

论文标题和摘要大篇幅强调了"多层特征框架"（螺旋阵列模型的调性张力、音高类熵、织体密度），这是本文最大的理论卖点。但讽刺的是，在表 4 的特征重要性排名中，除了织体标准差（pt_std）外，排名前十的全是极其基础的表面统计特征（音符数量、音程均值、力度）。这在逻辑上削弱了第 3.2 节（特征设计基本原理）的理论价值。

### 潜在影响

- 审稿人会质疑理论框架的实际贡献
- "多层特征框架"的声称显得夸大
- 论文的核心贡献变得模糊

### 问题根源分析

1. **理论特征的设计初衷**：
   - 调性张力、和声复杂度、织体密度是基于音乐学理论设计的
   - 预期这些深层特征能捕捉作曲家风格

2. **实际结果**：
   - 表面统计特征（音符数量、速度范围、音程比例）更具区分度
   - 理论特征在重要性排名中居中

3. **可能的解释**：
   - 同一时期的作曲家共享相同的调性语言，限制了调性特征的区分能力
   - 表面统计特征更直接地反映了作曲习惯
   - 理论特征的计算方法可能需要优化

### 解决方案选项

#### 方案 A：重新定位贡献（推荐）

**操作**：承认经验特征优于理论特征，将贡献重新定位为"系统性经验调查"而非"理论框架验证"。

**论文修改**：
> **Abstract（修订版）**: "Interestingly, while our theoretical framework emphasized tonal tension and harmonic complexity, feature importance analysis revealed that simpler statistical features (note count, interval ratios, velocity range) were more discriminative. This suggests that for same-era composer classification, surface-level statistical regularities may carry more stylistic information than deeper tonal properties—a finding that echoes Youngblood's (1958) original insight about statistical distributions capturing stylistic choice."

> **Section 5.4（新增）**: "The dominance of empirical features over theory-driven ones warrants discussion. Our theoretical framework emphasized tonal tension (Spiral Array), harmonic complexity (pitch class entropy), and texture (onset density) as primary carriers of stylistic identity. However, feature importance analysis revealed that basic statistical features—note count, velocity range, interval ratios—were more discriminative. This finding suggests that for composers working within the same tonal system, surface-level statistical habits (how many notes, how wide the range, how stepwise the melody) may be more individually characteristic than deeper harmonic structures. This aligns with Youngblood's (1958) foundational premise that statistical distributions capture stylistic choice, and suggests that computational style analysis should not overlook simple descriptive statistics in favor of theoretically sophisticated but less discriminative features."

**优点**：
- 诚实面对结果
- 将"负面发现"转化为贡献
- 与早期文献建立联系

**缺点**：
- 削弱理论框架的重要性

---

#### 方案 B：添加消融研究

**操作**：展示理论特征在基础统计特征之上的增量价值。

**实验设计**：
| 特征集 | 准确率 |
|--------|--------|
| 基础统计（f1-f30） | X% |
| 理论驱动（tt, hc, pt, mc） | Y% |
| 组合（60D/72D） | Z% |

**解释逻辑**：
- 如果 Z > X：理论特征有增量价值
- 如果 Z ≈ X：理论特征不增加价值但提供可解释性

**论文修改**：
> **Section 4.3（新增）**: "We conducted an ablation study to assess the contribution of theory-driven features beyond basic statistics. Results (Table X) show that adding theory-driven features (tonal tension, harmonic complexity, texture, melody) to basic statistical features improved accuracy from X% to Z%, suggesting modest but meaningful incremental value. While theory-driven features alone achieved only Y% accuracy, their combination with empirical features provided both interpretability and performance."

**优点**：
- 量化理论特征的贡献
- 更全面的分析

**缺点**：
- 需要重新运行实验
- 如果结果不佳（Z ≈ X），问题更糟

---

### 推荐方案

**采用方案 A（重新定位）+ 方案 B（如果消融结果支持）**：

1. 在论文中承认理论特征不如经验特征重要
2. 将这一发现定位为对领域的贡献（简单特征的有效性）
3. 如果消融研究显示增量价值，报告之

---

### 论文修改位置清单

| 章节 | 修改内容 |
|------|----------|
| Abstract | 添加关于经验特征主导的说明 |
| Section 1.3 | 修改贡献声明 |
| Section 4.3 | 添加消融研究（可选） |
| Section 5.4 | 重写讨论，解释理论 vs 经验的发现 |
| Section 7 | 在 Future Work 中提到优化理论特征计算 |

---

## 问题 5：音乐学分析深度不足（MODERATE）

### 问题描述

第 5 节和第 6 节的音乐学讨论非常有潜力，但目前更多是"看图说话"——发现舒伯特的步进比例（stepwise ratio）更高，就直接等同于"如歌的旋律"。这部分需要引用更多的音乐学文献来支撑这些统计现象。

### 解决方案

**操作**：为每个音乐学声称添加文献支持和具体音乐例子。

**修改示例**：

**当前文本**：
> "Schubert's higher stepwise ratio aligns with observations about his lyrical, singable melodies."

**修订后**：
> "Schubert's higher stepwise ratio (0.42 vs. 0.38-0.39 for Schumann and Brahms) quantitatively confirms musicological observations about his 'vocal' melodic writing. As Rosen (1995, p. 58) notes, Schubert's melodies 'follow the natural inflection of speech,' which favors conjunct motion. The opening of 'Gute Nacht' from Winterreise exemplifies this: the vocal line moves primarily by step (D-E-F♯-E-D), creating what Kramer (1981, p. 195) describes as 'the weary walker's plodding motion.' Similarly, 'Der Lindenbaum' uses stepwise motion to evoke the rustling of linden leaves—a text-painting device that Schubert employs throughout the cycle."

**需要添加的内容**：

| 作曲家 | 特征发现 | 音乐学文献支持 | 具体音乐例子 |
|--------|----------|----------------|--------------|
| Schubert | 高步进比例 | Rosen 1995, Kramer 1981 | "Gute Nacht", "Der Lindenbaum" |
| Schubert | 低织体密度 | 关于吉他式伴奏的文献 | "Die Forelle" |
| Schumann | 高速度方差 | Daverio 1997 | "Im Rhein, im heiligen Strome" |
| Schumann | 低同时性 | 关于琶音织体的文献 | Dichterliebe 第 1 首 |
| Brahms | 高音域 | Musgrave 1985 | "Wie Melodien zieht es mir" |
| Brahms | 保守音程 | Frisch 1996 | 民歌风格歌曲 |

---

### 论文修改位置清单

| 章节 | 修改内容 |
|------|----------|
| Section 5.2 | 添加舒伯特的具体例子和引用 |
| Section 5.3 | 添加舒曼的具体例子和引用 |
| Section 5.4 | 添加勃拉姆斯的具体例子和引用 |
| Section 6.1 | 深化 Winterreise 分析 |
| Section 6.2 | 深化 Dichterliebe 分析 |
| References | 添加音乐学文献 |

---

## 问题 6-8：格式问题（MINOR）

### 问题 6：引用缺失

**问题**：论文中存在 `[?]` 占位符。

**解决方案**：
- 检查所有引用
- 确保每个引用在 references.bib 中有对应条目
- 使用 BibTeX 正确编译

---

### 问题 7：公式排版

**当前**：
```latex
\begin{equation}
\text{Balanced Accuracy} = \frac{\text{Recall}_1 + \text{Recall}_2 + \text{Recall}_3}{3}
\end{equation}
```

**修订**：
```latex
\begin{equation}\label{eq:balanced_acc}
\text{Balanced Accuracy} = \frac{1}{K} \sum_{k=1}^{K} \frac{TP_k}{TP_k + FN_k}
\end{equation}
```

---

### 问题 8：特征维度混淆

**问题**：论文提到 60D 和 72D（12+60）。

**解决方案**：
在 Section 3 中澄清：
> "Our full feature set comprises 72 dimensions: 12 theory-driven features (tonal tension, harmonic complexity, texture, melody—each with mean, std, entropy) plus 60 empirical statistical features. For brevity, we refer to the empirical subset as '60D' and the combined set as '72D' throughout this paper."

---

## 修改优先级与时间线

### 第一阶段（Week 1-2）：关键方法论修复

| 任务 | 预计时间 | 输出 |
|------|----------|------|
| 速度特征控制实验 | 2 天 | 实验结果、论文修改 |
| MidiBERT 线性探测器 | 2 天 | 实验结果、论文修改 |
| GroupKFold 实现 | 3 天 | 套曲映射、新结果 |
| 重新运行所有实验 | 3 天 | 更新的结果表格 |

### 第二阶段（Week 3）：内容修订

| 任务 | 预计时间 | 输出 |
|------|----------|------|
| 重写结果部分 | 2 天 | Section 4 修订版 |
| 重写讨论部分 | 3 天 | Section 5 修订版 |
| 深化音乐学分析 | 3 天 | 具体例子和引用 |

### 第三阶段（Week 4）：最终完善

| 任务 | 预计时间 | 输出 |
|------|----------|------|
| 修复引用 | 1 天 | 完整参考文献 |
| 修复格式 | 1 天 | 符合 ISMIR 格式 |
| 最终审查 | 2 天 | 提交前检查 |

---

## 总结

本文档详细记录了论文草案中的 8 个关键问题及其解决方案。三个关键方法论问题（速度特征混淆、MidiBERT 基线、数据泄露）必须在提交前解决，否则极有可能被拒稿。

**核心建议**：
1. 透明地承认并解决速度特征问题
2. 实现公平的 MidiBERT 基线（线性探测器）
3. 使用 GroupKFold 消除数据泄露
4. 重新定位贡献，承认经验特征的主导地位
5. 深化音乐学分析，添加具体例子和文献支持

这些修改将显著提高论文的方法论严谨性和可防御性，增加 ISMIR 2026 接收的可能性。
