# Invest Brain 管线文档

> 最后更新：2026-06-30  
> 当前状态：DeepSeek 清洗链路已上线；Claude 日报写作进入 Git 交接验证阶段。

本文档描述 Invest Brain 当前已上线流程、下一步 Claude 接入目标，以及 DeepSeek / Claude 的明确任务边界。

核心分工：

```text
腾讯云      = 采集、抽取、清洗、调度
DeepSeek   = 低成本清洗与结构化提取
GitHub     = 交接层与长期归档
Claude     = 日报、周报、主题复盘写作
PushDeer   = 手机短提醒
```

硬边界：

```text
不自动交易
不自动调仓
不让 AI 直接决定买卖
不让 Claude 读取 raw inbox / logs / config / env
```

---

## 一、整体架构

### 1.1 当前已上线流程

当前 cron 主链路仍在腾讯云服务器上运行。

```text
cron 02:22 Asia/Shanghai
  |
  v
/srv/cloud-vault/scripts/investment_brain.sh
  |
  |-- daily_digest.py
  |     读取：
  |       /srv/cloud-vault/inbox/text-clips/
  |       /srv/cloud-vault/tmp/browser-capture-*.md
  |     输出：
  |       /srv/cloud-vault/results/YYYY-MM-DD.raw.jsonl
  |       /srv/cloud-vault/results/YYYY-MM-DD.digest.jsonl
  |       /srv/cloud-vault/markdown/daily/YYYY-MM-DD.md
  |
  |-- clean_raw_jsonl.py
  |     读取：
  |       /srv/cloud-vault/results/YYYY-MM-DD.raw.jsonl
  |     输出：
  |       /srv/invest-brain/digests/YYYY-MM-DD.clean.jsonl
  |
  |-- make_push_summary.py
  |     读取：
  |       /srv/cloud-vault/markdown/daily/YYYY-MM-DD.md
  |     输出：
  |       /srv/cloud-vault/markdown/push/YYYY-MM-DD.push.md
  |
  |-- sync_from_cloud_vault.sh
  |     白名单同步到：
  |       /srv/invest-brain/
  |     然后：
  |       git commit + git push
  |
  `-- send_pushdeer.py
        推送：
          /srv/cloud-vault/markdown/push/YYYY-MM-DD.push.md
```

当前限制：

```text
DeepSeek 仍会生成 fallback 完整日报。
Claude 还没有进入 cron 自动链路。
PushDeer 当前推送的是 cloud-vault 生成的短摘要。
```

### 1.2 最新目标流程

目标不是让 Claude 读原始材料，而是让 Claude 只读 Git 中的清洗产物。

```text
cron 02:22
  |
  v
DeepSeek 抽取 + 清洗
  |
  v
/srv/invest-brain/digests/YYYY-MM-DD.clean.jsonl
  |
  v
git commit + git push
  |
  v
Claude 手动或定时 worker
  |
  |-- git pull
  |-- 读取 prompts/claude_daily_writer_prompt.md
  |-- 读取 digests/YYYY-MM-DD.clean.jsonl
  |-- 读取最近 7 天 daily/ 作为上下文
  |
  |-- 写 daily/YYYY-MM-DD.md
  |-- 写 push/YYYY-MM-DD.push.md
  |
  `-- git commit + git push
        |
        v
PushDeer 推送 Claude 写出的短摘要
```

目标态原则：

```text
DS 负责把脏材料变干净。
Claude 负责把干净材料写成日报。
Git 是 DS 和 Claude 的唯一交接层。
PushDeer 只推短摘要。
```

---

## 二、目录和数据边界

### 2.1 `/srv/cloud-vault`

这是腾讯云上的私有工作区。

可以包含：

- 原始 text clips
- browser capture 临时文件
- raw JSONL
- 运行日志
- 环境配置
- 脚本状态文件

不要把整个 `/srv/cloud-vault` 变成 Git 仓库。

### 2.2 `/srv/invest-brain`

这是 Git 归档仓库，也是 AI 之间的交接层。

允许入库：

```text
daily/
push/
weekly/
digests/
prompts/
tasks/
topics/
reports/
scripts/
docs/
```

禁止入库：

```text
raw inbox 文件
tmp browser captures
logs
config
.env
API key
PushDeer PushKey
GitHub private key
完整 raw 网页正文
```

### 2.3 DS 到 Claude 的标准交接文件

标准交接文件是：

```text
/srv/invest-brain/digests/YYYY-MM-DD.clean.jsonl
```

这个文件必须足够干净，使 Claude 不需要读取 `/srv/cloud-vault/inbox/`。

---

## 三、组件职责

### 3.1 `daily_digest.py`

路径：

```text
/srv/cloud-vault/scripts/daily_digest.py
```

当前职责：

- 扫描 text clips 和 browser captures
- 按内容 hash 去重
- 生成 `raw.jsonl`
- 生成 `digest.jsonl`
- 生成 DeepSeek 版完整日报，作为 Claude 接入前的 fallback

目标职责：

- 保留为抽取层和 fallback 层
- Claude 稳定后，不再作为主日报写作者

输出：

```text
/srv/cloud-vault/results/YYYY-MM-DD.raw.jsonl
/srv/cloud-vault/results/YYYY-MM-DD.digest.jsonl
/srv/cloud-vault/markdown/daily/YYYY-MM-DD.md
```

### 3.2 `clean_raw_jsonl.py`

路径：

```text
/srv/cloud-vault/scripts/clean_raw_jsonl.py
```

职责：

- 读取 `raw.jsonl`
- 调用 DeepSeek 做结构化清洗
- 分离事实、观点、假设、不确定性
- 提取主题、实体、ticker、重要性、待跟踪问题
- 直接写入 Git 仓库的 `digests/`

输出：

```text
/srv/invest-brain/digests/YYYY-MM-DD.clean.jsonl
```

字段要求：

```json
{
  "id": "稳定短 id",
  "date": "YYYY-MM-DD",
  "source_ref": "短来源引用",
  "source_type": "text_clip|browser_capture|article|xueqiu|x|unknown",
  "title": "短标题",
  "summary": "100 字以内中性摘要",
  "facts": ["可验证事实"],
  "opinions": ["作者或市场观点"],
  "assumptions": ["隐含假设"],
  "uncertainties": ["证据缺口或不确定性"],
  "entities": ["公司、ETF、行业、机构"],
  "themes": ["HBM", "CPO", "PCB"],
  "tickers": ["只填明确识别的 ticker"],
  "importance": 1,
  "follow_up": "需要跟踪的问题",
  "quality": "high|medium|low",
  "reason_to_keep": "保留理由或噪音原因"
}
```

### 3.3 Claude 日报写作层

状态：

```text
尚未自动化。
先手动跑 3 天，通过 Git 交接验证质量。
```

Prompt：

```text
prompts/claude_daily_writer_prompt.md
```

允许读取：

```text
digests/YYYY-MM-DD.clean.jsonl
daily/ 最近 7 天日报
themes/ 已有主题卡
tasks/ 未完成任务
```

禁止读取：

```text
/srv/cloud-vault/inbox/
/srv/cloud-vault/tmp/
/srv/cloud-vault/logs/
/srv/cloud-vault/config/
*.env
```

输出：

```text
daily/YYYY-MM-DD.md
push/YYYY-MM-DD.push.md
```

Claude 必须做到：

- 写最终可读日报
- 写手机友好的 PushDeer 短摘要
- 明确区分事实、观点、假设、不确定性
- 不使用买入、卖出、加仓、减仓、调仓等操作语言
- 保留后续 weekly / themes / tasks 可复用的问题

### 3.4 `sync_from_cloud_vault.sh`

路径：

```text
/srv/invest-brain/scripts/sync_from_cloud_vault.sh
```

职责：

- 只同步 `/srv/cloud-vault` 中的白名单产物
- 不同步 inbox、tmp、logs、config、key
- 有变化才 commit
- remote 存在时 push

当前同步目标：

```text
daily/
push/
weekly/
digests/
results/
topics/
reports/
tasks/
```

后续注意：

```text
Claude 成为主日报写作者后，sync 不能再用 DeepSeek fallback 日报覆盖 Claude 写出的 daily/push。
```

### 3.5 PushDeer

PushDeer 只负责通知。

当前输入：

```text
/srv/cloud-vault/markdown/push/YYYY-MM-DD.push.md
```

Claude 接入后的目标输入：

```text
/srv/invest-brain/push/YYYY-MM-DD.push.md
```

短摘要要求：

- 控制在 2500 到 3000 字以内
- 不含 Markdown 表格
- 不含长文件名
- 不含 raw 路径
- 不含 browser-capture / text-clip 长引用
- 不含交易指令

---

## 四、Prompt 和任务体系

| 文件 | 负责人 | 作用 |
|---|---|---|
| `prompts/deepseek_cleaning_prompt.md` | DeepSeek | raw/digest 到 clean JSONL |
| `prompts/claude_daily_writer_prompt.md` | Claude | clean JSONL 到 daily/push |
| `tasks/2026-06-30-deepseek-cleaning.md` | DeepSeek | 当前清洗任务单 |
| `tasks/2026-06-30-claude-daily-writing.md` | Claude | 当前日报写作任务单 |

使用规则：

```text
prompts/ 定义长期行为。
tasks/ 定义当前要执行的任务。
scripts/ 定义自动化。
```

---

## 五、当前状态

### 5.1 已完成

- DeepSeek daily extraction 管线已运行。
- DeepSeek cleaning 层已存在，并写入 clean JSONL。
- GitHub 仓库已建立：`chuckwxj-tech/invest-brain`。
- PushDeer 已可用。
- Push 摘要已优化为手机友好。
- `prompts/deepseek_cleaning_prompt.md` 已入库。
- `prompts/claude_daily_writer_prompt.md` 已入库。
- 管线文档已入库。

### 5.2 正在推进

- 将 DeepSeek 输出定位为“清洗产物”，不再作为最终日报目标态。
- Claude 先通过 Git 手动写日报。
- 手动稳定 3 天后，再考虑 Claude API / cron 自动化。
- PushDeer 后续改为推 Claude 写出的 `push/YYYY-MM-DD.push.md`。

### 5.3 尚未开始

- Claude daily writer 自动化 cron。
- weekly 周报。
- themes 主题卡。
- tasks 研究任务生成。
- 量化仓库交接。

### 5.4 明确不做

- Docker
- 本地大模型
- 向量数据库
- Elasticsearch
- Telegram
- 自动交易
- 自动调仓

---

## 六、上线节奏

### Phase A：稳定 DS 清洗

目标：

```text
每天都有合法的 digests/YYYY-MM-DD.clean.jsonl。
```

验收：

- 文件存在
- 每行都是合法 JSON
- 不含 API key / PushKey
- 不含 raw 长路径
- 不含交易指令
- 重点条目有 facts / opinions / uncertainties

### Phase B：Claude 手动写日报

目标：

```text
Claude 连续 3 天从 Git 读取 clean.jsonl，并写出 daily/push。
```

验收：

- `daily/YYYY-MM-DD.md` 存在
- `push/YYYY-MM-DD.push.md` 存在
- push 摘要手机友好
- 日报区分事实和观点
- 不含买卖操作语言
- Git commit 存在

### Phase C：Claude 自动化

目标：

```text
手动质量稳定后，再加入定时 Claude writer。
```

建议调度：

```text
02:22 DS 抽取 + 清洗
03:05 Claude 写 daily/push
03:10 PushDeer 推 Claude push 摘要
```

失败规则：

```text
Claude 失败不能影响 DS 清洗和 Git 同步。
```

### Phase D：weekly / themes

只有 Claude daily 稳定后再做。

weekly：

```text
weekly/YYYY-Www.md
```

themes：

```text
themes/hbm.md
themes/cpo.md
themes/pcb.md
themes/glass-substrate.md
themes/a-share-etf.md
themes/commercial-space.md
```

---

## 七、安全边界

### 7.1 Claude 安全边界

Claude 只能读取 Git 仓库内的整理产物。

允许：

```text
digests/
daily/
push/
weekly/
themes/
tasks/
prompts/
docs/
```

禁止：

```text
/srv/cloud-vault/inbox/
/srv/cloud-vault/tmp/
/srv/cloud-vault/logs/
/srv/cloud-vault/config/
*.env
```

### 7.2 DeepSeek 安全边界

DeepSeek 可以处理 raw 内容，但输出必须脱敏、压缩、结构化。

禁止输出：

```text
API key
PushDeer PushKey
GitHub key
完整 raw 文件路径
大段 raw 原文
交易指令
```

---

## 八、运维命令

```bash
# 拉取最新仓库
cd /srv/invest-brain
git pull --ff-only origin main

# 手动触发云端全链路
bash /srv/cloud-vault/scripts/investment_brain.sh

# 单独跑 DS 清洗
python3 /srv/cloud-vault/scripts/clean_raw_jsonl.py "$(date +%F)"

# 检查今日文件
ls -lah /srv/invest-brain/digests/"$(date +%F)".clean.jsonl
ls -lah /srv/invest-brain/daily/"$(date +%F)".md 2>/dev/null || true
ls -lah /srv/invest-brain/push/"$(date +%F)".push.md 2>/dev/null || true

# Git 状态
cd /srv/invest-brain
git status -sb
git log --oneline -5

# 查看日志
tail -100 /srv/cloud-vault/logs/clean-"$(date +%F)".log
tail -100 /srv/cloud-vault/logs/sync-git-"$(date +%F)".log
```

JSONL 逐行校验：

```bash
python3 - <<'PY'
import json
from datetime import date
from pathlib import Path

path = Path("/srv/invest-brain/digests") / f"{date.today().isoformat()}.clean.jsonl"
bad = []

for idx, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
    if not line.strip():
        continue
    try:
        json.loads(line)
    except Exception as exc:
        bad.append((idx, str(exc)))

if bad:
    print("BAD", bad[:10])
    raise SystemExit(1)

print("OK")
PY
```

---

## 九、决策记录

### 2026-06-30

- DeepSeek 继续作为清洗引擎。
- Claude 作为最终日报写作者，但先手动 Git 验证。
- Git 是 DeepSeek 和 Claude 的唯一交接层。
- Claude 不读取 raw inbox、tmp、logs、config、env。
- PushDeer 只推短摘要。
