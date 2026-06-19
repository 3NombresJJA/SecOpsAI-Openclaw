---
name: system-info
description: Display system information including hostname, kernel version, uptime, disk usage, and memory usage. READ-ONLY.
---

# System Info (Read-Only)

Use this skill when the user asks to:
- Show system information
- Check uptime
- View disk or memory usage
- Get hostname or kernel details

## How to invoke

```bash
bash {baseDir}/../../tools/system_info.sh
```

## Interpreting results

Summarize: hostname, OS, kernel, uptime, disk usage (flag if >80% full), memory usage (flag if >85% used).

## Safety constraints

- Read-only. Does NOT modify any system settings.
