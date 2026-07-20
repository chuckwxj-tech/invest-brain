# A8 监控系统 Agent 交接入口

> 基础包冻结时间：2026-07-20（Asia/Shanghai）；同日追加 R6 公告广度增量包  
> 原 Codex 任务：`019f7553-4aaa-7810-861c-46ed514ef411`  
> 腾讯云交接目录：`/srv/cloud-vault/tasks/inbox/a8-etf-monitor-handoff-20260720-019f7553`

## 1. 接手后按这个顺序阅读

1. `AGENTS.md`：工作区安全、Futu 行情额度与交易边界。
2. `HANDOFF.md`：系统现状、规则、数据口径、已知问题和待办。
3. `README.md`：安装、命令、部署和日常运行方法。
4. `handoff/CONVERSATION.md`：原任务 26 个可见对话回合，按时间顺序导出。
5. `handoff/source_inputs/`：用户提供的原始规格、PDF、Word、研究 ZIP 和新闻简报。
6. `UPDATE-20260720-R6-ANNOUNCEMENT.md`：基础包发布后的第四级政策加码与公告广度跟踪更新。

若只是快速恢复工作，先读前两份；若要理解某项规则为什么这样定，再搜索完整对话与原始研究材料。

## 2. 当前结论，不得因交接而放宽

- 最新完整行情日：2026-07-17；数据库未用 2026-07-20 未收盘数据覆盖历史快照。
- 执行层：四道市场硬闸门 4/4 失败，状态 `RED`，新增仓位上限 0%，结论仍是 **NO BUY**。
- 研究层：保留“牛市中途深调候选”，但 `PARTIAL` 不计入 5/7 放行门槛。
- 周末信息层：R6 政策托底已点亮；R5 仍未点亮。公告提高闸门翻转概率，但不直接解锁开仓。
- 7月20日信息层：微观主体动员按第四级加码录入；新增 `R6-ANNOUNCEMENT-BREADTH` 日频软跟踪。它不增加R票、不改闸门、不改仓位；首日全市场家数尚未扫全，状态为 `PARTIAL_DATA`。
- 2026-07-20 收盘后需核验六项：融资降幅、跌停收敛、上涨占比、宽基 ETF 国家队指纹、新易盛承接、证监会座谈会具体措施。
- 最近一次宽基比较的研究顺序为：闸门翻转后优先比较 **中证500 > 中证1000 > 双创50**；这是候选排序，不是当前买入指令。
- 不自动交易、不调用交易解锁、不读取或打包券商账户信息。

## 3. 包内内容

- 当前未提交工作树中的源代码、配置、测试、部署脚本、文档和报告。
- `data/monitor.db`：约 631 MB 的公开市场行情/指标数据库，不含券商账户、持仓和订单数据。
- `handoff/CONVERSATION.md`：完整的用户可见对话记录；不包含模型内部推理、工具调用细节或密钥。
- `handoff/source_inputs/`：7 份原始输入，保留原格式并统一编号。
- `handoff/FILE_LIST.txt`：归档内文件清单。
- `SHA256SUMS`：归档校验值，位于腾讯云交接目录外层。

为避免泄密或无效膨胀，包内明确排除了 `.env`、`.git`、`.venv`、私钥、令牌、缓存、`__pycache__`、交易审计日志、空数据库、SQLite WAL/SHM，以及约 628 MB 的旧复权前备份数据库。

## 4. 在另一台 Linux/macOS 机器恢复

```bash
tar -xzf a8-etf-monitor-handoff-20260720-019f7553.tar.gz
cd a8-etf-monitor-handoff-20260720-019f7553
python3 -m venv .venv
.venv/bin/python -m pip install -e '.[dev]'
.venv/bin/python -m pytest -q
```

如需 Futu 或其他数据源，再按目标机器能力安装对应可选依赖，例如 `.[futu]`、`.[akshare]` 或 `.[all]`。不要复制原机器 `.env`；按 `.env.example` 在目标机本地新建并保管。Linux 上的 OpenD 地址、推送通道和调度配置需要重新确认。

常用只读命令：

```bash
.venv/bin/python -m etf_bottom_monitor watchlist --date 2026-07-17
.venv/bin/python -m etf_bottom_monitor dashboard --date 2026-07-17
.venv/bin/python -m etf_bottom_monitor run-daily
```

运行 `run-daily` 前必须先阅读 `AGENTS.md` 与 README 中的历史额度确认规则。新增订阅前必须查询 Futu 订阅占用；未经用户明确授权，不运行会改变订单状态的脚本。

## 5. 交接验收基线

- 基础包测试：43 passed；R6 公告广度增量更新后：44 passed。
- `git diff --check` 应无空白错误。
- 看板：`reports/dashboard-2026-07-17.html`，自包含，可直接打开。
- 关键日报：`reports/watchlist-2026-07-17.md` 与 `reports/2026-07-17.md`。
- 数据质量与规则验收的完整清单见 `HANDOFF.md` 第 17 节。

## 6. 给接手 Agent 的第一条任务

先验证归档哈希、跑测试、读取数据最新日期；不要重置脏工作树。随后按 2026-07-20 收盘核验清单补数据并重算，但必须保持“历史快照”和“当前知识层”分离，任何未知或过期数据不得按安全处理。
