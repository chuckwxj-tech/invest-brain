---
id: b8e35bbe-594d-4886-8849-d738cf20b00d
capture_type: selection
url: "https://x.com/jietang/status/2089941544581403107"
canonical_url: ""
title: "Selection from: (13) jietang on X: \"Thoughts About Scaling Law Scaling, but not only of parameters. Every model release now ends with the same question: how many parameters? It isn't a question that can be answered on its own. Parameter count is only meaningful alongside three others — how much data you have,\" / X"
source_domain: x.com
author: ""
published_at: ""
captured_at: 2026-08-19T23:26:33.639674+00:00
storage_date: 2026-08-19
content_hash: 1f1bb83bd4f5783085c44eee571f0aae6459d5ca3edb1756fcb2656e9e507b85
tags:
  - none
priority: normal
research_intent: ""
user_notes: ""
dedup_status: unique
status: raw_captured
---

# Selection from: (13) jietang on X: "Thoughts About Scaling Law Scaling, but not only of parameters. Every model release now ends with the same question: how many parameters? It isn't a question that can be answered on its own. Parameter count is only meaningful alongside three others — how much data you have," / X

## 用户备注

_无备注_

## 原文

Thoughts About Scaling Law
关于缩放定律的思考

Scaling, but not only of parameters. Every model release now ends with the same question: how many parameters? It isn't a question that can be answered on its own. Parameter count is only meaningful alongside three others — how much data you have, where you intend to spend your compute, and who will run the model, under what conditions.
扩展，但不仅仅是参数的扩展。每一次模型发布到最后都会引出同一个问题：有多少参数？这个问题无法单独回答。参数数量只有与另外三个因素放在一起才有意义——你有多少数据、你打算把算力花在哪里、以及谁将在什么条件下运行这个模型。

The field learned this the hard way. Kaplan et al. (2020) fit an exponent that told everyone to grow parameters faster than data — roughly 2.7:1 — and the industry complied: GPT-3, Gopher, MT-NLG. Hoffmann et al. (2022) redid the experiment across four hundred models and found the compute-optimal split is closer to 20 tokens per parameter, and that with sufficient compute the two should grow at the same rate rather than drifting apart. The error in the earlier fit compounded with every order of magnitude of compute, which is why the largest models of that generation were the most misallocated. The trillion-parameter round was, in retrospect, a detour the whole field took together and then reversed.
这个领域是通过惨痛教训才明白这一点的。Kaplan 等人（2020）拟合出一个指数，告诉所有人参数的增长速度要快于数据——大约是 2.7:1——业界也照做了：GPT-3、Gopher、MT-NLG。Hoffmann 等人（2022）在四百个模型上重新做了实验，发现算力最优的分配比例接近每个参数 20 个 token，而且在算力充足的情况下，两者应该以相同的速率增长，而不是逐渐拉开差距。早期拟合中的误差随着算力每提升一个数量级而不断累积，这就是为什么那一代最大的模型恰恰是资源错配最严重的。回过头来看，万亿参数那一轮是整个领域一起走过的弯路，然后又一起退了回来。

Chinchilla wasn't the end either. It optimized training compute for models that would be trained once and evaluated. Today a model is called billions of times a day and inference dominates lifetime cost. Put inference into the objective and the optimum moves toward smaller models trained far longer — deliberate over-training, which is what Llama-2-7B and Gemma-2-9B were doing at roughly 290 and 889 tokens per parameter.  

Sparsity moved the target again. In a MoE model two quantities have to be kept apart: total parameters govern roughly how much the model can hold — knowledge, facts, the long tail — while activated parameters and effective depth govern roughly how far it can think, how many steps of a causal chain it can carry before it comes apart. A dense 20:1 ratio does not transfer. And the ratio isn't a single number at all: Roberts et al. (2025) find the optimal tokens-per-parameter is task-dependent, with memorization favoring more parameters and reasoning favoring more data. Follow-up work on MoE observes that at fixed TPP, pushing total parameters higher actually degrades reasoning, while activating more experts reliably helps it.  

This matters for what we are building toward. Finding a vulnerability is not a retrieval problem. It doesn't come from having memorized more CVEs; it comes from carrying a twenty-step chain of inference to the end without losing the thread. That capability does not live in total parameter count.
这对我们正在构建的目标至关重要。发现漏洞不是一个检索问题。它并非来自记住了更多 CVE，而是源于能够将一条二十步的推理链一路推到底而不迷失线索。这种能力并不存在于总参数量之中。

Which brings us to this release. Total parameters appear to matter up to a threshold — enough to hold the world — after which additional capability comes from scaling elsewhere: effective depth per forward pass, and above all post-training. GLM-5.3 is our controlled experiment on that claim. Same base, same architecture, same total and activated parameters as GLM-5.2. One month of scaling long-horizon environments and RL. The gains are not marginal. Well, scaling has more than one dial. We turned the post-training one this time because it had the most slack left in it — not because the others are finished. Base model size, pretraining data, compute spent per forward pass: all of them are still on the table, and we will come back to each. What this experiment taught us is that the dials do not have to be turned together, and that the one worth turning next is rarely the one that was worth turning last. We are not done scaling. Next time, maybe mid-training, pre-training, and even more.

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
