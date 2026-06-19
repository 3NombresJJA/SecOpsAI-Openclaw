# TOOLS.md - SecOps AI Environment Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

## Related

- [Agent workspace](/concepts/agent-workspace)


Skills define *how* tools work. This file documents *your specific setup* — paths, constraints, and environment details that are unique to this SecOps AI deployment.

## Shell Scripts Location

All read-only security tools are in:
```
~/secops-ai/tools/
```

| Script | Purpose |
|--------|---------|
| `audit_network.sh` | nmap scan of localhost |
| `firewall_status.sh` | UFW status and rules |
| `iptables_status.sh` | iptables filter/NAT rules |
| `listening_ports.sh` | ss -tulnp active sockets |
| `failed_logins.sh` | grep Failed password from auth.log |
| `system_info.sh` | hostnamectl, uname, uptime, df, free |
| `docker_status.sh` | docker ps listing |
| `security_updates.sh` | apt list --upgradable |

## Execution Notes

- All scripts require `bash`
- `audit_network.sh` requires `nmap` (`sudo apt install nmap`)
- `failed_logins.sh` and `iptables_status.sh` may need `sudo` on some systems
- Scripts produce timestamped output with a READ-ONLY footer

## Security Boundary

**Phase 3 (current):** Read-Only tools only. The agent MUST NOT run any command that modifies system state without explicit user approval through OpenClaw's approval mechanism.

Write operations (Phase 4, not yet implemented):
- `ufw deny <port>` — requires approval
- `ufw enable` — requires approval
- `iptables -A` or `-D` — requires approval
- `systemctl stop <service>` — requires approval

## Ollama / LLM

- Provider: Ollama (local)
- Model: qwen2.5:3b
- Socket: http://localhost:11434

## VM Hardware Context

Per project spec (Universidad del Cauca):
- RAM: 16 GB total
- Model uses ~3-4 GB RAM (qwen2.5:3b)
- vCPUs: 8
- Disk: 30 GB
