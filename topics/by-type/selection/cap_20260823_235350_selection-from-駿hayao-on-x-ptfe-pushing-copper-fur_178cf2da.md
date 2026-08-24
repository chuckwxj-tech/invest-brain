---
id: 178cf2da-9626-4e95-b7f7-70404d486273
capture_type: selection
url: "https://x.com/QQ_Timmy/status/2090998171778621810"
canonical_url: ""
title: "Selection from: 駿HaYaO on X: \"《PTFE Pushing Copper Further》 一、核心要點 英偉達計劃在 Rubin Ultra 的 NVSwitch 板（Portia / NVSwitch 7）上採用 PTFE（聚四氟乙烯）材料的混合方案，以延長銅互連在 scale-up 網路中的生命週期。但最終設計與是否採用，取決於 PTFE 技術和 PCB 供應商在 Rubin Ultra 量產時的成熟度。 https://t.co/NJjy7LPWPj\" / X"
source_domain: x.com
author: ""
published_at: ""
captured_at: 2026-08-23T23:53:50.900404+00:00
storage_date: 2026-08-23
content_hash: bcd674e15610c4effab0035849056db1aed245edc37c7979e1806558d5379d0c
tags:
  - none
priority: normal
research_intent: ""
user_notes: ""
dedup_status: unique
status: raw_captured
---

# Selection from: 駿HaYaO on X: "《PTFE Pushing Copper Further》 一、核心要點 英偉達計劃在 Rubin Ultra 的 NVSwitch 板（Portia / NVSwitch 7）上採用 PTFE（聚四氟乙烯）材料的混合方案，以延長銅互連在 scale-up 網路中的生命週期。但最終設計與是否採用，取決於 PTFE 技術和 PCB 供應商在 Rubin Ultra 量產時的成熟度。 https://t.co/NJjy7LPWPj" / X

## 用户备注

_无备注_

## 原文

《PTFE Pushing Copper Further》
《PTFE 推动铜更进一步》

一、核心要點
英偉達計劃在 Rubin Ultra 的 NVSwitch 板（Portia / NVSwitch 7）上採用 PTFE（聚四氟乙烯）材料的混合方案，以延長銅互連在 scale-up 網路中的生命週期。但最終設計與是否採用，取決於 PTFE 技術和 PCB 供應商在 Rubin Ultra 量產時的成熟度。

二、背景
- SemiAnalysis 早在 GTC 2025 就提到英偉達有意導入 PTFE，替代目前的玻纖布基 CCL（覆銅板）。
- 原本預期採用 PTFE 的 Kyber 產品被推遲後，英偉達轉向在 Rubin Ultra Oberon 部署中引入 PTFE。
二、背景
- SemiAnalysis 早在 GTC 2025 就提到英伟达有意导入 PTFE，替代目前的玻纤布基 CCL（覆铜板）。
- 原本预期采用 PTFE 的 Kyber 产品被推迟后，英伟达转向在 Rubin Ultra Oberon 部署中引入 PTFE。

三、樹脂技術演進（為什麼需要 PTFE）
優秀的電氣性能要求樹脂低極性、分子結構對稱。樹脂發展路徑：
1.環氧樹脂（FR-4 至 M4）：含大量環氧基團，性能有限。
2.PPO/PPE（低損耗時代）：苯環結構帶來更好的對稱性。
3.碳氫樹脂（M7 超低損耗時代引入，M9 已以碳氫為主）：C-H 鍵低極性 + 鋸齒形分子鏈構象，介電性能優異。

PTFE 是下一步唯一方案：
- 氟原子均勻分佈在碳主鏈周圍，分子幾乎無淨極性 → Dk ≈ 2.1，Df ≈ 0.0003（10 GHz），是 CCL 中損耗最低的常用聚合物。
- C-F 鍵能高達約 460.5 kJ/mol（高於 C-H 和 C-C 鍵），且氟原子對碳主鏈的屏蔽更強 → 極佳的化學穩定性、耐腐蝕、耐熱與抗氧化性能。
PTFE 是下一步唯一方案：
氟原子均匀分布在碳主链周围，分子几乎无净极性 → Dk ≈ 2.1，Df ≈ 0.0003（10 GHz），是 CCL 中损耗最低的常用聚合物。
C-F 键能高达约 460.5 kJ/mol（高于 C-H 和 C-C 键），且氟原子对碳主链的屏蔽更强 → 极佳的化学稳定性、耐腐蚀、耐热与抗氧化性能。

各等級 CCL 電氣性能對比（10 GHz）：

四、PTFE 的製造挑戰
1. 樹脂鑽污難去除：分子量增大、流動性下降，鑽孔後殘留鑽污極難清除——極性越低，PCB 加工越難。
2. 熱塑性而非熱固性：環氧/PPO/碳氫樹脂加熱交聯後不可逆，可承受多次壓合與 PCBA 製程；PTFE 不會不可逆交聯，難以承受多次層壓和組裝週期。
3. 機械性能差：滑、軟、機械強度不足，鑽孔時易產生毛刺、孔壁質量差，尺寸穩定性難以維持。
四、PTFE 的制造挑战
1. 树脂钻污难去除：分子量增大、流动性下降，钻孔后残留钻污极难清除——极性越低，PCB 加工越难。
2. 热塑性而非热固性：环氧/PPO/碳氢树脂加热交联后不可逆，可承受多次压合与 PCBA 制程；PTFE 不会不可逆交联，难以承受多次层压和组装周期。
3. 机械性能差：滑、软、机械强度不足，钻孔时易产生毛刺、孔壁质量差，尺寸稳定性难以维持。

五、當前解決方案：混合方案
PTFE 作為核心層 + M9 級 prepreg（半固化片）：PTFE 提供信號性能優勢，玻纖布層提供機械支撐，比純 PTFE 方案更易製造。

六、產業鏈關鍵玩家
- 生益科技：與英偉達合作開發 PTFE 超過 12 個月，處於領先地位，已向多家 PCB 廠交付 PTFE 材料送樣。
- 健鼎：最近成功產出 PTFE 材料 PCB 樣品。
- 台光電子 + 台虹：結成夥伴——EMC 擅長 Megtron 級 CCL/prepreg（M9 級玻纖布基），TaiFlex 專長 PFA（全氟烷氧基樹脂，兼具 PTFE 的耐化學/熱穩定性與常規熱塑性塑料的可熔融加工性），共同為英偉達提供混合方案。
六、产业链关键玩家
- 生益科技：与英伟达合作开发 PTFE 超过 12 个月，处于领先地位，已向多家 PCB 厂交付 PTFE 材料送样。
- 健鼎：最近成功产出 PTFE 材料 PCB 样品。
- 台光电子 + 台虹：结成伙伴——EMC 擅长 Megtron 级 CCL/prepreg（M9 级玻纤布基），TaiFlex 专长 PFA（全氟烷氧基树脂，兼具 PTFE 的耐化学/热稳定性与常规热塑性塑料的可熔融加工性），共同为英伟达提供混合方案。

七、結論
PTFE 憑藉極致的低介電常數與低損耗，是銅互連邁向下一代高速網路的關鍵材料，但製造難度大；混合方案（PTFE 核心 + M9 玻纖布支撐）是當前務實的折中路徑。英偉達能否在 Rubin Ultra 上實際採用，仍取決於屆時供應鏈的成熟度。

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
