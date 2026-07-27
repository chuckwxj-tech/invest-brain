---
id: 61d35216-117e-4ff3-a570-61b49f45c2b0
capture_type: selection
url: "https://semiconductor.samsung.com/news-events/tech-blog/breaking-ai-memory-limits-with-cxl-memory-pooling/"
canonical_url: ""
title: "Selection from: Breaking AI Memory Limits with CXL Memory Pooling | Samsung Semiconductor Global"
source_domain: semiconductor.samsung.com
author: ""
published_at: ""
captured_at: 2026-07-26T23:38:54.808871+00:00
storage_date: 2026-07-26
content_hash: 0f7ac55f0a8c026619a3516c1df8157f15954997a590bd7c0e00c1136ef427ab
tags:
  - none
priority: normal
research_intent: ""
user_notes: ""
dedup_status: unique
status: raw_captured
---

# Selection from: Breaking AI Memory Limits with CXL Memory Pooling | Samsung Semiconductor Global

## 用户备注

_无备注_

## 原文

Breaking AI Memory Limits with CXL Memory Pooling
How Samsung achieved near-DRAM performance while scaling KV Cache capacity for LLM inference.
facebook
X
linkedin
mail
share
Jul 08, 2026
Solving the KV Cache scaling challenge with CXL memory pooling

As generative AI adoption accelerates, the focus of AI infrastructure is shifting beyond training performance. For organizations deploying Large Language Models (LLMs) in production, inference efficiency and scalability have become critical factors in delivering responsive and cost-effective AI services.

One emerging challenge is the rapid growth of KV Cache (Key-Value Cache) requirements. As context lengths increase and the number of concurrent users grows, the memory required for KV cache can quickly exceed available GPU memory and system DRAM resources. This creates a new bottleneck in AI inference infrastructure.

To address this challenge, Samsung evaluated CXL-based memory pooling for KV cache offloading, exploring whether it could provide scalable memory expansion while maintaining performance close to that of conventional DRAM.

 


Figure 1. LLM inference flow with KV cache
 

Why KV Cache matters

LLMs rely on KV Cache to store previously computed attention keys and values during inference. By reusing this information instead of recomputing it for every generated token, models can significantly reduce inference latency and computational overhead.

However, as model sizes, context lengths, and user concurrency continue to grow, KV Cache requirements can easily reach hundreds of gigabytes. Traditional offloading approaches based on SSDs or network-attached memory can alleviate capacity constraints, but often introduce additional latency and bandwidth overhead.

 

The opportunity of CXL memory pooling

Compute Express Link (CXL) is emerging as a key technology for next-generation data center architectures. By enabling memory expansion through a coherent, high-bandwidth interconnect, CXL allows systems to scale beyond the physical limitations of traditional DRAM configurations.

When combined with a CXL switch, multiple memory devices can be aggregated into a shared memory pool, enabling flexible memory allocation and significantly increased capacity.

Samsung's CMM-D (CXL Memory Module-DRAM) is designed to enable these memory expansion architectures, offering an attractive solution for memory-intensive workloads such as AI inference.

 

Evaluating CXL memory for AI inference

The evaluation environment consisted of NVIDIA RTX PRO 6000 Blackwell GPUs, Samsung CMM-D modules connected through a CXL switch and configured as a 1TB CXL memory pool, the vLLM1 and LMCache2 software stack, and host-level optimizations based on our techniques.

The primary question was straightforward: Can a CXL memory pool support large-scale KV Cache offloading while maintaining performance comparable to DRAM?

 


Figure 2. System block diagram of the evaluation environment
 

Delivering near-DRAM performance at greater scale

The evaluation demonstrated that CXL memory pooling can deliver both near-DRAM performance and substantial memory scalability for AI inference workloads.

In single-GPU configurations, the optimized CXL memory pool achieved performance comparable to DRAM when used as the LMCache backend. In multi-GPU environments utilizing eight GPUs, the CXL memory pool maintained approximately 92% of DRAM performance while providing significantly greater memory capacity.

The study also compared a 512GB DRAM configuration with a 1TB CXL memory pool under increasing KV Cache demands. As KV Cache requirements exceeded available DRAM capacity, performance degradation occurred due to cache re-computation overhead. In contrast, the CXL memory pool maintained stable performance while accommodating substantially larger KV Cache footprints.

 

The future of memory pooling for AI infrastructure

Samsung's evaluation shows that CXL-based memory pooling can provide both substantial memory expansion and near-DRAM performance for KV Cache offloading workloads.

As the CXL ecosystem continues to mature, memory pooling architectures are expected to become a foundational building block for future AI data centers, enabling more flexible, scalable, and efficient infrastructure deployments.


Learn more

For readers interested in detailed system configurations, optimization techniques, and comprehensive benchmark results, the full white paper[1] provides an in-depth analysis of the evaluation methodology and findings. Download

 

 
References
 
[1] White Paper: Optimizing KV Cache Offloading to CMM-D in a CXL Switch-based Memory Pool
https://download.semiconductor.samsung.com/resources/white-paper/Optimizing_KV_Cache_Offloading_to_CMM-D_in_a_CXL_Switch-based_Memory_Pool.pdf
 
The white paper provides detailed benchmark results, system-level optimization techniques, and performance analysis behind Samsung's evaluation of KV Cache offloading using CXL memory pooling. Readers seeking a deeper understanding of the architecture, methodology, and real-world implications for scalable AI inference can explore the full report.
 
1 vLLM is an open-source LLM inference engine that improves inference throughput through efficient GPU memory utilization.
 
2 LMCache is an open-source framework that enables KV Cache to be stored and reused across multiple memory tiers, including GPU memory, CPU memory, CXL memory and SSD.
 
* The contents of this page are provided for informational purposes only. No representation or warranty (whether express or implied) is made by Samsung or any of its officers, advisers, agents, or employees as to the accuracy, reasonableness or completeness of the information, statements, opinions, or matters contained in this page, and they are provided on an "AS-IS" basis. Samsung will not be responsible for any damages arising out of the use of, or otherwise relating to, the contents of this page. Nothing in this page grants you any license or rights in or to information, materials, or contents provided in this document, or any other intellectual property.
 
* The contents of this blog may also include forward-looking statements. Forward-looking statements are not guarantees of future performance and that the actual developments of Samsung, the market, or the industry in which Samsung operates may differ materially from those made or suggested by the forward-looking statements contained in this blog.
 
* All product specifications and performance data included in this article reflect internal test results and are subject to variations by user's system configurations. Actual performance may vary depending on use conditions and environment.
 
* All images shown are provided for illustrative purposes only and may not be an exact representation of the products.
 
* Compute Express Link® (CXL®) is a registered trademark of the Compute Express Link Consortium.
 
* PCI Express® and PCIe® are registered trademarks of PCI-SIG.
 
* NVIDIA, Blackwell, and RTX are trademarks or registered trademarks of NVIDIA Corporation in the United States and/or other countries.

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
