---
name: docker-status
description: List running Docker containers and their exposed ports. READ-ONLY audit tool.
metadata:
  openclaw:
    requires:
      bins: ["docker"]
---

# Docker Status (Read-Only)

Use this skill when the user asks to:
- Show running containers
- Check Docker services
- List exposed container ports

## How to invoke

```bash
bash {baseDir}/../../tools/docker_status.sh
```

## Interpreting results

1. List all running containers with their image, uptime, and status
2. Flag any containers with ports exposed to 0.0.0.0 (accessible from any IP)
3. Note containers with privileged flags or host network mode (security risk)

## Safety constraints

- Read-only. Does NOT stop, start, or modify any containers.
