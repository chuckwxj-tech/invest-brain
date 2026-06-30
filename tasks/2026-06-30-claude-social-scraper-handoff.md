# 任务：Claude 接管 social-scraper 旧任务

日期：2026-06-30  
负责人：Claude Code / cc-win  
状态：待执行

## 背景

`invest-brain` 仓库中有 4 个旧任务仍在 `tasks/inbox/`。这些任务的真实目标项目是 `social-scraper`，不是 `invest-brain`。

根因是任务 JSON 之前使用了：

```json
"target": "any"
```

导致任务可能被错误 agent 在错误仓库领取。

现在这些任务已改为：

```json
"target": "cc-win"
```

并补充：

```json
"target_path": "/srv/cloud-vault/projects/social-scraper"
```

## 目标

Claude 需要进入真实目标项目执行任务：

```text
/srv/cloud-vault/projects/social-scraper
```

不要在以下仓库中实现 `social-scraper` 功能：

```text
/srv/invest-brain
```

## 目标项目现状

已确认目标路径存在：

```text
/srv/cloud-vault/projects/social-scraper
```

并包含：

```text
CODEX_PROMPT.md
models.py
db.py
```

但该项目 Git 状态需要先整理：

```text
No commits yet on master
大量文件已 staged
task_bus/ 未跟踪
root 访问时会触发 dubious ownership
```

## Claude 执行顺序

### Step 1：进入目标项目

```bash
cd /srv/cloud-vault/projects/social-scraper
```

如果遇到 dubious ownership，不要改文件内容，先用单次命令检查：

```bash
git -c safe.directory=/srv/cloud-vault/projects/social-scraper status -sb
```

如需长期修复，再明确执行：

```bash
git config --global --add safe.directory /srv/cloud-vault/projects/social-scraper
```

### Step 2：整理 Git 初始状态

先确认：

```bash
git -c safe.directory=/srv/cloud-vault/projects/social-scraper status -sb
git -c safe.directory=/srv/cloud-vault/projects/social-scraper remote -v
```

如果没有初始 commit，先不要执行业务任务。先向用户确认是否创建初始 commit。

建议初始 commit 范围：

```text
项目源码
tests/
CODEX_PROMPT.md
README.md
pyproject.toml
.env.example
.gitignore
```

不要提交：

```text
.env
data/
screenshots/
logs/
runtime files
真实 token/key
```

### Step 3：按依赖顺序处理 4 个任务

任务顺序：

1. `task-2026-05-22-001`
   - 读取 `CODEX_PROMPT.md`
   - 写中文摘要到对应 results 目录

2. `task-20260522-074248-7eacf05d`
   - 数据层：`models.py` + `db.py`
   - 验收：frozen dataclass、SQLite schema、CRUD、pytest

3. `task-20260522-074249-11906e35`
   - 业务逻辑层
   - 依赖数据层完成

4. `task-20260522-074249-d4efcdfb`
   - 编排层：CLI + 定时 + 监控
   - 依赖业务逻辑层完成

## 验收规则

每完成一个任务，必须：

1. 在 `social-scraper` 中运行相关测试。
2. 明确列出修改文件。
3. 不改无关文件。
4. 不把任务 JSON 标成 done，除非对应任务实际完成且结果文件存在。
5. 不在 `invest-brain` 中创建 `models.py`、`db.py`、`CODEX_PROMPT.md`。

## 成功标准

Claude 完成后应汇报：

```text
目标项目路径：
Git 初始状态：
执行的任务 ID：
修改文件：
测试命令：
测试结果：
是否移动任务到 done：
阻塞点：
```

## 当前优先级

先做 Git 状态整理和任务 1。

不要一次性把 4 个任务全做完，除非每一步测试都通过。
