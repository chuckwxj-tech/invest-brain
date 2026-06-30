# 任务总线路由规则

`invest-brain` 是**投资信息管线 / 任务总线 / 文档归档**，不是被修改和验证的目标代码库。
任务总线只负责**分流与记录**，绝不在本仓库内为别的项目补造业务代码。

## 仓库职责边界

```text
invest-brain    = 投资信息管线 / 任务总线 / 文档归档（路由 + 记录）
social-scraper  = 被修改和验证的目标代码库（实际改代码、写测试、提交）
```

## 每个 task 的必填路由字段（硬规则）

任务投递前必须带齐以下字段，缺失即视为非法任务，不得执行：

```yaml
target_repo: social-scraper          # 目标代码库名
target_path: /srv/social-scraper     # 目标仓库挂载路径
required_files:                      # 执行前必须存在或准备创建的文件
  - CODEX_PROMPT.md
  - models.py
  - db.py
```

## 执行前校验

任何 agent 在执行任务**之前**必须先验证目标仓库：

```bash
test -d "$target_path/.git"                  # 目标仓库必须已挂载/clone
test -f "$target_path/CODEX_PROMPT.md" || true
```

参见 `scripts/validate_task_routing.sh`。

## 路由判定

- `target_repo == invest-brain` → 允许在本仓库执行（限投资管线/归档类任务）。
- `target_repo != invest-brain` 且目标仓库未挂载 → 标记 `misrouted`，停在 `tasks/blocked/`，
  `blocked_reason: target_repo_missing`。**不修改 invest-brain 代码来适配目标项目。**
- 目标仓库已挂载且 `required_files` 校验通过 → 任务转投目标仓库后执行。

## 状态目录

```text
tasks/inbox/     新投递、待分流的任务
tasks/blocked/   误投递或目标仓库缺失的任务（不创建 done/ 来假装完成）
```

被 block 的任务 JSON 追加 `routing` 块记录原因，例如：

```json
"routing": {
  "misrouted": true,
  "blocked_reason": "target_repo_missing",
  "target_repo": "social-scraper",
  "target_path": "/srv/social-scraper",
  "required_files": ["CODEX_PROMPT.md"],
  "routed_from": "invest-brain"
}
```

## 给各执行方的约束

- **DeepSeek**：只做任务分流。识别 `target_repo`；若 `!= invest-brain` 标记 `misrouted`，
  输出 `blocked_reason: target_repo_missing`；不修改 invest-brain 代码来适配目标项目。
- **Claude**：不在 invest-brain 中实现目标项目功能。等待目标仓库被挂载；只有进入目标仓库后，
  才允许按任务改代码、写测试、提交。

## 结论

**先修任务路由，不修业务代码。** 目标仓库缺失时，任务只能停在 `blocked/`，
由 invest-brain 记录"任务误投递"与后续路由规则。
