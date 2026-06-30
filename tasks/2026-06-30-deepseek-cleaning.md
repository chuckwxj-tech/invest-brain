# 任务：DeepSeek 清洗层

日期：2026-06-30  
负责人：DeepSeek  
状态：执行中

## 目标

把每日 raw 材料清洗成结构化 JSONL，交给 Claude 写日报。

DeepSeek 是清洗层，不是最终日报写作者。

## 输入

读取：

```text
/srv/cloud-vault/results/YYYY-MM-DD.raw.jsonl
```

参考：

```text
prompts/deepseek_cleaning_prompt.md
```

禁止读取或输出：

```text
/srv/cloud-vault/config/
/srv/cloud-vault/logs/
*.env
API key
PushDeer PushKey
GitHub key
```

## 输出

写入：

```text
/srv/invest-brain/digests/YYYY-MM-DD.clean.jsonl
```

每一行必须是一个合法 JSON 对象。

必填字段：

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
  "themes": ["主题"],
  "tickers": ["只填明确 ticker"],
  "importance": 1,
  "follow_up": "需要跟踪的问题",
  "quality": "high|medium|low",
  "reason_to_keep": "保留理由或噪音原因"
}
```

## 规则

1. 区分 facts 和 opinions。
2. 不写最终日报。
3. 不写 PushDeer 摘要。
4. 不猜 ticker。
5. 不输出 raw 长路径。
6. 不输出 key、token、env、logs、config。
7. 不给买入、卖出、加仓、减仓、调仓建议。
8. `importance` 使用 1 到 5。
9. `source_ref` 控制在 80 字以内。
10. 证据弱时，`quality` 标为 `low`。

## 验收命令

```bash
python3 - <<'PY'
import json
from datetime import date
from pathlib import Path

path = Path("/srv/invest-brain/digests") / f"{date.today().isoformat()}.clean.jsonl"
assert path.exists(), path

required = {
    "id", "date", "source_ref", "source_type", "title", "summary",
    "facts", "opinions", "assumptions", "uncertainties", "entities",
    "themes", "tickers", "importance", "follow_up", "quality",
    "reason_to_keep",
}

count = 0
for idx, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
    if not line.strip():
        continue
    item = json.loads(line)
    missing = required - set(item)
    assert not missing, (idx, missing)
    assert isinstance(item["facts"], list), idx
    assert isinstance(item["opinions"], list), idx
    assert isinstance(item["importance"], int), idx
    assert 1 <= item["importance"] <= 5, idx
    assert len(item["source_ref"]) <= 80, idx
    count += 1

assert count > 0
print(f"OK {count} clean items")
PY
```

验收通过的含义：

```text
Claude 可以只读取 clean.jsonl 写日报，不需要读取 raw inbox。
```
