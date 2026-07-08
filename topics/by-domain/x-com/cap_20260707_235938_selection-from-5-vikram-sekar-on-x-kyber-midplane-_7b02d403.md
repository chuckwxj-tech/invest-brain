---
id: 7b02d403-c7ac-429b-a3e0-a7f97075e499
capture_type: selection
url: "https://x.com/vikramskr/status/2074474358614139192"
canonical_url: ""
title: "Selection from: (5) Vikram Sekar on X: \"Kyber Midplane Design, Making NVL72x2 Work, and All Roads Lead to CPO\" / X"
source_domain: x.com
author: ""
published_at: ""
captured_at: 2026-07-07T23:59:38.908507+00:00
storage_date: 2026-07-07
content_hash: 5553940b6ed48fc0c0270345e199052bf87130eecf27b34eeccb53c9960a175e
tags:
  - none
priority: normal
research_intent: ""
user_notes: ""
dedup_status: unique
status: raw_captured
---

# Selection from: (5) Vikram Sekar on X: "Kyber Midplane Design, Making NVL72x2 Work, and All Roads Lead to CPO" / X

## 用户备注

_无备注_

## 原文

Kyber Midplane Design, Making NVL72x2 Work, and All Roads Lead to CPO
Kyber 背板设计、让 NVL72x2 工作，以及条条大路通 CPO

7.2 千
In a July 6 X post, SemiAnalysis reported that Nvidia’s Kyber NVL144 rack has slipped by more than 12 months, from 2027 to 2028, because the PCB midplane remains hard to manufacture. Nvidia has pushed back saying that the roadmap is unchanged. A lot of the discourse is analyst sourced, and thus opinionated, including this note itself. I noted in an earlier X post that Nvidia’s moves all point to difficulty in copper scale-up for Kyber, which is why they were pushing for optical approaches.
在 7 月 6 日的一条 X 帖子中，SemiAnalysis 报道称，英伟达的 Kyber NVL144 机架已推迟超过 12 个月，从 2027 年延至 2028 年，原因在于 PCB 中板仍难以制造。英伟达反驳称路线图未变。许多讨论源自分析师，因此带有主观意见，包括本篇文章本身。我曾在早些时候的一条 X 帖子中指出，英伟达的种种动向均指向 Kyber 在铜缆扩展方面存在困难，这也是他们推动光学方案的原因。
Beyond the midplane PCB, SemiAnalysis notes that:
除了中板 PCB 外，SemiAnalysis 还指出：
The NVL576 multi-rack system is also likely delayed or limited to small volumes due to CPO challenges, leaving Nvidia without a proven way to expand the scale-up world size for Rubin Ultra.
NVL576 多机架系统也可能因 CPO 挑战而推迟或仅限于小批量生产，导致英伟达缺乏经证实的方法来扩大 Rubin Ultra 的扩展域规模。
The NVL72x2 back-to-back architecture was cancelled after pushback from hyperscalers over its odd design and operational burden.
NVL72x2 背对背架构在遭到超大规模云服务商对其奇特设计和运维负担的反对后被取消。
The Oberon rack will remain the mainstay, and Nvidia will sell more of them in the Rubin era to cover the Kyber shortfall. SemiAnalysis still sees data center compute revenue running 20 percent above consensus in the second half of FY27, so views are not uniformly bearish.
奥伯龙机架仍将是主力产品，英伟达将在鲁宾时代销售更多此类机架，以弥补凯伯的供应缺口。SemiAnalysis 预计，在 2027 财年下半年，数据中心计算收入仍将比市场共识高出 20%，因此整体观点并非一致看空。
In this post, we will view all these claims through an engineering lens to understand the underlying physics, draw conclusions where possible, and suggest solutions that might be deployed.
在本文中，我们将以工程视角审视所有这些论断，理解其中涉及的物理学原理，在可能的情况下得出结论，并提出可能采用的解决方案。
Table of contents:
目录：
Is the midplane PCB really too hard to manufacture?
中面板 PCB 真的难以制造吗？
NVL72x2: Why It Might Have Really Been Cancelled
NVL72x2：它为何可能真的被取消
NVL72x2: How to Make it Work
NVL72x2：如何让它运作
CPO for Scaling up World Size
通过 CPO 扩展世界规模
Does this really create an opening for Google and AMD?
这是否真的为谷歌和 AMD 创造了机会？
At the end of this post, you will walk away with greater nuance as to what roadblocks are in the way of next generation hardware, how the big players are working around them, and where the pieces might fall in the future.
在本篇文章的结尾，你将更细微地理解下一代硬件面临哪些障碍、行业巨头如何应对这些挑战，以及未来局势可能如何演变。
Is the midplane PCB really too hard to manufacture?
中板 PCB 真的太难制造了吗？
Let’s first introduce the midplane PCB and explain what problem it aims to solve. Here is a picture of it:
首先，我们来介绍中板 PCB，并说明它旨在解决什么问题。这里有一张它的图片：
In all the generations of racks till date, the scale-up domain in NVIDIA racks has always been copper. There is a cable cartridge that contains just over 5,000 passive copper cables that hook up the GPUs in an all-to-all configuration. As the interconnect speeds in the scale-up domain increased in every successive generation, copper interconnect reach became an issue. Copper’s losses meant that you needed something much shorter than long copper cables running through a spine. Enter the PCB
迄今为止的所有机架代系中，NVIDIA 机架内的纵向扩展域一直采用铜缆连接。一个电缆盒中装有超过 5000 根无源铜缆，以全互联配置连接 GPU。随着每一代产品中纵向扩展域互连速度的提升，铜缆的传输距离成为问题。铜缆的损耗意味着需要比贯穿脊骨的长铜缆更短的连接方案。于是，PCB 登场了。
The idea of the PCB was simple: hook up all the GPUs and network switches on a board level, instead of cables running through a spine. The compute trays would hook into one side and the network switches on the other. Then, by simply running traces on the PCB, you can get GPUs hooked up to each other. Simple and elegant right?
PCB 的理念很简单：将所有 GPU 和网络交换机集成在板级连接，而非通过线缆连接主干架构。计算托盘接入一侧，网络交换机接入另一侧。这样，仅需在 PCB 上布设线路追踪，就能让 GPU 相互连接。简洁又优雅，不是吗？
Source: Semivision on X📷
No. Turns out that this is a routing problem of gargantuan proportions (literally) because you can’t just draw metal lines between GPUs like in a picture. As a result the routing problem only increases. You would need to route over or under metal connections to prevent them from intersecting.
Think of a freeway intersection: to keep the flow of traffic moving smoothly, you have different levels of roads, each level adding a significant amount of complexity to the routing problem.
Source: r/engineeringporn
It’s the same problem on the PCB, except that you have about 78 layers. In addition, the Kyber rack has 144 GPUs compared to the Blackwell era “Oberon” rack which has 72 GPUs. The exact PCB layer count seems to differ based on who you ask, but the takeaway remains: it is a very complex PCB. The midplane PCB makes the equivalent of 20,000 connections that would otherwise need to be copper cables which would be too many to fit in the spine. These boards are built on separate 26 layer boards each nearly a square meter in size and then laminated together to form a massive PCB required for Kyber midplane.
Anybody who has worked with high speed interconnects knows that PCBs are not automatically better. Sure, you can pack a higher routing density in a smaller space cutting the reach distance, but that says nothing about the losses. In general cables have lower losses for high speed signals than metal lines on a PCB. To keep the midplane PCB losses in check, it is built on an advanced high-frequency material consisting of an M9-grade copper clad laminate (CCL) with Quartz glass (Q-glass) reinforcement. The use of these specific materials is so that the dissipation factor (~0.0007) is as low as possible. Dissipation factor is a measure of how much of the signal is lost in the PCB dielectric material. When you have so many layers, it is best to lose as little as possible.  
The sheer size, number of layers, and specialized materials required for the midplane PCB make it an engineering marvel. When deploying this in production, the yield of the PCB and reliability in the field have to be exceptionally high. The obstacles are plenty:  
No de-lamination can occur at any layer across a panel near a square meter.  
Quartz glass is abrasive and hard to drill cleanly; connections between layers (through what are called vias) and drill bit wear become yield limiters.
Since yield compounds per layer, it becomes extremely difficult at 78 layers. A defect anywhere scraps the whole board.
A board-level failure affects the operation of 144 GPUs (in an NVL144 configuration) all at once.
These factors make the engineering marvel hard to build in volume. The reason we examined the underlying engineering is to ground rumors of schedule delays in engineering reality. Yes, building these boards is hard but not impossible. AI PCBs already span tens of layers easily, the midplane PCB takes it to another level.
Confirming or denying the delay outright requires tracking the supply chain and orders closely, which is out of scope here. Additionally, Nvidia has responded saying that their roadmap is intact – so we’ll take their word for it. But, if you are NVIDIA, and your best engineers say that the midplane PCB is hard, what’s the backup plan? The answer is the NVL72x2.  
NVL72x2: Why It Might Have Really Been Cancelled
NVL72x2：它为何可能真的被取消
144 GPUs are difficult to fit into a rack for a couple of reasons:  
They draw a lot more power per rack which would require the use of 800V DC systems to handle the power distribution and copper cable weight within the rack (see earlier detailed post on this below)  
The routing problem as we discussed is complex, and requires an enormous PCB that is hard to make.  
📙 Power Delivery As The Next Physics Wall In AI Datacenters
The logical stopgap solution would be to instead put in 72 GPUs per rack, just like in the Blackwell era, and put in two such parallel racks back-to-back. This solves the scale-up interconnect problem within a rack because you only need to connect 72 GPUs in the rack just like in the Blackwell “Oberon” rack. NVIDIA can simply use existing racks and not have to worry about it. The 144 GPU implementation would then involve putting two such racks together.
The problem now is how to connect the two racks together so that they behave as if they were one rack.
While the Kyber issues were being sorted out, SemiAnalysis stated that NVIDIA considered a back-to-back configuration as shown below. Perhaps this configuration was known to their institutional clients, but a detailed check of my SemiAnalysis newsletter archives shows that this was not mentioned anywhere before – including in their Vera Rubin deep-dive. Perhaps it was not in consideration at the time of writing.
Regardless, this configuration was allegedly disliked by the hyperscalers for its “odd” configuration. This argument I do buy because the data halls are not laid out to accommodate racks in any orientation. There are cable raceways, cooling, and power all laid out to accommodate racks in a particular orientation, and going back-to-back will require changing all the data hall infrastructure. If this was actually suggested by Nvidia as a configuration, no wonder hyperscalers and CSPs pushed back. SemiAnalysis stated in their tweet that this configuration was cancelled.  
However that does not mean the NVL72x2 will never work, or that there aren’t other ways around current challenges.   
In the full Substack post, we discuss:  
How to make the NVL72x2 work  
Why CPO/NPO is the right answer for scaling to larger world size  
Does this really create an opening for AMD and Google?  
READ ON SUBSTACK  
This is how we think about market claims at SemiExponent. If you have a bet you'd like tested this way privately, get in touch.  
8:43 PM · Jul 7, 2026
·
7,258
 Views

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
