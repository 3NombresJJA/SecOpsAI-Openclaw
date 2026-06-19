---
name: iptables-status
description: Display current iptables packet filtering rules with counters and statistics. READ-ONLY audit tool.
---

# IPTables Status (Read-Only)

Use this skill when the user asks to:
- Show iptables rules
- Check packet filtering configuration
- Review traffic counters
- Display kernel firewall rules

## What this skill does

Reads and displays the current iptables rule chains with counters and verbose output. This is **read-only** — it never modifies, adds, or deletes any rules.

## How to invoke

Use the `exec` tool to run:

```bash
bash {baseDir}/../../tools/iptables_status.sh
```

## Interpreting results

After running, analyze and report:

1. State of the INPUT, OUTPUT, and FORWARD chains and their default policies
2. Any custom chains defined
3. Rules that allow or deny traffic and on which interfaces
4. Byte/packet counters to identify high-traffic rules
5. Flag concerning configurations:
   - Default ACCEPT policy on INPUT (permissive — everything allowed unless explicitly blocked)
   - FORWARD chain in ACCEPT (VM acting as a router without explicit intent)
   - Rules with very high counters that may indicate unusual traffic

## Example output

```
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target  prot opt in  out  source    destination
  234  18KB ACCEPT  all  --  lo  any  anywhere  anywhere
```

## Safety constraints

- Only reads iptables configuration
- Does NOT add, flush, or modify any rules
- Does NOT change chain policies
