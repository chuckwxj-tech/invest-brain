# 腾讯云 Agent Handoff 上传回执

- 上传时间：2026-07-20 08:42:24 CST
- Cloud Vault 主机：腾讯云 `111.229.169.245`
- 正式目录：`/srv/cloud-vault/tasks/inbox/a8-etf-monitor-handoff-20260720-019f7553`
- 主归档：`a8-etf-monitor-handoff-20260720-019f7553.tar.gz`
- 归档大小：137,556,200 bytes（约 131 MiB）
- SHA-256：`9adc3113f37085994e45147a2204df88980fe553dd42d98ec110b2da678a83c6`
- 增量归档：`a8-update-20260720-r6-announcement-breadth.tar.gz`
- 增量大小：476,213 bytes
- 增量 SHA-256：`54f03f10cb0af1da0e0990a7503246eb1f1e83a68068b8b1b03098c04d731814`
- 可见对话：27 个回合，见 `CONVERSATION.md`
- 云端校验：归档及 5 份入口/交接文档全部通过；归档可被 Linux `tar` 完整读取。
- 安全审计：不含 `.env`、私钥、令牌、券商账户/订单数据、Git 元数据、虚拟环境、缓存和冗余旧数据库。

接手者先读 `START_HERE.md`，然后验证：

```bash
cd /srv/cloud-vault/tasks/inbox/a8-etf-monitor-handoff-20260720-019f7553
sha256sum -c SHA256SUMS
```

恢复时先解压主归档，再把增量归档解压到同一父目录并覆盖同名文件。增量内容及顺序见 `UPDATE-20260720-R6-ANNOUNCEMENT.md`。
