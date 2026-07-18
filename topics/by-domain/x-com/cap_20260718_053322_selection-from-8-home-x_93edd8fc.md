---
id: 93edd8fc-8d85-4a5f-b752-630b85cf0f3f
capture_type: selection
url: "https://x.com/home"
canonical_url: ""
title: "Selection from: (8) Home / X"
source_domain: x.com
author: ""
published_at: ""
captured_at: 2026-07-18T05:33:22.817265+00:00
storage_date: 2026-07-18
content_hash: 640ab056101466db6cbd7842f5d75897543856e64aef809acaa2833145a3938e
tags:
  - none
priority: normal
research_intent: ""
user_notes: ""
dedup_status: fuzzy_warn
status: raw_captured
---

# Selection from: (8) Home / X

## 用户备注

_无备注_

## 原文

駿HaYaO
@QQ_Timmy
·
3h
就像之前對 DeepSeek R1 的恐慌一樣，有些不了解情況的人認為 Kimi K3 使用線性注意力（KDA）會對 NVIDIA、HBM、DRAM 和網路不利，因為它的 KV-cache 需求相對較低。事實正好相反。

Kimi K3 其實對 NVIDIA 相當有利，因為大模型推理正是 NVL72 最能發揮優勢的領域。K3 擁有超過 2.8 兆個參數，因此需要大型 scale-up 域來存放它的權重。

其次，雖然 Kimi Delta Attention 對 KV-cache 傳輸的網路需求最多可降低 10 倍，但它龐大的權重需要更多網路頻寬來實現一種叫做 WideEP 的優化技術，這種技術會把權重分散到不同 GPU 上。

WideEP 會將 896 個專家分散到多個 GPU 上，讓每個 GPU 的 HBM 只存放少量專家，從而優化每個 token 的記憶體使用量和運算利用率。

WideEP 優化的不幸缺點是它會消耗極大量的網路頻寬。WideEP 非常適合機架規模的系統，例如 GB200/GB300 NVL72，其銅背板提供的頻寬比同級的 DGX B200 系統高出 18 倍。

此外，由於權重已經占用了超過 1.5 TB 的 HBM 容量，即使在相對較低的用戶並發量下，K3 的 KDA 和 Gated MLA 的 KV cache 也需要卸載到 CPU DDR5 和 NVMe 上，因為 HBM 已經所剩無幾。

Kimi 自己也表示，K3 的最佳推理需要一個具有大型 scale-up 域的機架，至少要用到 64 個晶片。

最後，Jevons 悖論（Jevons’ Paradox）意味著，讓注意力機制更有效率反而會推動更廣泛的 AI 採用，最終需要更多 GPU、HBM、DRAM 和網路——而不是更少。

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
