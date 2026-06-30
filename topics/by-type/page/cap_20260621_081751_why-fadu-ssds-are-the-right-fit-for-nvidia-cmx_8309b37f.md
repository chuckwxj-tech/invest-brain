---
id: 8309b37f-7f43-4b62-811e-e23024af6835
capture_type: page
url: "https://blogs.fadu.io/cmx-ssd-for-ai-inference/"
canonical_url: "https://blogs.fadu.io/cmx-ssd-for-ai-inference/"
title: "Why FADU SSDs Are the Right Fit for NVIDIA CMX"
source_domain: blogs.fadu.io
author: "FADU Tech"
published_at: "2026-06-15T06:59:16+00:00"
captured_at: 2026-06-21T08:17:51.482834+00:00
storage_date: 2026-06-21
content_hash: 6f2df693727f5b4165e31a34fba3dfc5d3407864a2653c7d4ba2083ffa9bfb9a
tags:
  - none
priority: normal
research_intent: ""
user_notes: ""
dedup_status: unique
status: raw_captured
---

# Why FADU SSDs Are the Right Fit for NVIDIA CMX

## 用户备注

_无备注_

## 原文


				
				share
The New Bottleneck in AI Inference StorageAI 推理存储的新瓶颈



CMX SSD for AI Inference is emerging as a critical storage architecture as AI workloads shift from single-shot prompts to long, session-based interaction. The way people use AI has shifted from single-shot prompts to long, session-based interaction — a back-and-forth across many turns, increasingly driven by agents acting on the user’s behalf. For any of this to work, the model has to “remember” earlier turns, which means the context they produced has to be retained across the session. The alternative is to recompute that context on every turn, forcing the GPU to redo work it has already done — spending the datacenter’s most expensive resource on output that is not net-new. So a session’s context has to live somewhere it can be retained cheaply and fetched fast.CMX SSD 正在成为关键存储架构，因为 AI 工作负载从单次提示转向长时间的、基于会话的交互。人们使用 AI 的方式已从单次提示转变为基于会话的长时间交互——这是一个多轮往返的过程，越来越多的代理代表用户执行操作。为了实现这一切，模型必须“记住”之前的轮次，这意味着它们产生的上下文必须在整个会话中保留。另一种选择是在每一轮中重新计算该上下文，迫使 GPU 重复已经完成的工作——将数据中心最昂贵的资源耗费在非全新的输出上。因此，会话的上下文必须存储在一个既能低成本保留又能快速获取的地方。



NVIDIA introduced CMX (Context Memory eXtension) in early 2026 as a new storage tier built for exactly this. It’s still a high-performance NVMe deployment at its core, but it exists to solve a problem the existing memory hierarchy can no longer handle on its own. As context windows stretch into millions of tokens, the KV cache that has to stay accessible during inference grows exponentially: a single conversation now produces tens of gigabytes of it, and a multi-agent workflow produces hundreds.NVIDIA 在 2026 年初推出了 CMX（上下文内存扩展），作为一个专为此需求而生的全新存储层级。它本质上仍是高性能 NVMe 部署，但旨在解决现有内存层次结构自身已无法处理的问题——随着上下文窗口扩展至数百万 token，推理过程中必须保持可访问的 KV 缓存呈指数级增长：一次对话现在会产生数十 GB 的 KV 缓存，而多智能体工作流则产生数百 GB。



Every layer of the existing hierarchy struggles with this:现有层次结构的每一层都难以应对这一问题：




HBM is fast, but most of it is taken by model weights. The room left for KV cache fills up quickly.HBM 速度很快，但大部分空间被模型权重占用，留给 KV 缓存的空间很快就填满了。



Local SSD has the capacity, but it’s stuck inside one node. Other GPUs in the pod can’t reach it.本地 SSD 有容量，但受限于单个节点，集群中的其他 GPU 无法访问它。



Network storage is shared, but too slow for decode. The GPU ends up waiting on storage instead of generating tokens.网络存储是共享的，但对于解码来说速度太慢。GPU 最终会等待存储，而不是生成令牌。




Context Memory Hierarchy (Source: NVIDIA GTC 2026)上下文内存层次结构（来源：NVIDIA GTC 2026）


The result is GPU stall. Either the system recomputes evicted KV cache and burns compute and energy, or the GPU sits idle waiting on a slow path. Neither scales.结果是 GPU 停顿。系统要么重新计算被驱逐的 KV 缓存，消耗计算资源和能量，要么 GPU 闲置等待慢速路径。这两种方式都无法扩展。



CMX fills the gap. It’s a shared storage tier that sits between local SSD and network storage, fast enough to feed decode without stalling and accessible across every GPU in the pod. That requires more than a generic enterprise SSD underneath — it needs storage tuned for the large-block, sustained, multi-tenant traffic CMX generates.CMX 填补了这一空白。它是一个共享存储层，位于本地 SSD 和网络存储之间，速度足够快，能够在不停顿的情况下为解码提供数据，并且集群中的每个 GPU 都能访问。这需要的不仅是底层通用的企业级 SSD——它需要针对 CMX 生成的大块、持续、多租户流量进行优化的存储。



That’s where the SSD choice matters, and where FADU SSDs come in. For SSD for AI Inference, the drive must sustain large-block reads, high utilization, and multi-tenant traffic without turning storage into the next bottleneck.这就是 SSD 选择的关键所在，也是 FADU SSD 发挥作用的地方。对于用于 AI 推理的 SSD，驱动器必须能够承受大块读取、高利用率和多租户流量，而不会让存储成为下一个瓶颈。







Why AI Inference Needs So Much Memory为什么 AI 推理需要如此大的内存



Before we get to CMX, it helps to understand where the memory pressure actually comes from. The answer is in how decode works — and that starts with one term that runs through the rest of this document: the KV cache. As the model reads a prompt, it computes a key/value pair for every token and keeps those pairs in memory so it never has to recompute them. That stored set of key/value pairs is the KV cache — the model’s working memory of everything it has seen so far.在讨论 CMX 之前，先了解一下内存压力究竟来自何处会有所帮助。答案就在于解码的工作原理——而这要从贯穿本文剩余部分的一个术语开始：KV 缓存。当模型读取提示词时，它会为每个令牌计算一个键/值对，并将这些对保存在内存中，这样就不必重新计算。这组存储的键/值对就是 KV 缓存——模型迄今为止所见内容的临时工作记忆。



LLM inference has two phases:LLM 推理分为两个阶段：




Prefill processes the input prompt in parallel, builds the KV cache, and produces the first output token. It sets TTFT (Time To First Token) — in practice, how long the user waits before the answer starts appearing.预填充阶段并行处理输入提示，构建 KV 缓存，并生成第一个输出令牌。它决定了 TTFT（首个令牌生成时间）——实际上，就是用户等待答案开始出现的时间。



Decode generates the rest of the output one token at a time. Every step reads the entire KV cache built so far. It sets TPS (Tokens Per Second) — how fast the answer is written out once it starts.解码阶段逐个令牌生成剩余的输出。每一步都会读取到目前为止构建的整个 KV 缓存。它决定了 TPS（每秒令牌数）——即答案开始生成后的输出速度。




The key part is this: every decode step reads the whole KV cache, not just the latest entry. The longer the conversation, the more data each step has to pull from memory.关键在于：每个解码步骤都会读取整个 KV 缓存，而不仅仅是最新条目。对话越长，每一步需要从内存中提取的数据就越多。



Decode KV Cache Growth  解码 KV 缓存增长



This already creates memory pressure in a single conversation. But the real shift is happening at the workload level. AI inference used to be stateless. A user sent a query, the GPU computed a response, and the KV cache was discarded. Memory footprint was ephemeral.这已单次对话中造成了内存压力。但真正的变革发生在工作负载层面。过去，AI 推理是无状态的：用户发送查询，GPU 计算响应，KV 缓存随即丢弃，内存占用是短暂的。



Agentic AI changes this completely. Agents run in loops — plan, use tools, observe, reflect, refine — and they need to remember everything across those iterations. Context is no longer a per-query byproduct. It’s persistent state that has to survive across days or weeks of operation.代理式 AI 彻底改变了这一局面。代理以循环方式运行——规划、使用工具、观察、反思、优化——并且需要在多次迭代中记住所有内容。上下文不再是每次查询的副产品，而是必须持续数天甚至数周运行的持久状态。



Agentic Workflow: The Multiplier Effect on Context Demand代理式工作流：上下文需求的倍增效应



The result is a multiplier effect. Each agent ingests large documents, retrieval corpora, and tool traces. Each agent also runs multi-step reasoning loops that reuse context many times over. And the incentive runs one way: more context generally produces better results — its value tends to grow faster than its size — so systems are pushed to keep more context, not less. KV cache went from a session-level artifact to a long-lived operational asset that has to stay accessible.结果是产生了倍增效应。每个代理会摄入大量文档、检索语料库和工具轨迹。每个代理还运行多步推理循环，多次重复使用同一上下文。而且推动方向只有一个：更多的上下文通常能带来更好的结果——其价值增长速度往往超过其规模——因此系统被迫保留更多上下文，而非更少。KV 缓存从会话级产物转变为必须保持可访问的长期运行资产。



Decode speed depends on memory bandwidth, and KV cache reuse depends on memory capacity. If KV cache fits in HBM, decode runs at full speed. If it doesn’t, the system either falls back to slower storage or recomputes the cache from scratch. Recomputation means the GPU stops generating tokens and redoes prefill work it already did. TPS collapses, TTFT spikes on follow-up turns.解码速度依赖于内存带宽，KV 缓存复用则取决于内存容量。若 KV 缓存能完全存入 HBM，解码将以全速运行；若不能，系统要么退而求其次使用较慢的存储设备，要么从头重新计算缓存。重新计算意味着 GPU 停止生成令牌，并重做已完成的预填充工作。这会导致 TPS 骤降，后续轮次的 TTFT 急剧上升。



This is the memory wall CMX is built to break.这正是 CMX 所需打破的内存墙。







How CMX Breaks the Memory WallCMX 如何打破内存墙



So this is where CMX comes in. The problem we just described is straightforward to state but hard to solve. KV cache for long-context and multi-agent workloads can easily reach tens or hundreds of gigabytes per session. HBM doesn’t have the capacity. Host DRAM is bottlenecked by the GPU-CPU path. Local SSD has the capacity but stays trapped inside one node, invisible to the rest of the pod. Network storage is shared but far too slow for decode traffic.因此，CMX 应运而生。我们刚才描述的问题说起来简单，解决起来却极为困难。长上下文和多代理工作负载中，KV 缓存每个会话轻易就能达到数十乃至数百 GB。HBM 没有这么大的容量；主机 DRAM 受限于 GPU-CPU 路径；本地 SSD 虽有容量，却局限在单个节点内，无法被整个计算集群的其他节点访问；网络存储虽能共享，但对解码流量而言速度太慢。



CMX fills the gap between local SSD and network storage by providing three things at the same time:CMX 通过同时提供以下三项功能，填补了本地 SSD 与网络存储之间的空白：




Speed — RDMA over Spectrum-X delivers near-DRAM latency for KV cache reads, with no host CPU involvement on either side.速度——基于 Spectrum-X 的 RDMA 为 KV 缓存读取提供了接近 DRAM 的延迟，且两端均无需主机 CPU 参与。



Capacity — pod-scale storage measured in terabytes per GPU, enough to keep long-context and agentic state resident.容量——以每 GPU 数 TB 计算的 Pod 级存储，足以常驻长上下文和代理状态。



Sharing — accessible across every GPU in the pod, so any node can pick up where another left off.共享——Pod 内每个 GPU 均可访问，因此任何节点都可以接续其他节点的工作。




The way CMX achieves this is the interesting part. The Host BlueField-4 on the GPU node virtualizes storage as a local NVMe device, but the actual data lives on a separate endpoint with its own BlueField-4 and SSD pool. When the GPU issues a read, the Host BF-4 turns it into an RDMA request and sends it across the network fabric. The Endpoint BF-4 receives the request, reads from the local NVMe SSDs, and ships the data back. The result is dropped directly into GPU HBM through PCIe peer-to-peer. The host CPU and DRAM never see the transfer.CMX 实现这一目标的方式是值得关注的。GPU 节点上的 Host BlueField-4 将存储虚拟化为本地 NVMe 设备，但实际数据存储在一个独立的端点上，该端点拥有自己的 BlueField-4 和 SSD 池。当 GPU 发起读取操作时，Host BF-4 将其转换为 RDMA 请求，并通过网络架构发送。Endpoint BF-4 接收请求，从本地 NVMe SSD 中读取数据，然后将数据传回。结果通过 PCIe 对等传输直接存入 GPU HBM。主机 CPU 和 DRAM 全程不参与数据传输。



CMX Server Architecture: High-Speed and Pod-SharedCMX 服务器架构：高速与 Pod 共享



This is what makes the speed claim real. The path from GPU HBM to flash and back is offloaded entirely to BlueField-4 on both ends. Spectrum-X provides the bandwidth, RDMA provides the latency, and direct data placement removes every unnecessary copy in between.这就是速度说法成真的原因。从 GPU HBM 到闪存再返回的路径完全由两端的 BlueField-4 处理。Spectrum-X 提供带宽，RDMA 提供低延迟，而直接数据放置则消除了中间所有不必要的复制操作。







What the SSD for AI Inference Has to DeliverAI 推理的 SSD 必须提供什么



The SSD for AI Inference has to meet requirements shaped by the unique characteristics of KV cache workloads at pod scale. While each deployment will have specific targets, the underlying design pressures are consistent across the industry.用于 AI 推理的 SSD 必须满足由大规模 Pod 环境下 KV 缓存工作负载的独特特性所塑造的要求。虽然每个部署都有特定目标，但底层的设计压力在整个行业中是共通的。



High-level requirements  高层次要求



The CMX SSD layer must address four fundamental needs:CMX SSD 层必须满足四个基本需求：



Requirement  要求Why it matters  为何重要Industry direction  行业方向Massive capacity per GPU  每 GPU 的大容量Long-context and agentic workloads generate tens of TB of KV cache per GPU. Capacity must scale linearly with GPU count while fitting within rack power and space envelopes.长上下文和代理型工作负载每个 GPU 生成数十 TB 的 KV 缓存。容量必须随 GPU 数量线性扩展，同时适应机架功耗和空间限制。30 TB+ single-drive capacities in dense form factors like E3.S在 E3.S 等紧凑外形规格中实现 30TB 以上的单盘容量Asymmetric read/write bandwidth非对称读写带宽KV cache traffic is read-dominant during decode, with writes only during prefill and cache updates. Workload profile is opposite to traditional balanced or write-heavy storage.在解码期间，KV 缓存流量以读为主，仅在预填充和缓存更新期间进行写入。工作负载模式与传统均衡型或写密集型存储相反。Read bandwidth several times higher than write bandwidth读带宽比写带宽高出数倍Sustained endurance  持续耐久性CMX storage runs 24/7 with constant KV cache updates. Enterprise-class endurance becomes a baseline, not a premium feature.CMX 存储全天候运行，不断进行 KV 缓存更新。企业级耐久性已成为基础要求，而非高级特性。Multiple DWPD as a baseline requirement多 DWPD 作为基本需求Power efficiency as primary metric能效作为首要指标SSDs represent a significant portion of CMX server power. System-level Tokens-per-Watt is directly affected by storage layer efficiency.SSD 在 CMX 服务器功耗中占据重要比重。系统级每瓦特令牌数直接受存储层效率影响。Gbps per watt as the governing metric, not price per TB决定性的指标是每瓦特的千兆位传输速率（Gbps per watt），而非每 TB 的价格







Workload characteristics that shape these requirements塑造这些需求的工作负载特征



CMX I/O patterns differ fundamentally from general-purpose enterprise storage:CMX 的 I/O 模式与通用企业级存储存在根本差异：



Characteristic  特性CMX Workload  CMX 工作负载Traditional Storage  传统存储I/O size  I/O 大小Large (often 1 MB+)  大容量（通常 1 MB 以上）Mixed, often small  混合，通常较小Mutability  可变性Immutable once written  写入后不可变Frequent updates  频繁更新Durability  耐久性Lossy acceptable (recomputable)可接受有损（可重新计算）100% required  100%必需Access pattern  访问模式Sequential dominant  顺序主导Random + sequential  随机+顺序Metadata overhead  元数据开销Minimal  最小Heavy (filenames, paths, etc.)繁重（文件名、路径等）



This profile fundamentally changes what a “good SSD” looks like for CMX deployments.这种特性从根本上改变了 CMX 部署中“优秀 SSD”的定义。







Why FADU SSD Is the Right Match for AI Inference为何 FADU SSD 是 AI 推理的正确匹配



FADU’s SSD product line addresses each of these requirements directly, not as a side effect of general-purpose engineering but as deliberate architectural choices. This makes FADU SSDs a strong fit for CMX SSD for AI Inference deployments where capacity, sustained bandwidth, endurance, and power efficiency define system-level value.FADU 的 SSD 产品线直接满足了这些要求，这并非通用工程设计带来的附带效果，而是刻意为之的架构选择。这使得 FADU SSD 非常适合用于 AI 推理的 CMX SSD 部署场景，在这些场景中，容量、持续带宽、耐久性和能效共同决定了系统级价值。



FADU SSD Value Propositions for CMXFADU SSD 对 CMX 的价值主张


Capacity: Built for Pod-Scale Storage容量：专为集群级存储打造



CMX servers today require 32~64 TB per SSD. FADU’s in-house E3.S 7.5mm design already supports up to 64 TB, and the same architecture can scale up to 256 TB as NAND density and package height allow. This directly addresses pod-scale capacity requirements while leaving headroom for future context growth.如今的 CMX 服务器要求每块 SSD 提供 32 至 64 TB 的容量。FADU 自研的 E3.S 7.5mm 形态设计已支持高达 64 TB，且同一架构可在 NAND 密度和封装高度允许的范围内扩展至 256 TB。这直接满足了集群级容量需求，同时为未来的上下文增长预留了空间。



Performance: 14 GB/s Sustained at Large Block Sizes性能：大块大小时持续 14 GB/s



CMX workloads are dominated by large sequential reads — KV cache blocks typically exceed 1 MB and transfers run from 10 GB to 100 GB at a time. FADU delivers up to 14 GB/s sustained read at 1 MiB block size on PCIe Gen5, doubling to 28 GB/s on the Gen6 roadmap. These are the exact operating points CMX requires. This isn’t a peak number on a clean drive; it’s the sustained behavior that keeps GPUs fed during decode.CMX 工作负载主要由大型顺序读取主导——KV 缓存块通常超过 1 MB，每次传输的数据量从 10 GB 到 100 GB 不等。FADU 在 PCIe Gen5 上以 1 MiB 块大小提供高达 14 GB/s 的持续读取速度，而在 Gen6 路线图上这一数字将翻倍至 28 GB/s。这正是 CMX 所需的精确操作点。这并非干净驱动器上的峰值数据，而是解码过程中保持 GPU 持续供给的稳态表现。



Power Efficiency: Gbps per Watt Leadership能效：每瓦 Gbps 领先



SSDs account for nearly half of CMX server power consumption. FADU’s PCIe Gen5 power efficiency leadership — recognized as industry-leading in independent testing — extends into the Gen6 roadmap. For a CMX rack with 64 SSDs, a 10–20% improvement in SSD efficiency translates to hundreds of watts of savings per rack, with cooling savings on top via PUE multiplication.SSD 几乎占 CMX 服务器功耗的一半。FADU 在 PCIe Gen5 上的能效领先地位——经独立测试认证为行业领先——将延续至 Gen6 路线图。对于配备 64 块 SSD 的 CMX 机架而言，SSD 能效每提升 10–20%，每个机架即可节省数百瓦功耗，叠加 PUE 倍率效应后，制冷成本也将同步降低。



Endurance: 3 DWPD with Configurable Over-Provisioning耐久性：3 DWPD，支持可配置超额配置



FADU guarantees 3 DWPD (Drive Writes Per Day — how many times the drive’s full capacity can be overwritten daily for its warranted life) with configurable Over-Provisioning (OP — capacity held in reserve, not exposed to the host, that the drive uses to sustain performance and extend endurance) through firmware optimization. Operators can tune OP based on actual workload patterns to extend endurance further, which matters in 24/7 CMX deployments where SSD replacement cycles directly impact TCO.FADU 通过固件优化，在可配置超额配置（OP——预留容量，不向主机暴露，用于维持性能和延长寿命）下保证 3 DWPD（每日全盘写入次数——驱动器在其保修期内每天可覆盖全部容量的次数）。运维人员可根据实际工作负载模式调整 OP，进一步延长寿命，这对于 7×24 小时运行的 CMX 部署尤为重要，因为 SSD 更换周期直接影响 TCO。



I/O Size Flexibility: 8/16/32 KiB IU SupportI/O 大小灵活性：支持 8/16/32 KiB IU



This is where general-purpose SSDs leave performance on the table. KV cache workloads operate at large block sizes, but most SSDs are designed around 4KB indirection units (IU — the smallest chunk the drive’s address map tracks; the FTL is the Flash Translation Layer, the table that maps host logical addresses to physical NAND locations) to handle small random I/O. FADU SSDs support flexible 8/16/32 KiB indirection units. Sizing the IU to match the workload reduces the FTL mapping table by a factor of 2–8, which means lower DRAM cost and lower power per drive — both critical for CMX economics.这正是通用 SSD 性能受限之处。KV 缓存工作负载以大块尺寸运行，但大多数 SSD 围绕 4KB 间接单元（IU——驱动器地址映射跟踪的最小块；FTL 即闪存转换层，是将主机逻辑地址映射到物理 NAND 位置的表）设计以处理小随机 I/O。FADU SSD 支持灵活的 8/16/32 KiB 间接单元。将 IU 大小与工作负载匹配可将 FTL 映射表缩减 2-8 倍，从而降低每块驱动器的 DRAM 成本和功耗——这两者对 CMX 的经济性都至关重要。



Multi-Model Isolation: FDP and Low WAF多模型隔离：FDP 和低写入放大因子



This is the differentiator that matters most for multi-model AI factories. DOCA Memos (NVIDIA’s software layer that manages a separate KV cache volume for each model on CMX) manages separate KV volumes per model — Model A with 1MB blocks, Model B with 10MB blocks. Without isolation, these mix in NAND blocks, and eviction triggers valid-page migration that pushes WAF (Write Amplification Factor — how many bytes the SSD actually writes to NAND for each byte the host sends; 1.0 is ideal, higher wastes endurance) above 1.这是多模型 AI 工厂最重要的差异化优势。DOCA Memos（NVIDIA 的软件层，用于在 CMX 上为每个模型管理独立的 KV 缓存卷）为每个模型管理独立的 KV 卷——例如模型 A 使用 1MB 块，模型 B 使用 10MB 块。如果没有隔离，这些数据会在 NAND 块中混合，导致数据回收时触发有效页迁移，从而推高 WAF（写入放大因子——SSD 每收到主机写入 1 字节时实际写入 NAND 的字节数；1.0 为理想值，越高越浪费耐久度）超过 1.0。



Multi-Model Isolation with FDP in DOCA MemosDOCA Memos 中基于 FDP 的多模型隔离



FADU’s FDP (Flexible Data Placement — an NVMe feature that lets the host steer related data into the same physical NAND region) implementation maps DOCA Memos KV volumes directly to NVMe Reclaim Unit Handles. Each model lives in its own reclaim unit, so eviction reclaims entire NAND blocks without migrating valid pages. The result is WAF approaching 1.0 — roughly 30% additional endurance headroom on top of the immutable nature of KV cache.FADU 的 FDP（灵活数据放置——NVMe 特性，允许主机将相关数据导向同一物理 NAND 区域）实现将 DOCA Memos 的 KV 卷直接映射到 NVMe 回收单元句柄。每个模型独立占据回收单元，因此回收时直接整块擦除 NAND，无需迁移有效页。最终 WAF 趋近 1.0——在 KV 缓存不可变特性的基础上，额外获得约 30%的耐久度余量。



Combined with FADU’s low-WAF FTL architecture, this delivers exactly what multi-model AI inference demands: predictable performance, maximum endurance, and clean isolation between tenant workloads.结合 FADU 的低 WAF FTL 架构，这正好满足了多模型 AI 推理的需求：可预测的性能、最大化的耐久性以及租户工作负载之间的清晰隔离。







The Synergy: Why FADU SSD + NVIDIA CMX协同效应：为何 FADU SSD + NVIDIA CMX



CMX represents NVIDIA’s reframing of KV cache from a transient byproduct of inference to a persistent, shareable, strategic asset. The success of this vision depends on a storage layer that can match CMX’s design intent — not a general-purpose NVMe SSD that happens to be fast.CMX 代表了 NVIDIA 对 KV 缓存的重新定义，将其从推理的瞬时副产品转变为持久、可共享的战略资产。这一愿景的成功取决于能够匹配 CMX 设计意图的存储层——而非恰好速度快的通用 NVMe SSD。



FADU SSDs are engineered around the same principles that make CMX work:FADU SSD 的设计理念与促成 CMX 成功的原理相同：




Capacity at pod scale — single-vendor solution from 32 TB to 256 TB on the Gen6 roadmap机架级容量——Gen6 路线图上从 32 TB 到 256 TB 的单供应商解决方案



Sustained performance at the workload’s actual operating point — Max Bandwidth at 1 MiB blocks, not peak-only benchmarks工作负载实际运行点的持续性能——1 MiB 块的最大带宽，而非仅峰值基准测试



Power efficiency where it matters most — Gbps per watt leadership in the significant portion of the server power budget consumed by SSDs在最关键的能效领域——SSD 占服务器功耗预算的显著部分，Gbps/瓦特指标领先



Endurance that compounds with KV cache immutability — 3 DWPD with configurable OP for additional headroom结合 KV 缓存不可变性的持久性——3 DWPD，并支持可配置 OP 以提供额外余量



FTL flexibility for AI workloads — 8/16/32 KiB IU support trades unused random-I/O capability for lower DRAM and power针对 AI 工作负载的 FTL 灵活性——支持 8/16/32 KiB IU，以牺牲未使用的随机 I/O 能力来换取更低的 DRAM 和功耗



FDP-based multi-model isolation — keeping WAF near 1.0 in real-world multi-tenant deployments基于 FDP 的多模型隔离——在实际多租户部署中保持 WAF 接近 1.0




In a CMX architecture where every component is co-designed for KV cache as a first-class data type, the SSD layer needs the same intentionality. FADU delivers it.在 CMX 架构中，所有组件都为 KV 缓存这一首要数据类型进行协同设计，SSD 层也需要同样的设计意图。FADU 实现了这一点。







The Bottom Line for AI Inference StorageAI 推理存储的底线



CMX changes what we should expect from an enterprise SSD. The deployment requirements — sustained large-block reads, 24/7 high-utilization workloads, multi-tenant isolation, and aggressive power budgets — exceed what a general-purpose NVMe was designed to handle.CMX 改变了我们对企业级 SSD 的期望。部署要求——持续的大块读取、7x24 小时高利用率工作负载、多租户隔离以及严苛的功耗预算——已经超出了通用 NVMe 设计所能处理的范围。



FADU’s architecture, from in-house E3.S hardware design to FDP-based workload isolation, is aligned with the CMX design philosophy at every layer. As AI inference infrastructure scales into the Vera Rubin era and beyond, FADU SSDs are positioned to be the storage layer that lets CMX deliver on its promise of 5x throughput and 5x power efficiency at pod scale.FADU 的架构，从自研 E3.S 硬件设计到基于 FDP 的工作负载隔离，在每一层都与 CMX 的设计理念保持一致。随着 AI 推理基础设施扩展到 Vera Rubin 时代及更远，FADU SSD 将定位为存储层，让 CMX 在机柜规模下实现 5 倍吞吐量和 5 倍能效的承诺。







Reference  参考




NVIDIA CMX Solution OverviewNVIDIA CMX 解决方案概述



Watch Jensen Huang’s GTC 2026 Keynote:On Demand | NVIDIA GTC San Jose 2026观看黄仁勋 GTC 2026 主题演讲：按需观看 | NVIDIA GTC 圣何塞 2026



NVIDIA Vera: Reimagining CPUs for Agents, Reasoning, and What’s Next S82437 | GTC San Jose 2026 | NVIDIA On-DemandNVIDIA Vera：为智能体、推理及未来重塑 CPU S82437 | GTC 圣何塞 2026 | NVIDIA 点播



젠슨 황의 신비로운 메모리 플랫폼…삼성·SK 기회 잡나 [강해령의 테크앤더시티] | 한국경제黄仁勋的神秘内存平台…三星和 SK 能否抓住机会 [姜海玲的科技与城市] | 韩国经济日报



KV Cache Explained Intuitively. An intuitive walkthrough of how… | by Saad Ahmed Siddiqui | Medium直观理解 KV 缓存：如何工作… | 作者：Saad Ahmed Siddiqui | Medium





			

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
