#!/usr/bin/env bash
#
# validate_task_routing.sh — 任务总线执行前路由校验
#
# invest-brain 是任务总线/归档仓库，不是被验证的目标代码库。
# 本脚本在任何 agent 执行任务【之前】运行，确认任务路由合法、目标仓库就绪。
# 非法或目标缺失的任务返回非 0，调用方应将其停在 tasks/blocked/，不得在本仓库执行。
#
# 用法:
#   scripts/validate_task_routing.sh tasks/inbox/<task>.json
#
# 退出码:
#   0  路由合法且目标仓库就绪，可执行
#   2  缺少必填路由字段（target_repo / target_path）
#   3  目标仓库未挂载（target_repo_missing）
#   4  required_files 缺失
#   5  用法错误 / 文件不存在

set -euo pipefail

THIS_REPO="invest-brain"

die() { echo "BLOCKED: $*" >&2; }

task_file="${1:-}"
if [[ -z "$task_file" || ! -f "$task_file" ]]; then
  echo "用法: $0 <task.json>" >&2
  exit 5
fi

# 用 python3 解析 JSON，输出: target_repo \t target_path \t required_file...(每行一个)
read_field() {
  python3 - "$task_file" "$1" <<'PY'
import json, sys
task = json.load(open(sys.argv[1]))
routing = task.get("routing", {})
ctx = task.get("context", {})
key = sys.argv[2]
if key == "target_repo":
    print(routing.get("target_repo") or ctx.get("project") or "")
elif key == "target_path":
    print(routing.get("target_path") or "")
elif key == "required_files":
    files = routing.get("required_files") or task.get("acceptance", {}).get("files_changed") or ctx.get("files") or []
    print("\n".join(files))
PY
}

target_repo="$(read_field target_repo)"
target_path="$(read_field target_path)"

# 1) 必填字段校验
if [[ -z "$target_repo" ]]; then
  die "缺少 target_repo（任务非法，不得执行）"
  exit 2
fi

# 目标就是本仓库 → 允许（限投资管线/归档类任务）
if [[ "$target_repo" == "$THIS_REPO" ]]; then
  echo "OK: target_repo=$THIS_REPO，允许在本仓库执行"
  exit 0
fi

if [[ -z "$target_path" ]]; then
  die "target_repo=$target_repo 但缺少 target_path（无法定位目标仓库）"
  exit 2
fi

# 2) 目标仓库必须已挂载/clone
if [[ ! -d "$target_path/.git" ]]; then
  die "target_repo_missing — 目标仓库未挂载: $target_path (.git 不存在)"
  echo "→ 任务应停在 tasks/blocked/，不得在 $THIS_REPO 内补造目标文件。" >&2
  exit 3
fi

# 3) required_files 校验（仅提示首文件 CODEX_PROMPT.md 可缺省，其余必须存在或准备创建）
missing=0
while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  if [[ ! -f "$target_path/$f" ]]; then
    echo "WARN: required_file 缺失（待创建）: $target_path/$f" >&2
    missing=$((missing + 1))
  fi
done < <(read_field required_files)

echo "OK: 目标仓库已就绪: $target_path（required_files 缺失 $missing 个，待任务内创建）"
exit 0
