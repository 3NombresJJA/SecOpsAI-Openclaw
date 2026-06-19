---
name: security-updates
description: List available system security updates and upgradable packages. READ-ONLY audit tool.
metadata:
  openclaw:
    requires:
      bins: ["apt"]
---

# Security Updates (Read-Only)

Use this skill when the user asks to:
- Check for updates
- Show available security patches
- List upgradable packages

## How to invoke

```bash
bash {baseDir}/../../tools/security_updates.sh
```

## Interpreting results

1. Count total upgradable packages
2. Highlight any security-related packages (packages with "security" in their source)
3. If critical packages like `openssl`, `linux-image`, or `openssh-server` have updates, flag them prominently
4. Suggest running the update (which will require explicit user approval as a write operation)

## Safety constraints

- Read-only. Only checks for available updates. Does NOT install, upgrade, or modify any packages.
