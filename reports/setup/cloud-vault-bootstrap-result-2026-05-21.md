# cloud-vault-01 Bootstrap Result - 2026-05-21

Generated at: 2026-05-21T16:29:13+08:00

## Scope Executed

- Installed light packages only: sqlite3, python3-venv, ripgrep
- Created durable root: /srv/cloud-vault
- Created symlink: /root/cloud-vault -> /srv/cloud-vault
- Created AGENTS.md and config/global/system_state.json
- Created skeleton repos: content-capture, hermes, cloud-dashboard, sync-tools, article-gateway
- Did not modify SSH configuration
- Did not modify firewall/security group
- Did not start services
- Did not expose dashboard publicly
- Did not install Docker, Chromium, Playwright, OCR, vector database, local model, or GUI

## Package Versions

```
3.45.1 2024-01-30 16:01:20 e876e51a0ed5c5b3126f52e532044363a014bc594cfefa87ffb5b82257ccalt1 (64-bit)
Python 3.12.3
python3-venv: ok
ripgrep 14.1.0

```

## Filesystem Verification

```
lrwxrwxrwx  1 root root   16 May 21 16:28 /root/cloud-vault -> /srv/cloud-vault
drwxr-xr-x 16 root root 4096 May 21 16:28 /srv/cloud-vault
AGENTS.md: ok
system_state.json: ok
repo:content-capture README ok
repo:content-capture PLAN ok
repo:hermes README ok
repo:hermes PLAN ok
repo:cloud-dashboard README ok
repo:cloud-dashboard PLAN ok
repo:sync-tools README ok
repo:sync-tools PLAN ok
repo:article-gateway README ok
repo:article-gateway PLAN ok
```

## Existing Services Left Untouched

```
Netid State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess                                                                           
tcp   LISTEN 0      2048         0.0.0.0:8080       0.0.0.0:*    users:(("python",pid=211555,fd=6))                                               
tcp   LISTEN 0      4096         0.0.0.0:22         0.0.0.0:*    users:(("sshd",pid=52975,fd=3),("systemd",pid=1,fd=194))                         
tcp   LISTEN 0      200        127.0.0.1:5432       0.0.0.0:*    users:(("postgres",pid=56161,fd=6))                                              
tcp   LISTEN 0      511          0.0.0.0:80         0.0.0.0:*    users:(("nginx",pid=73405,fd=5),("nginx",pid=73404,fd=5),("nginx",pid=2516,fd=5))
tcp   LISTEN 0      4096            [::]:22            [::]:*    users:(("sshd",pid=52975,fd=4),("systemd",pid=1,fd=195))                         
```

## Rollback Notes

Only run rollback after explicit confirmation. If no durable content has been added:

```bash
rm -f /root/cloud-vault
rm -rf /srv/cloud-vault
apt-get remove -y sqlite3 ripgrep python3-venv
apt-get autoremove -y
```
