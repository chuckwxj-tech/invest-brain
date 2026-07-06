---
id: 3dcaa1fd-0e59-4f71-8922-5e4b7b0ecb06
capture_type: page
url: "https://x.com/BSPK_/status/2072138489269981368"
canonical_url: ""
title: "Etched, What is the Low-Latency Memory Technology 'CSM'?\nEtched，什么是低延迟内存技术“CSM”？..."
source_domain: x.com
author: "BSPK"
published_at: "2026-06-30T15:00:09.000Z"
captured_at: 2026-07-06T00:31:03.884064+00:00
storage_date: 2026-07-06
content_hash: 23dc05fde5cf7f1597727b8931ed1e69bccc1a2fd96148ec60e03e424e51ddb5
tags:
  - none
priority: urgent
research_intent: ""
user_notes: ""
dedup_status: unique
status: raw_captured
---

# Etched, What is the Low-Latency Memory Technology 'CSM'?
Etched，什么是低延迟内存技术“CSM”？...

## 用户备注

_无备注_

## 原文

Etched, What is the Low-Latency Memory Technology 'CSM'?
Etched，什么是低延迟内存技术“CSM”？

In the AI industry, the biggest cost doesn't come from the stage of training models, but from the 'inference' stage where the trained model responds to users' questions. Inference is currently the biggest cost and performance bottleneck for AI companies. At the end of June this year, a startup called Etched, founded by two Harvard dropouts in 2022, ended its roughly two-year stealth period and unveiled a product targeting this issue. The key points of the announcement were that it raised $800 million, secured $1 billion in customer contracts, and its first chip will ship this summer.  

The technology Etched has introduced consists of two parts, one of which is CSM (Cluster-Scale Memory), aimed at latency. The problem CSM addresses is an old dilemma. The speed at which AI generates tokens one by one depends not on computational power, but on 'how quickly data can be read from memory.' However, the two options conflict with each other. HBM, which has large capacity but relatively slow access, or SRAM, which has fast access but small capacity. Using HBM slows down serving speed, while using SRAM requires connecting hundreds of chips to hold the model, significantly increasing costs.  

In recently mainstream MoE models, this problem becomes even more complex. MoE must send data to 'experts' distributed across multiple chips for each token. It's a process of moving to other chips, passing through network switches, and reading data at the destination before returning. Every time it goes through a memory hierarchy or passes through the network once, latency accumulates. Etched describes this as "the best layer is no layer at all."  

CSM takes an approach to reduce this hierarchy. It configures a single low-latency shared memory pool across the entire cluster of tightly bound chips, and uses a proprietary electrical interconnect—rather than optics—to make inter-chip memory access close to local levels. It's a hybrid structure that secures capacity with HBM and speed with SRAM, designed to meet both requirements simultaneously. Throughput is handled by another technology called LVI, while latency is managed by CSM, with the goal of alleviating the performance trade-offs where you had to give up one to gain the other until now.  

In the AI industry, the biggest cost doesn't come from the stage of training models, but from the 'inference' stage where the trained model responds to users' questions. Inference is currently the biggest cost and performance bottleneck for AI companies. At the end of June this year, a startup called Etched, founded by two Harvard dropouts in 2022, ended its roughly two-year stealth period and unveiled a product targeting this issue. The key points of the announcement were that it raised $800 million, secured $1 billion in customer contracts, and its first chip will ship this summer.  

The technology Etched has introduced consists of two parts, one of which is CSM (Cluster-Scale Memory), aimed at latency. The problem CSM addresses is an old dilemma. The speed at which AI generates tokens one by one depends not on computational power, but on 'how quickly data can be read from memory.' However, the two options conflict with each other. HBM, which has large capacity but relatively slow access, or SRAM, which has fast access but small capacity. Using HBM slows down serving speed, while using SRAM requires connecting hundreds of chips to hold the model, significantly increasing costs.  

In recently mainstream MoE models, this problem becomes even more complex. MoE must send data to 'experts' distributed across multiple chips for each token. It's a process of moving to other chips, passing through network switches, and reading data at the destination before returning. Every time it goes through a memory hierarchy or passes through the network once, latency accumulates. Etched describes this as "the best layer is no layer at all."  

CSM takes an approach to reduce this hierarchy. It configures a single low-latency shared memory pool across the entire cluster of tightly bound chips, and uses a proprietary electrical interconnect—rather than optics—to make inter-chip memory access close to local levels. It's a hybrid structure that secures capacity with HBM and speed with SRAM, designed to meet both requirements simultaneously. Throughput is handled by another technology called LVI, while latency is managed by CSM, with the goal of alleviating the performance trade-offs where you had to give up one to gain the other until now.   

---

We're coming out of stealth.

We've built our first racks after a successful A0 tapeout, $1B+ in customer contracts, and $800m raised.

Early customer tests show us achieving SOTA throughput, latency, and power efficiency on inference workloads.

Our first racks ship this summer.

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
