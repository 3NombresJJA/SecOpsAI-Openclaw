---
name: auth-logs
description: Review recent authentication events and failed login attempts from system logs. READ-ONLY audit tool.
---

# Auth Logs (Read-Only)

Use this skill when the user asks to:
- Check failed logins
- Review authentication logs
- Detect brute force attempts
- Show who logged in recently

## How to invoke

```bash
bash {baseDir}/../../tools/failed_logins.sh
```

## Interpreting results

1. Count failed login attempts per source IP
2. Identify repeated failures from the same IP (possible brute force)
3. Note any successful logins from unexpected IPs or at unusual times
4. Flag invalid user attempts (usernames that don't exist on the system)
5. If more than 10 failures from a single IP are detected, suggest blocking that IP with ufw (which will require user approval)

## Safety constraints

- Read-only. Only reads log files. Does NOT modify logs, block IPs, or change SSH configuration.
