---
name: audit-network
description: Scan local VM ports and services using nmap to identify open ports and service versions. READ-ONLY audit tool.
metadata:
  openclaw:
    requires:
      bins: ["nmap"]
---

# Audit Network (Read-Only)

Use this skill when the user asks to:
- Audit the network
- Scan ports
- Run `/audit_network`
- Check what services are exposed
- Identify open ports on the VM

## What this skill does

Runs a non-intrusive nmap service version scan against localhost only. This is **read-only** — it never modifies firewall rules or system configuration.

## How to invoke

Use the `exec` tool to run:

```bash
bash {baseDir}/../../tools/audit_network.sh
```

## Interpreting results

After running the scan, analyze the output and:

1. List all open ports found
2. Identify the service and version running on each port
3. Flag any potentially risky services, such as:
   - Port 21 (FTP) — especially if anonymous login is enabled
   - Port 23 (Telnet) — cleartext protocol
   - Port 3306 (MySQL) — exposed database
   - Port 6379 (Redis) — often unauthenticated by default
   - Any service with an outdated or vulnerable version banner
4. Summarize the findings in plain language
5. For each risky finding, ask the user if they want a remediation applied (that will require a separate approval step)

## Example output

```
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.9p1
80/tcp   open  http    Apache httpd 2.4.52
3306/tcp open  mysql   MySQL 8.0.32
```

## Safety constraints

- Only scans localhost (127.0.0.1)
- Does NOT modify any configuration
- Does NOT exploit any found vulnerabilities
- Does NOT scan external IPs or the broader network without explicit user request
