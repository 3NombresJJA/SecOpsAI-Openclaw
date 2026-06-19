---
name: firewall-status
description: Display current UFW firewall configuration, active rules, and firewall state. READ-ONLY audit tool.
---

# Firewall Status (Read-Only)

Use this skill when the user asks to:
- Check the firewall
- Show firewall rules
- Verify if UFW is enabled
- Display current firewall configuration

## What this skill does

Reads and displays the current UFW firewall status and rules. This is **read-only** — it never adds, removes, or modifies firewall rules.

## How to invoke

Use the `exec` tool to run:

```bash
bash {baseDir}/../../tools/firewall_status.sh
```

## Interpreting results

After running, analyze and report:

1. Whether the firewall is **active** or **inactive**
2. Default incoming/outgoing policies
3. List all currently active rules
4. Flag any concerning rules, such as:
   - Allow rules on dangerous ports (21, 23, 135, 445)
   - Overly permissive rules (e.g., allowing all incoming on any port)
   - Missing rules for expected services
5. If the firewall is **inactive**, alert the user prominently — this is a critical security issue

## Example output

```
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)

     To                         Action      From
--   --                         ------      ----
22/tcp                         ALLOW IN    Anywhere
80/tcp                         ALLOW IN    Anywhere
```

## Safety constraints

- Only reads firewall configuration
- Does NOT add, delete, or modify any rules
- Does NOT enable or disable UFW
