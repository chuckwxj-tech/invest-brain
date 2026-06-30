# Invest Brain 管线文档

> 最后更新: 2026-06-30
> 状态: 阶段 8 完成 - 清洗链路已上线

---

## 一、整体架构

```
cron (2:22 HKT) @ 腾讯云 Ubuntu 24.04 (111.229.169.245)

  investment_brain.sh
  |
  ├── Step 1: daily_digest.py
  |   扫描 inbox/text-clips/ + tmp/browser-capture-*.md
  |   → results/YYYY-MM-DD.raw.jsonl
  |   → results/YYYY-MM-DD.digest.jsonl
  |   → markdown/daily/YYYY-MM-DD.md (DeepSeek 写日报)
  |
  ├── Step 2: clean_raw_jsonl.py
  |   读取 raw.jsonl → DeepSeek 清洗
  |   → /srv/invest-brain/digests/YYYY-MM-DD.clean.jsonl
  |
  ├── Step 3: sync_from_cloud_vault.sh
  |   rsync 白名单 → /srv/invest-brain/
  |   git commit + git push → GitHub (chuckwxj-tech/invest-brain)
  |
  └── Step 4: make_push_summary.py + send_pushdeer.py
      生成 push/ 摘要 → PushDeer 推送到手机
```

### 关键目录

| 目录 | 用途 | 是否入 Git |
|------|------|------------|
| `/srv/cloud-vault/inbox/text-clips/` | 用户手动存入的 .md 片段 | 否 |
| `/srv/cloud-vault/tmp/browser-capture-*` | 浏览器自动捕获 | 否 |
| `/srv/cloud-vault/results/` | raw.jsonl + digest.jsonl | 是 (results/) |
| `/srv/cloud-vault/markdown/daily/` | DeepSeek 写的日报 | 是 (daily/) |
| `/srv/cloud-vault/markdown/push/` | 推送摘要 | 是 (push/) |
| `/srv/cloud-vault/scripts/` | Python/Bash 脚本 | 否 |
| `/srv/cloud-vault/config/` | invest-brain.env (600) | 否 |
| `/srv/cloud-vault/logs/` | 运行日志 (30天清理) | 否 |
| `/srv/invest-brain/digests/` | 清洗后 clean.jsonl | 是 |
| `/srv/invest-brain/prompts/` | AI 提示词 | 是 |

---

## 二、数据流

```
用户采集材料
  ├── 浏览器插件 → tmp/browser-capture-daily-prompt-*.md
  └── 手动存入 → inbox/text-clips/*.md
                    |
                    v
         daily_digest.py (DeepSeek 增强)
                    |
     ┌──────────────┼──────────────────┐
     v              v                  v
  raw.jsonl    digest.jsonl      日报 .md
  (原始提取)   (结构化摘要)      (DeepSeek 写)
     |              |                  |
     v              |                  |
  clean_raw_jsonl.py|                 |
  (DeepSeek 清洗)   |                  |
     |              |                  |
     v              v                  v
  clean.jsonl   digest.jsonl     daily/*.md
  (29条/53条)   (保留)           push/*.md
     |              |                  |
     └──────────────┴──────────────────┘
                    |
                    v
         sync_from_cloud_vault.sh
           rsync → git commit → git push
```

### 文件格式

| 文件 | 格式 | 内容 |
|------|------|------|
| `raw.jsonl` | JSONL | 原始提取: title, content_head, sha256, mtime |
| `digest.jsonl` | JSONL | DeepSeek 摘要: AI-summary, themes, entities |
| `clean.jsonl` | JSONL | 结构化清洗: facts, opinions, assumptions, uncertainties, importance 1-5 |
| `daily/*.md` | Markdown | 完整日报: 表格 + 主题分类 + 核心摘要 |
| `push/*.md` | Markdown | 简版推送: 去表格/去路径, 手机友好 |

---

## 三、组件详解

### 3.1 daily_digest.py (~570行)

- 路径: `/srv/cloud-vault/scripts/daily_digest.py`
- Python 3, 仅 stdlib
- 模型: DeepSeek Chat, temperature 0.3, timeout 180s
- 调度: cron 每天 2:22 HKT

**去重**: sha256 状态文件 `digest_state.json`
- 首次运行处理所有文件
- 后续只处理 LOOKBACK_DAYS=3 内的新文件
- MIN_BYTES=200 过滤空文件
- YAML frontmatter 自动跳过

**输出 (3个)**:
1. `results/YYYY-MM-DD.raw.jsonl`
2. `results/YYYY-MM-DD.digest.jsonl`
3. `markdown/daily/YYYY-MM-DD.md`

**幂等**: 无新文件时返回 0，不覆盖已有日报

### 3.2 clean_raw_jsonl.py (~370行) - 清洗层

- 路径: `/srv/cloud-vault/scripts/clean_raw_jsonl.py`
- 功能: 读取 raw.jsonl → 分批 DeepSeek 清洗 → 输出 clean.jsonl

**清洗规则 (SYSTEM_PROMPT)**:
1. 去重: 同一材料只保留一条
2. facts (可验证事实) vs opinions (作者/市场观点) 分离
3. 提取 assumptions (隐含假设), uncertainties (不确定性)
4. 标记 entities, themes, tickers
5. importance 1-5 分级
6. 每行合法 JSON, 不输出 Markdown
7. 不编造缺失信息, 不猜 ticker
8. source_ref 控制在 80 字以内

**输出字段**:
```json
{
  "id": "sha256短id",
  "date": "YYYY-MM-DD",
  "source_ref": "短来源引用",
  "source_type": "text_clip|browser_capture|article|xueqiu|x|unknown",
  "title": "材料标题",
  "summary": "100字以内中性摘要",
  "facts": ["可验证事实"],
  "opinions": ["作者/市场观点"],
  "assumptions": ["隐含假设"],
  "uncertainties": ["待验证问题"],
  "entities": ["公司/ETF/行业/人物"],
  "themes": ["HBM", "CPO", "PCB", ...],
  "tickers": ["明确识别的股票代码"],
  "importance": 1-5,
  "follow_up": "需要继续跟踪的问题",
  "quality": "high|medium|low",
  "reason_to_keep": "保留理由或噪音原因"
}
```

**批量策略**:
- MAX_CHARS_PER_BATCH = 40000
- title 截 120 字, content_head 截 3000 字
- MAX_RETRIES = 2

**降级方案**: DeepSeek 不可用 → `local_clean()`
- 只做 sha256 去重 + 关键词主题推断
- 不提取 facts/opinions/assumptions/uncertainties

**输出**: `/srv/invest-brain/digests/YYYY-MM-DD.clean.jsonl` (直接写入 Git 仓库)
- 测试数据: 53 条 raw → 3 批 API → 29 条 clean

### 3.3 investment_brain.sh (~70行)

- 路径: `/srv/cloud-vault/scripts/investment_brain.sh`
- 4 步管线, 每步 `|| true` 容错
- 加载 invest-brain.env 获取 API Key

### 3.4 sync_from_cloud_vault.sh

- 路径: `/srv/invest-brain/scripts/sync_from_cloud_vault.sh`
- 策略: 白名单 rsync, 只搬运产出文件
- 只复制 `.md .jsonl .json .yaml .yml .csv`
- 无变更跳过提交, Push 失败不阻塞

**白名单**:

| 源 (cloud-vault) | 目标 (invest-brain) |
|---|---|
| `markdown/daily/` | `daily/` |
| `markdown/push/` | `push/` |
| `markdown/weekly/` | `weekly/` |
| `results/` | `results/` |
| `markdown/content-collection/` | `topics/` |
| `reports/` | `reports/` |
| `tasks/` | `tasks/` |

### 3.5 PushDeer 推送

| 组件 | 说明 |
|------|------|
| `make_push_summary.py` (~130行) | 从日报提取关键段, 去表格/去路径/去文件名 |
| `send_pushdeer.py` (~80行) | 纯 stdlib, urllib 调用 PushDeer API |

- API: `api2.pushdeer.com`
- MAX_BODY_CHARS: 3000

### 3.6 辅助组件

| 组件 | 说明 |
|------|------|
| `invest-brain.env` (chmod 600) | DEEPSEEK_API_KEY, PUSHDEER_PUSHKEY |
| `cleanup_old_files.sh` | tmp/ 14天, logs/ 30天 |
| `.gitignore` | *.env, *.pyc, *.bak, .DS_Store |

---

## 四、安全边界

### 绝不进入 Git

- `/srv/cloud-vault/inbox/` - 原始采集材料
- `/srv/cloud-vault/tmp/` - 浏览器临时文件
- `/srv/cloud-vault/logs/` - 运行日志
- `/srv/cloud-vault/config/` - API key 等敏感配置
- `/srv/cloud-vault/knowledge/` - 知识库

### 仓库只含

- `daily/` `weekly/` `push/` - 日报/周报/推送
- `digests/` - 清洗后结构化 JSONL
- `results/` - 原始结构化 JSONL
- `topics/` `reports/` `tasks/` - 主题/报告/任务
- `prompts/` - AI 提示词
- `scripts/` - 同步脚本 (不含密钥)

### 密钥管理

- `invest-brain.env` 权限 600, 仅 root 可读
- API Key 通过 `load_env()` 加载, 不在代码中硬编码
- GitHub deploy key 仅授权 invest-brain 单仓库
- PushDeer PushKey 仅存于 .env 文件

---

## 五、Prompt 体系

| Prompt | 位置 | 用途 |
|--------|------|------|
| DeepSeek 日报 Prompt | `daily_digest.py` 内置 | 生成完整日报 |
| DeepSeek 清洗 Prompt | `clean_raw_jsonl.py` SYSTEM_PROMPT | raw → clean |
| Claude 日报写作 Prompt | `prompts/claude_daily_writer_prompt.md` | (预留) Claude 写日报 |

清洗 Prompt 核心约束:
- 只负责去重/提取/结构化, 不写日报
- 不给买卖建议, 不预测价格
- 不输出 API key/env/logs/config
- 宁可少提取, 不要编造

---

## 六、当前状态

### 已完成 (8个阶段)

- [x] daily_digest.py 日报生成 (DeepSeek)
- [x] invest-brain Git 存档仓库 (GitHub: chuckwxj-tech/invest-brain)
- [x] PushDeer 手机推送
- [x] tmp/browser-capture 文件采集修复
- [x] PushDeer 摘要优化 (手机友好)
- [x] 管线稳定性检查 (11 项全部通过)
- [x] DeepSeek 清洗链路 (raw → clean)
- [x] 管线文档 (本文档)

### 待优化

- [ ] 连续 3 天稳定运行观察
- [ ] Claude 暂不在管线内, 日报目前由 DeepSeek 在云端生成
- [ ] prompts/claude_daily_writer_prompt.md 已预留但未启用
- [ ] 清洗质量需积累样本评估

### 架构演进方向 (用户规划中)

```
当前:  腾讯云做全部 (采集 → 清洗 → 日报 → 推送)
目标:  腾讯云做采集+清洗  /  Claude做日报写作  /  PushDeer做推送
```

---

## 七、运维命令

```bash
# 查看 crontab
crontab -l

# 手动触发全链路
bash /srv/cloud-vault/scripts/investment_brain.sh

# 单独跑清洗
python3 /srv/cloud-vault/scripts/clean_raw_jsonl.py 2026-06-30

# 单独 Git 同步
bash /srv/invest-brain/scripts/sync_from_cloud_vault.sh

# 查看日志
tail -100 /srv/cloud-vault/logs/clean-$(date +%F).log
tail -100 /srv/cloud-vault/logs/sync-git-$(date +%F).log

# 查看清洗结果
wc -l /srv/invest-brain/digests/$(date +%F).clean.jsonl

# Git 状态
cd /srv/invest-brain && git log --oneline -5
```
