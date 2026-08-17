---
id: e769d5ee-d96e-4d21-8dc6-83b13a53d128
capture_type: selection
url: "https://x.com/neil_shah/status/2088900026437423356"
canonical_url: ""
title: "Selection from: (13) Neil Shah on X: \"Talking about packaging, have been digging into @intel XBM approach, fascinating me to understand different bottlenecks on how the engineers are trying to solve it. HBM ➡️ XBM Today, HBM relies on an ultra-wide parallel bus (1024–2048 bits), routing thousands of micro-wires https://t.co/S3nixCkXxo\" / X"
source_domain: x.com
author: ""
published_at: ""
captured_at: 2026-08-16T23:42:52.183479+00:00
storage_date: 2026-08-16
content_hash: 2c91d21f5413d3a11dafc678f004077dfb4ab5e7db5793c28e2710e2565fe934
tags:
  - none
priority: normal
research_intent: ""
user_notes: ""
dedup_status: unique
status: raw_captured
---

# Selection from: (13) Neil Shah on X: "Talking about packaging, have been digging into @intel XBM approach, fascinating me to understand different bottlenecks on how the engineers are trying to solve it. HBM ➡️ XBM Today, HBM relies on an ultra-wide parallel bus (1024–2048 bits), routing thousands of micro-wires https://t.co/S3nixCkXxo" / X

## 用户备注

_无备注_

## 原文

Talking about  packaging, have been digging into 
@intel
 XBM approach, fascinating me to understand different bottlenecks on how the engineers are trying to solve it.
谈到封装时，我一直在深入研究 @intel 的 XBM 方法，这让我着迷于理解工程师们在尝试解决不同瓶颈时的各种思路。

HBM  XBM

Today, HBM relies on an ultra-wide parallel bus (1024–2048 bits), routing thousands of micro-wires demands an expensive Silicon Interposer (like TSMC CoWoS).   

The most expensive part (design)of HBM if you understand isn’t the DRAM chips it’s the massive piece of silicon sitting underneath them.   

It’s the hidden, cascading cost penalties, supply-constrained, thermal headaches that the interposer forces onto the entire system rather than just interposer $$ cost.  

Intel’s XBM (Cross-Batch Memory) looks to ‘omit’ the interposer entirely with two major architectural changes:  

 Serial UCIe over Wide Parallel Links
instead of routing ~1,000 parallel wires, XBM converts data into high-speed serial UCIe streams @ 32 GT/s. (First diagram)  

Far fewer wires enables direct substrate routing.

Thus no need for silicon interposer and stiffeners, shrinking Z-height & saving on packaging complexities and costs.

 BEOL (Back-End of Line via TFTs ) DRAM (Moving the Memory Cells Up) from FEOL (Front-End of Line) - second diagram

Standard DRAM builds its cells in the silicon base (FEOL), competing with logic for real estate.  

Intel shifts the 1T1C memory cells into the back-end metal layers (BEOL) using Thin-Film Transistors (TFTs).  

The base silicon is now 100% dedicated to logic and TSVs.  

 Serial chiplet links could end the traditional HBM interposers if this alternative of XBM from 
@Intel_Foundry
 takes off.
  串行小芯片（chiplet）链路可能会终结传统的 HBM 中介层，如果 @Intel_Foundry 的 XBM 替代方案得以普及的话。

However, there are a few of hurdles around XBM approach which needs to be addressed:
然而，围绕 XBM 方法存在一些需要解决的障碍：

 Latency Penalty & Fast SerDes causing issues around Thermals
  延迟惩罚与高速 SerDes 导致热相关问题

 Adding TFTs is not trivial inside BEOL and needs to be mastered 
  在 BEOL 中添加 TFT 并非易事，需要掌握相关技术

 From Concept to Commercialisation: hearing it could take 2030 to reach that level to go mainstream and depends on an anchor client and memory partner adopting it with entrenchment of ecosystem around, JEDEC standards, CoWoS investments for HBM makes the switch difficult
  从概念到商业化：据悉可能要到 2030 年才能达到主流水平，这取决于核心客户和内存合作伙伴的采用，以及周边生态系统的固化。JEDEC 标准、用于 HBM 的 CoWoS 投资都使转型变得困难

This is where Intel has been gaining good mindshare back to solving problems for the industry as a strong alternative to current incumbents.
这正是英特尔重新赢得良好心智份额、为行业解决问题的领域，成为现有巨头的强大替代方案。

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
