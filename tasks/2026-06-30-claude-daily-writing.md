# 任务：Claude 日报写作

日期：2026-06-30  
负责人：Claude  
状态：先手动验证

## 目标

基于 DeepSeek 清洗后的 Git 产物，写最终投资日报和 PushDeer 短摘要。

Claude 是写作者和综合者，不是 raw 数据清洗者。

## 输入

允许读取：

```text
prompts/claude_daily_writer_prompt.md
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
API key
PushDeer PushKey
GitHub key
```

## 输出

写入：

```text
daily/YYYY-MM-DD.md
push/YYYY-MM-DD.push.md
```

## 完整日报要求

日报必须包含：

```text
1. 今日概览
2. 今日最重要的 5 条信息
3. 主题分类
4. 高频实体
5. 待验证问题
6. 噪音和低价值材料
7. 一句话结论
```

日报必须明确区分：

- 事实
- 观点
- 假设
- 不确定性
- 后续跟踪问题

## PushDeer 摘要要求

Push 摘要必须：

- 控制在 2500 字以内
- 不使用 Markdown 表格
- 不包含长文件名
- 不包含 raw 路径
- 不包含 browser-capture 或 text-clip 长引用
- 不包含买入、卖出、加仓、减仓、调仓等操作语言

建议结构：

```markdown
投资日报 YYYY-MM-DD 已生成

概览：
- 有效材料：
- 重点主题：
- 高优先级信号：

今日重点：
1. ...
2. ...
3. ...

待跟踪：
- ...

一句话结论：
...
```

## Git 工作流

手动验证阶段：

```bash
cd /srv/invest-brain
git pull --ff-only origin main

# Claude 写入：
# daily/YYYY-MM-DD.md
# push/YYYY-MM-DD.push.md

git add daily/YYYY-MM-DD.md push/YYYY-MM-DD.push.md
git commit -m "daily: Claude report YYYY-MM-DD"
git push origin main
```

## 验收命令

```bash
TODAY="$(date +%F)"

test -s "digests/$TODAY.clean.jsonl"
test -s "daily/$TODAY.md"
test -s "push/$TODAY.push.md"

! grep -E "browser-capture|text-clip-|/srv/cloud-vault/inbox|/srv/cloud-vault/tmp" "push/$TODAY.push.md"
! grep -E "买入|卖出|加仓|减仓|调仓" "daily/$TODAY.md" "push/$TODAY.push.md"

wc -c "push/$TODAY.push.md"
git status -sb
```

## 上线规则

先手动跑 3 天。

只有输出质量稳定后，才接 Claude API 或 cron 自动化。
