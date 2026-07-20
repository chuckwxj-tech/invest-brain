# 2026-07-20 R6 公告广度增量更新

这是腾讯云基础 handoff 发布后的增量。接手者应先解压基础包，再把 `a8-update-20260720-r6-announcement-breadth.tar.gz` 解压到同一父目录，允许覆盖同名文件。

## 研究结论

- 中国中车收到集团增持通知、国电南瑞出现董事长回购提议，作为第四级“微观主体动员”加码录入 R6 证据链。
- 第四级加码不增加第二张 R 票，不修改四道硬闸门和仓位规则。
- 新增 `R6-ANNOUNCEMENT-BREADTH`：按日记录上市公司/央企增持回购、公募自购、私募自购和全市场去重合计。
- 必须区分集团通知、董事长提议、董事会批准与已实施；南瑞当前只是最软的提议阶段。
- 2026-07-20 只掌握中车、南瑞两个样本，完整家数待补，因此状态为 `PARTIAL_DATA`，不是“当天只有2家”。
- 公告广度与其波峰衰减只描述托底动员阶段。出清是否结束仍由融资降幅、跌停收敛和新易盛承接裁决。

## 代码与文件

- `config/research-manual.yaml`：R6 新证据、日频软跟踪和座谈会核验结果。
- `src/etf_bottom_monitor/research.py`：读取截至观察日的最新软跟踪，防止未来数据泄漏。
- `src/etf_bottom_monitor/reports/watchlist_report.py`：显示“跟踪中/样本不全”。
- `src/etf_bottom_monitor/dashboard.py`：看板标题与纪律说明改为当前政策及软跟踪。
- `docs/policy-support-announcement-tracker.md`：统计口径和解释纪律。
- `tests/test_research.py`：验证软跟踪不投 R 票且未来观测不泄漏。
- `reports/watchlist-2026-07-17.md`、dashboard artifact/HTML：已刷新展示。
- `handoff/CONVERSATION.md`：重新导出至当前第27个可见回合。

## 验收

- 44 tests passed。
- `git diff --check` 通过。
- HTML 打包 validation/package 通过；因本机没有兼容 Chromium，浏览器级 QA 为 `structural_only`，语义表格和精确 payload 校验通过。
