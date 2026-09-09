---
id: 5067b5c8-54d7-4a72-b1eb-ca6fead5c74b
capture_type: selection
url: "https://x.com/home"
canonical_url: ""
title: "Selection from: (5) Home / X"
source_domain: x.com
author: ""
published_at: ""
captured_at: 2026-09-09T01:05:20.716253+00:00
storage_date: 2026-09-09
content_hash: e766d8d701d7edb073677dd324beffd2d95bf452a1fbcdd16a2df145b760072c
tags:
  - none
priority: normal
research_intent: ""
user_notes: ""
dedup_status: fuzzy_warn
status: raw_captured
---

# Selection from: (5) Home / X

## 用户备注

_无备注_

## 原文

GPT-6 Astra + Blender + Seedance2.5 应该是目前AI视频在复杂运镜或多人走位等场景下的终极解决方案了。

在 Blender 里用最粗糙的灰模（方块、圆柱 + 一个 Mixamo 人偶）搭出场景，K 好相机关键帧，渲染成一段 MP4。
这段白模视频就是骨架：机位路径、人物走位、遮挡关系、空间结构全部锁死。把它作为参考视频喂给 Seedance 2.5（全能参考模式），附上角色图 + 风格图，AI 只负责换皮——上材质、打光、渲染角色，运镜跟着白模走，抽卡率大幅下降。

成本：白模阶段 0 元。Blender 5.2 免费开源，Mixamo 免费动作库，一个下午上手，当然做好也有一点学习成本。

真正花钱的是生成费：

A 白模→Seedance 2.5（即梦/火山/fal）：30 秒 720P 即梦约 780 积分，折合 63–84 元/条；fal 约 13.9 美元/条 。

B Blockout 开源预演工具→ Seedance：工具 0 元（建议捐 30），生成费同上

C真人实拍→Kling3.0MotionControl：每天66免费积分，5秒片约10积分，订阅10/月；适合单人动作迁移 

D 本地 Wan 2.2 VACE（ComfyUI）：生成 0 元，但要 24GB 显卡 + 自己搭工作流，控制精度最高 

E 一体化预演平台（如 updream）：一张图自动转 3D 白模，不用学 Blender，平台积分

零成本实操 4 步：
1、Blender 加地面 + 人偶，时间轴设 120 帧 = 5 秒 
2、相机第 1 帧放远、第 120 帧推进，各 K 一个关键帧（运镜免费，随便改） 
3、Workbench 引擎渲 1280×720 MP4（FFmpeg/H.264 输出） 
4、 即梦 Seedance 2.5 全能参考：白模视频 + 角色图 + 风格图，提示词写明"哪个灰块代表什么" + "不要保留灰模质感"

注意点：白模越粗糙越好，细节多反而迷惑模型；
最贵的是生成费，先 480P 抽卡定方向、再 720P 出片，超过 5–8 秒的运镜先拆段。

## 待分析问题

- 这条信息对应哪个产业链环节？
- 是否影响 A股/港股/美股/台股 映射？
- 是否有新增催化剂？
- 是否需要加入日报/周报？
