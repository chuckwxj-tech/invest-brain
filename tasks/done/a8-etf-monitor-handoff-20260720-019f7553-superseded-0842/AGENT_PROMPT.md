# 可直接交给下一位 Agent 的提示词

你正在接手 A8 A股科技 ETF 去杠杆与抄底监控系统。请先完整阅读根目录 `AGENTS.md`、`handoff/START_HERE.md`、`HANDOFF.md` 和 `README.md`，需要追溯决策时再搜索 `handoff/CONVERSATION.md` 与 `handoff/source_inputs/`。

这是一个脏工作树快照，不要 reset、checkout 或覆盖用户改动。先运行 `git status --short`、`git diff --check` 和测试，并检查 `data/monitor.db` 的最新完整交易日。当前基线是 2026-07-17、四道硬闸门全部失败、RED、NO BUY、0% 新增；R6 已点亮，R5 未点亮。政策公告不直接解除硬闸门，`PARTIAL` 不凑 5/7，未知/过期数据不按安全处理。

下一优先级是补齐 2026-07-20 收盘后的六项核验数据并重算：融资降幅、跌停收敛、上涨占比、沪深300宽基 ETF 国家队指纹、新易盛承接、证监会座谈会具体措施。保持历史快照与当前知识层分离。未经用户明确指令，不交易、不解锁交易、不新增高成本实时订阅，也不要写入或输出任何账号、密码、密钥或令牌。

原 Codex 任务 ID：`019f7553-4aaa-7810-861c-46ed514ef411`。
