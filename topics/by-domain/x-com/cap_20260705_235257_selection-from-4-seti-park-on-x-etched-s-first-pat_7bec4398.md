---
id: 7bec4398-43de-496d-a216-4b1e2eab043c
capture_type: selection
url: "https://x.com/seti_park/status/2073765397103604134"
canonical_url: ""
title: "Selection from: (4) SETI Park on X: \"Etched's First Patent Filing Asks to Delete the Memory Switch\" / X"
source_domain: x.com
author: ""
published_at: ""
captured_at: 2026-07-05T23:52:57.104005+00:00
storage_date: 2026-07-05
content_hash: 037b71aae4c56f4663a31af5dfb0a1c732864d49c00ae611b4b003f8b6dd2f71
tags:
  - none
priority: urgent
research_intent: ""
user_notes: ""
dedup_status: unique
status: raw_captured
---

# Selection from: (4) SETI Park on X: "Etched's First Patent Filing Asks to Delete the Memory Switch" / X

## 用户备注

_无备注_

## 原文

Etched's First Patent Filing Asks to Delete the Memory Switch
Etched 的首个专利申请要求删除内存开关

1 万
FIG. 5, from Etched's first patent filing: independent memory channels (510) run through dedicated wires (520) straight into individual columns (515) of the on-chip math array, with no switch anywhere in the path. Etched pitched this as its no-layer memory philosophy in its stealth-exit thread in late June 2026. The drawing is dated May 2023.
图 5，来自 Etched 的首个专利申请：独立内存通道（510）通过专用导线（520）直接连接至片上数学阵列的各个列（515），路径中没有任何开关。Etched 在 2026 年 6 月底的隐退公告中将其称为“无层级内存”理念。该图绘制于 2023 年 5 月。
A Wire Where the Industry Puts a Switch
行业放置开关之处的那根导线
Between an AI chip's math units and the memory that feeds them, designers typically place a switch, a piece of routing hardware that lets the chip reach all of its memory [0043]. Etched's very first patent filing asks to delete it. US 2024/0378175 A1, filed 10 May 2023, claims memory channels wired straight into the columns of a giant multi-chip math array, no switch in between [0016], [0044]. The inventors are the company's co-founders, Gavin Uberti and Christopher Zhu, and the filing names the payoff plainly: no switching element to build, which can save space and power [0045]. In late June 2026 Etched pitched that same absence as its memory philosophy, "the best layer is no layer", presented as shipping hardware in the company's telling. The written version is three years older, and the patent office still hasn't said yes to it.
在 AI 芯片的数学单元与为其供应的存储器之间，设计师通常会放置一个开关——一种路由硬件，让芯片能够访问其所有存储器[0043]。Etched 最早提交的专利申请书就要求删除这一设计。US 2024/0378175 A1 号专利（2023 年 5 月 10 日提交）声称，存储器通道直接连接到巨型多芯片数学阵列的列中，中间不需要开关[0016]、[0044]。发明人是该公司的联合创始人 Gavin Uberti 和 Christopher Zhu，申请书直截了当地点明了收益：无需构建开关元件，可节省空间和功耗[0045]。2026 年 6 月下旬，Etched 将相同的“无开关”理念作为其存储器哲学提出，即“最佳层就是无层”，并在公司宣传中将其描述为即将出货的硬件。书面版本比这早了三年，而专利局至今仍未批准。
The pitch and the filing are different kinds of record. The thread that announced Etched's stealth exit is the company telling its own story: "$1B+ contracts", "$800m raised", first racks shipping in the summer, every figure the company's own claim (TechCrunch). The origin filing is the opposite: a public, dated record, signed by the architecture's authors before the company had a product to sell.
宣传文稿和正式文件是不同类型的记录。宣布 Etched 悄然退出的那篇推文，是该公司在讲述自己的故事："超 10 亿美元合同"、"8 亿美元融资"、首批机柜将于夏季发货，每项数据均为公司自述（来自 TechCrunch）。而作为对照的原始文件则是：一份公开的、有日期的记录，在该公司尚未有产品可销售时，便已由架构作者签署。
That mix is the verdict in miniature. The filing proves authorship: the memory half of Etched's architecture story was in claim language long before the pitch. What it is not, yet, is the property itself: three years in, the no-switch memory idea remains a bet on becoming an asset, not the asset. The rest of the record prices exactly that, down to the borrowing secured against the patent stack this filing belongs to.
这种混杂恰恰是最终定论的缩影。文件证明了原创性：Etched 架构故事中关于存储的部分，早在宣传文稿之前就以专利主张语言的形式存在。但截至此刻，它还尚未成为资产本身——三年过去，这种"无切换存储"的理念仍是一笔押注，期望它成为资产，而非资产本身。文件其余部分则精确地标定了这一点，乃至详细到借款人以此文件所属的专利组合为抵押所获得的贷款。
One Giant Array, Stitched From Identical Chips
一个由相同芯片拼接而成的巨大阵列
Strip away three years of product story and the document asks for something easy to picture. It claims a package holding many small chips, each carrying its own modest math array, joined to its neighbors so that the whole package computes as one enormous array [0013], [0028]. The filing gives two reasons why anyone would bother. Chips have a compute ceiling: "most chips have, at most, floating point systolic arrays with a size of 128×128" [0018], roughly sixteen thousand multipliers. That ceiling is concrete, and industry-wide. Google's in-house AI chip, the TPU, ran its floating-point matrix units at 128×128 on generations through v5p, and moved to 256×256 with Trillium (Google Cloud TPU documentation). And chips have a memory ceiling: the filing calls it "unreasonable to expect a single chip to interface with 100s of GB of memory" [0018], which is the space a large model's parameters take up.
抛开三年的产品故事，这份文档描述的内容很容易想象。它声称有一个封装内包含许多小芯片，每个小芯片都带有自己规模适中的数学阵列，并与相邻芯片连接，使得整个封装作为一个巨大的阵列进行计算[0013]、[0028]。申请文件给出了两个人们愿意费心这么做的理由。芯片存在计算上限："大多数芯片最多只有尺寸为 128×128 的浮点脉动阵列"[0018]，大约一万六千个乘法器。这个上限是具体的，并且是整个行业普遍存在的。谷歌的自研 AI 芯片 TPU 在其 v5p 及之前的世代中，浮点矩阵单元都运行在 128×128，而 Trillium 版本则升级到了 256×256（Google Cloud TPU 文档）。此外，芯片还存在内存上限：申请文件称"期望单个芯片与数百 GB 内存交互是不合理的"[0018]，而数百 GB 正是一个大型模型参数所占用的空间。
A systolic array, the building block being copied here, is a grid of small arithmetic units that pass data to their neighbors on every tick, built for jobs that "perform the same task with different data at different times" [0002]. Model weights drop in from the top, and the filing notes they may be constants [0021]. The data being processed, the tensor, streams in from the left [0021]. FIG. 1 shows the shape, plus a property the description spells out: one grid can carry two computations at once, for a single layer of an AI model or for different layers [0024].
脉动阵列——此处复制的构建模块——是由小型运算单元构成的网格，每个时钟周期向相邻单元传递数据，专为“在不同时间对不同数据执行相同任务”[0002]的工作而设计。模型权重从顶部流入，归档说明指出它们可能是常数[0021]。正在处理的数据（张量）从左侧流式输入[0021]。图 1 展示了其形状，以及描述中阐明的一个特性：单个网格可同时承载两个计算，用于 AI 模型的单层或不同层[0024]。
FIG. 1: the basic systolic array, two computations sharing one grid.
The filing's answer to both ceilings is to "adapt a multi-chip approach" and connect the small arrays "using high-speed chip-to-chip connections to form a larger, combined systolic array" [0019]. Four chips of 100×100 in a row make one 100×400 array, and the same four stacked as a column make a 400×100 [0038]. The seams are real, but the filing hides them from the machine that matters:
"from the perspective of the host 205, the systolic array 250 appears to be one large array, even though it is physically made up of smaller local systolic arrays 220 distributed on separate ICs 215" - US 2024/0378175 A1, [0028]
In a version the filing describes, the chips are all interchangeable: "In one embodiment, the ICs 215 are all identical." [0028] One small chip design, manufactured many times, adding up to something no single chip could be.
FIG. 2: nine ICs (215), each holding a local array (220), fused into one combined array (250); memory chips (210) line the top row; the host (205) attaches over PCIe (240).
The wiring half of that story, the part Etched has since gotten granted, has a companion analysis of its own (US 12,361,091 B1). That granted record never wrote the memory half down. This filing is where the memory half lives, and it is the sharpest claim in the document.
The Memory Claims Delete the Switch
Feeding the giant array is a memory problem, and the description is candid about how the industry handles it. High-bandwidth memory, HBM, the stacked memory that feeds modern AI accelerators, delivers its capacity through independent channels, and "the different channels 510 cannot communicate with each other" [0043]. So designers put a switch in the middle:
"a switch (or some kind of switching element such as a crossbar) is typically used so that the device can access the entire memory of the HBM" - US 2024/0378175 A1, [0043]
That switch is the layer this filing exists to delete. For workloads whose weights never change, the description says the channels "can be directly wired (or hardwired) to a particular column 515 in the local systolic array" [0044]. A column here is not small: it "could extend through all the ICs 215 in a column" [0044], from the top of the package to the bottom. FIG. 5 draws it: two memory chips (505), four independent channels (510), dedicated wires (520), four columns (515), and nothing else in the path.
The absence is the point. Hardwiring "avoids having to add a switching element between the local systolic array" and the memory chips, "which can save space and power" [0045]. The trade is stated just as plainly: a column can now read only its own channel. The filing accepts that because the weights parked in those channels are constants that always go to the same columns [0045], [0035].
Claim 39 is where the drawing becomes a legal ask. Translated: a package with a chip carrying a math array, plus a separate memory device, with every memory channel hardwired to its own column or columns, "without any switching element" in between [0016]. The description says the same thing in one long sentence:
"Another embodiment in this disclosure is a package that includes an IC comprising a systolic array of data processing units (DPUs) and a separate memory device comprising a plurality of channels where each of the plurality of channels is hardwired to respective one or more columns in the systolic array without any switching element." - US 2024/0378175 A1, [0016]
The drafting treats the idea as its own invention. Claim 39 is an independent claim, one that stands alone instead of refining another, and it does not require the multi-chip package at all. The reverse is also true: the broadest package claim does not require memory chips, which the description concedes "may not be needed" [0037]. The two halves of the architecture are claimed separately, which is exactly why the memory half can be judged, and owned, on its own. The no-layer pitch is not marketing retrofitted onto hardware. It is claim language, dated May 2023.
The rest of the memory story is economics. A second independent claim asks for the weight-streaming setup itself: memory chips storing an AI model's weights, coupled to the chips that form the array's top row [0014]. Weights enter at the top and get reused all the way down, because "data fed from the memory chips 305 is reused across the rows" [0039], so adding rows of chips adds compute without adding a single memory chip [0039]. Bandwidth scales on the other axis: multiple memory chips per top-row chip can "transmit more than 1 TB/s of data to each of the ICs" [0040], by the description's own numbers, about a feature film's worth of data every five thousandths of a second. FIG. 3 draws the square-grid version with six memory chips across the top, and a sibling sheet, FIG. 4, redraws the same design with unequal rows and columns.
FIG. 3: the square-grid variant; multiple memory chips (305) feed each top-row chip.
Three years after these paragraphs were filed, the company's stealth-exit thread made the same idea its memory pillar and named it CSM, Cluster Scale Memory in the press's expansion (TechCrunch). Its pitch line was "each memory layer adds latency; the best layer is no layer". The pitch and the claims name the same absence, and this document is where the absence has a date. What no filing can show is silicon. Whether the racks the company says are shipping practice these claims is invisible from the patent record. And the thread's other engineering pillar, a power-delivery story the company calls LVI, appears nowhere in this filing. That absence carries one standing caveat: applications younger than 18 months can exist unpublished and unseen.
Math That Forgets, a Sidecar That Remembers
The filing is equally specific about what kind of machine this is. In one version it describes, the combined array "does not take instructions at runtime, and only executes instructions in a preset loop" [0027]. That sentence lives in the description rather than in any claim, but it names the identity: not a general-purpose processor that happens to run AI, a machine with one job, repeated forever. This is the architecture bet in its purest form, fixed function and fixed workload, written down in 2023.
Transformers, the model family the document uses as its running example [0003], have one part that refuses to forget. The filing notes that "self-attention operations use data computed from previous tokens" [0047], so somewhere in the machine, history has to be stored. Most of a transformer's work treats each token in isolation, which is exactly what the combined array is built for [0047]. Attention is the exception, and the filing gives it separate hardware.
In this variant, each chip pairs its slice of the array with auxiliary circuitry, a sidecar processor sitting beside the tile, and gives the sidecar its own private memory: "the auxiliary circuitry 605 in each IC 615 is coupled to at least one local memory chip 610" [0048]. The application claims the split too. As drafted, claims 11 through 13 give each chip the sidecar, give the sidecar the attention work, and wall its memory off from the arrays, down to a flat negative rule: "the local systolic arrays 220 do not have access to the local memory chips 610" [0051]. The floor plan physically separates math that forgets from math that remembers.
FIG. 6: inside each IC (615), the array tile (220) and the auxiliary circuitry (605) sit side by side; the private local memory chips (610) hang off the auxiliary circuitry, outside the combined array (650).
The last drawing tackles a practical worry, whether a machine this large can be kept busy. FIG. 7 charts one row of the combined array pushing a transformer layer through in batches [0053], [0055], and none of what it shows is claimed anywhere. It is the description showing its work.
One attention step alone, computing what the filing calls query values, means the data "passes through the systolic array three times" [0055]. The answer is overlap: inputs for the next computation are fed in "before the previous computation completes" [0056]. The one stall the description concedes is layer normalization, a housekeeping step between stages, and even with that stall the array can still hold "a 98% or greater utilization" [0057]. A document that only wanted to impress would have stopped at the giant array. This one budgeted its idle cycles.
FIG. 7: a row's clock-by-clock schedule for one transformer layer. Description-only, no claim covers it: attention passes, pre-fed next batches, and the lone stall at layer normalization (Time B).
The Examiner's Bear Case, and What Survives It
Now the pricing, and the status fits in one sentence. As of the May 2026 record, this application is still pending, with examination continuing after a final rejection mailed 23 October 2025 and a request for continued examination docketed 24 April 2026. Every claim quoted above is still a request, not a right.
The bear case is genuinely strong, and it is already on file. The examiner has assembled eight references against this application, spanning multi-node machine-learning acceleration, hybrid parallelism and neural-network accelerators, with Intel, IBM and Rambus among the companies behind them: a crowded field. The breadth that makes this filing quotable is exactly what makes it shrinkable. Claim 1, as drafted, reads on more or less any multi-chip systolic-array package, and breadth like that is usually the first casualty of examination. Even claim 39's distinctive absence, the no-switch hardwiring, could yet be judged routine for weight-stationary designs, accelerators that keep weights parked in place, which is precisely the category this filing lives in. The founders wrote it down early. The patent office decides whether early also meant original.
What survives the bear case is the record of behavior. The authorship is dated and signed: 10 May 2023, co-founders Uberti and Zhu. The drafting is deliberate: the memory idea got a stand-alone independent claim rather than a dependent footnote to the package claim. Etched chose to call it an invention in its own right. And the application has been kept alive past the rejection rather than allowed to lapse. None of that requires the claims to survive. A signed, dated statement of the architecture, still being defended, is evidence about the company, whatever the office eventually says about the field.
The money angle runs through the whole stack, and it cuts both ways by design. When Etched borrowed from TriplePoint Capital, the collateral was its patent portfolio, pledged under security interests, a lender's registered claim on the assets if the loan sours. The first, effective 19 April 2024 (USPTO reel/frame 067204/0877), covered the four applications Etched had at the time, this filing among them. The second, effective 18 July 2025 (reel/frame 071792/0869), covered the portfolio including the three patents that had by then granted: US 12,306,903, US 12,361,091 and US 12,361,262. Both liens are blanket: they cover everything, and they say nothing about any single filing's worth. What they do say is that Etched's patent stack is the company's bankable asset class, and, symmetrically, that the stack is what a creditor reaches if the bet goes wrong.
One more registry note, offered as an observation. This application is US-only, with no international counterpart under the PCT, the treaty route for filing abroad. It has no continuation either, the follow-on filing that keeps a patent family growing, while the granted trio got both treatments. The filing's family tree is thinner than the trio's, and the record does not say why.
再提一条注册注意事项，仅供参考。该申请仅限美国，没有通过 PCT（海外申请的条约途径）的对应国际申请。它也没有延续申请——这种后续申请能延续专利族的发展，而已授权的三件专利则同时采用了这两种处理方式。该申请的专利族结构比那三件专利更为单薄，且备案文件中未说明原因。
An Asset in Formation
在建资产
The verdict is firm. This document is the real origin of Etched's memory story. The no-switch idea is the founders' own writing, in claim language before there was anything to sell. It has been defended through examination since, and it sits inside the patent stack the company has twice pledged as loan collateral. It is not yet the asset itself. The claims as drafted can shrink or die, and until the patent office says yes, Etched holds a dated, signed statement of the memory idea it pitches, not an exclusive right to it.
The one thing the pitch cannot do is finish the paperwork. Racks shipping this summer, if they ship, are not evidence that these claims will grant. That question gets decided against the examiner's citations, nowhere else.
The test ahead is binary and public. If claim 39 and its memory-side siblings emerge with the no-switch limitation materially intact, the philosophy Etched pitches becomes property it owns, and the origin filing converts from roadmap to asset. If they narrow to ornament or die, the document stays what it is today, the earliest signed record of the bet, with the office's answer stapled to it. The place to watch is not the thread but the application's public docket, and the company's next response on it. In the pitch the layer is already gone. At the patent office, Etched is still paying to own the deletion.
接下来的测试是二元的且公开的。如果权利要求 39 及其存储器侧的同类项在实质性保留无切换限制的情况下出现，那么 Etched 所推崇的理念将成为其拥有的财产，原始申请文件也将从路线图转变为资产。如果它们被限制为装饰或消亡，则该文件将保持现状，成为该赌注最早签署的记录，并附有专利局的答复。值得关注的地方不是讨论串，而是申请的公开案卷以及公司对此的下一次回应。在宣传中，这一层已经不复存在。而在专利局，Etched 仍在为拥有删除这一事实而付费。
Sources
来源
Patents
US20240378175A1, "Multi-Chip Systolic Arrays," Etched.ai, Inc., filed 2023-05-10, published 2024-11-14, inventors: Gavin Uberti, Christopher Zhu.
US20240378175A1，“多芯片脉动阵列”，Etched.ai, Inc.，申请日 2023 年 5 月 10 日，公开日 2024 年 11 月 14 日，发明人：Gavin Uberti，Christopher Zhu。
News & media
新闻与媒体
TechCrunch, Etched stealth-exit coverage (30 June 2026). https://techcrunch.com/2026/06/30/nvidia-competitor-etched-hits-5b-valuation-1b-in-sales-for-ai-chip/
TechCrunch：Etched 秘密退出报道（2026 年 6 月 30 日）。https://techcrunch.com/2026/06/30/nvidia-competitor-etched-hits-5b-valuation-1b-in-sales-for-ai-chip/
Companion analysis of granted US 12,361,091 B1, "the wiring half" (prior essay in this series).
对美国授予的 12,361,091 B1 专利“布线半部”的配套分析（本系列前文）。
Technical specs
技术规格
Google Cloud blog, in-depth look at Google's first Tensor Processing Unit. https://cloud.google.com/blog/products/ai-machine-learning/an-in-depth-look-at-googles-first-tensor-processing-unit
Google Cloud 博客，深度解析谷歌首款张量处理单元。https://cloud.google.com/blog/products/ai-machine-learning/an-in-depth-look-at-googles-first-tensor-processing-unit
Google Cloud TPU documentation, introduction to TPU. https://docs.cloud.google.com/tpu/docs/intro-to-tpu
Google Cloud TPU 文档，TPU 简介。https://docs.cloud.google.com/tpu/docs/intro-to-tpu

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
