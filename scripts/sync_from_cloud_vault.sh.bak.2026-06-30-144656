#!/usr/bin/env bash
# sync_from_cloud_vault.sh — 选择性同步 cloud-vault 产出到 invest-brain Git 仓库
#
# 白名单策略：只搬运日报/周报/digest/主题卡/报告/任务/决策日志。
# 绝对不碰 inbox、tmp、logs、config、知识库等敏感目录。
# 无变化时不做空提交。

set -euo pipefail

VAULT="/srv/cloud-vault"
REPO="/srv/invest-brain"
TODAY=$(date +%F)
LOG_FILE="/srv/cloud-vault/logs/sync-git-${TODAY}.log"

mkdir -p "$(dirname "$LOG_FILE")"
exec >> "$LOG_FILE" 2>&1

echo "=== Sync Git — $(date) ==="

# ── 确保仓库已初始化 ──
if [ ! -d "$REPO/.git" ]; then
  echo "FATAL: $REPO 不是 Git 仓库"
  exit 1
fi

cd "$REPO"

# ── 定义要同步的目录映射 ──
# 格式: "源相对路径|目标相对路径|说明"
SYNC_SPECS=(
  "markdown/daily|daily|每日日报"
  "markdown/weekly|weekly|每周周报"
  "results|results|结构化 JSONL"
  "markdown/content-collection|topics|主题分类"
  "reports|reports|分析报告"
  "tasks|tasks|任务跟踪"
  "investment_brain/reports|brain-reports|投资脑报告"
  "investment_brain/source-cards|source-cards|主题卡"
  "investment_brain/hypotheses|hypotheses|投资假设"
)

# ── 确保目标目录存在 ──
for spec in "${SYNC_SPECS[@]}"; do
  IFS='|' read -r src_rel dst_rel _desc <<< "$spec"
  mkdir -p "$REPO/$dst_rel"
done

# ── 复制文件（rsync --archive 保留时间戳，只复制新增/变更） ──
COPIED=0
for spec in "${SYNC_SPECS[@]}"; do
  IFS='|' read -r src_rel dst_rel desc <<< "$spec"
  src_path="$VAULT/$src_rel"
  dst_path="$REPO/$dst_rel"

  if [ ! -d "$src_path" ]; then
    echo "skip: $src_rel (源目录不存在)"
    continue
  fi

  # rsync 只复制 .md / .jsonl / .json / .yaml / .yml / .csv 文件
  before=$(find "$dst_path" -type f 2>/dev/null | wc -l)
  rsync -a --prune-empty-dirs \
    --include='*/' \
    --include='*.md' --include='*.jsonl' --include='*.json' \
    --include='*.yaml' --include='*.yml' --include='*.csv' \
    --exclude='*' \
    "$src_path/" "$dst_path/" 2>/dev/null || true
  after=$(find "$dst_path" -type f 2>/dev/null | wc -l)

  delta=$((after - before))
  if [ "$delta" -gt 0 ]; then
    echo "  +$delta $desc ($src_rel → $dst_rel)"
    COPIED=$((COPIED + delta))
  fi
done

echo "共新增/更新 $COPIED 个文件"

# ── 检查是否有变更 ──
if [ -z "$(git status --porcelain)" ]; then
  echo "没有新变更，跳过提交。"
  exit 0
fi

# ── 提交 ──
git add -A
COMMIT_MSG="sync: ${TODAY} daily digest"
if [ "$COPIED" -gt 0 ]; then
  COMMIT_MSG="${COMMIT_MSG} — ${COPIED} files"
fi

echo "--- git status ---"
git status --short
echo "--- commit: $COMMIT_MSG ---"
git commit -m "$COMMIT_MSG"

# ── 推送 ──
echo "--- git push ---"
if git push origin main 2>&1; then
  echo "Push 成功"
else
  echo "WARN: Push 失败，请检查 GitHub 连通性"
  echo "已提交到本地，下次 sync 时会一起推送。"
fi

echo "=== Sync Git — 完成 $(date) ==="
