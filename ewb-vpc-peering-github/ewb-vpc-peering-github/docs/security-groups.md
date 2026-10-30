# Security groups

Create the following security groups in the corresponding VPC. Security groups are stateful, so response traffic for permitted connections is allowed automatically.

| Security group | VPC | Inbound type | Source |
|---|---|---|---|
| `ewb-sg-bastion` | A | SSH / TCP 22 | Your current public IPv4 `/32` |
| `ewb-sg-app-a` | A | SSH / TCP 22 | `10.10.1.10/32` |
| `ewb-sg-app-a` | A | ICMPv4 Echo request | `10.20.1.10/32` |
| `ewb-sg-app-b` | B | SSH / TCP 22 | `10.10.1.10/32` |
| `ewb-sg-app-b` | B | ICMPv4 Echo request | `10.10.2.10/32` |

For ICMP Echo request, select ICMP type 8 and code 0 if the console requests them.

## Important distinctions

- SSH uses destination port TCP 22.
- The source field contains the allowed client IP/CIDR. Do not enter a source IP in the port field.
- When connecting to App-B through `ProxyJump`, App-B sees the bastion's private source IP (`10.10.1.10`).
- The `/32` source rules intentionally allow only the specified lab host.
- Do not expose SSH or ICMP to `0.0.0.0/0`.

Keep the default allow-all outbound rules and default allow-all network ACLs for this beginner lab. If you replace the default ACLs, you must account for return traffic and ephemeral ports as well.
