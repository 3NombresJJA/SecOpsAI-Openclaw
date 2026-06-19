---
name: listening-ports
description: List all TCP/UDP ports currently listening on the system with the owning process. READ-ONLY audit tool.
---

# Listening Ports (Read-Only)

Use this skill when the user asks to:
- Show listening ports
- What processes are listening on the network
- Check active network services
- Show sockets

## How to invoke

```bash
bash {baseDir}/../../tools/listening_ports.sh
```

## Interpreting results

1. List all listening ports grouped by TCP/UDP
2. Identify the process and PID associated with each port
3. Flag unexpected services — anything the user did not intentionally configure
4. Cross-reference with the audit_network results when available

## Safety constraints

- Read-only. Does NOT kill processes or modify configuration.
