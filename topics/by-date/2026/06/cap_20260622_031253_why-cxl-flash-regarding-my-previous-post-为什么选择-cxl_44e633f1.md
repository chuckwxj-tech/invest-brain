---
id: 44e633f1-c795-46e9-bee3-f0ce5710d628
capture_type: page
url: "https://x.com/HiCagr/status/2068771102235705670"
canonical_url: ""
title: "Why CXL + Flash? (regarding my previous post)\n为什么选择 CXL+闪存？（关于我之前的帖子）\n\nThe moder..."
source_domain: x.com
author: "high cagr"
published_at: "2026-06-21T19:00:41.000Z"
captured_at: 2026-06-22T03:12:53.567595+00:00
storage_date: 2026-06-22
content_hash: 06511ae702fd489ab043468b657f9db32e4d098f8beef30c6f64759abc885aec
tags:
  - none
priority: urgent
research_intent: ""
user_notes: ""
dedup_status: unique
status: raw_captured
---

# Why CXL + Flash? (regarding my previous post)
为什么选择 CXL+闪存？（关于我之前的帖子）

The moder...

## 用户备注

_无备注_

## 原文

Why CXL + Flash? (regarding my previous post)
为什么选择 CXL+闪存？（关于我之前的帖子）

The modern data center has a memory economics problem. DRAM can run up to 50% of the cost of an Azure server and roughly 40% of total rack cost. Worse, a meaningful slice of that expensive capacity sits idle. Microsoft's Pond study measured memory stranding climbing past 10% as CPU allocation approaches 85%, reaching 25% at the 95th percentile during high utilization windows, with outliers near 30%.   

You can't just add more DRAM. DDR5 channels do not scale indefinitely. Push past the motherboard's limits and you hit signal integrity degradation, hard power envelopes, and a cost per gigabyte curve that breaks enterprise TCO. The pin count and the physics both run out.  

So now the question again, why CXL + Flash (CXL-attached flash/CXL-SSD)?   

Well, historically touching a block NVMe device meant crossing a deep software gap. An OS kernel interrupt, the storage driver stack. DMA operations staging 4KB page blocks into a local DRAM buffer. That path injects microsecond level latency that stalls CPU pipelines during AI vector and graph processing workloads.   

Now, when you put a CXL controller in front of a physical flash and you tap the PCIe Gen5/Gen6 transport directly (current designs route reads over the CXL.mem sub protocol and writes over 
http://
CXL.io), the flash stops behaving like a device you talk to through a driver and starts behaving like an extension of main memory.   

CXL.mem exposes the media into the CPU's coherent memory space as HDM. The CPU addresses it with native load/store instructions at 64-byte cache line granularity. You are no longer issuing I/O anymore, instead, you are dereferencing a pointer.   

There is a catch, however, and it gets handled in silicon. Flash still reads internally at page boundaries, so the 64-byte access the CPU wants and the page the flash returns do not line up. A DRAM and SRAM buffer inside the CXL-SSD controller absorbs the mismatch. On a buffer hit you get near-DRAM latency. On a miss you pay flash media latency, which Kioxia rates under 5 microseconds for SLC XL-Flash and under 10 microseconds for multi-level cell.   

CXL flash is a microsecond class memory tier, not a nanosecond one. The nanosecond figures floating around belong to CXL-attached DRAM pooling, which is a different product. What CXL flash actually buys you is density and cost/gigabyte, not DRAM speed.   

So:  

Near/fast tier: CPU-attached DDR5, with HBM as the tier above it where present, typically on the accelerator, sometimes on-package with the CPU. The hottest pages, direct cache allocations, and the matmul weights that sit closest to compute (those live in HBM).  

Far/capacity tier: CXL-attached flash. The ultra-dense expansion tier for warm data. Multi-terabyte LLM embedding tables or secondary database shards.  

You do not manage that split by hand, the OS does it. Meta's Transparent Page Placement (TPP) was open-sourced and merged upstream into the Linux kernel. It profiles access patterns in kernel space, promotes hot pages up to local DRAM, and demotes cold pages down to the CXL tier. The application never changes and never issues an explicit I/O. It is transparent to the workload, NOT a context switch.   

Lastly, why CXL + flash?   

Because memory is the most expensive and most stranded resource in the rack, and this is how you reclaim it. CXL Type 3 expanders and memory disaggregation give you DRAM-adjacent capacity at flash economics for warm data. If you are still scaling capacity by bolting on DDR channels, you are building YESTERDAY'S data center.   

Thank you for your time.  

---

As always, if I left anything out or got anything wrong, please let me know, as I want to know.

---

So you're saying buy $KXIAY..?  Got it!

---

> sees Flash
> doesnt read article
> SNDK to $3000

Okay got it

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
