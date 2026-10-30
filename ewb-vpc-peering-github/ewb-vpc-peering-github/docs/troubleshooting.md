# Troubleshooting

| Symptom | Inspect |
|---|---|
| Bastion SSH times out | Current bastion public IP; your current public IPv4 `/32` in its SSH rule; public subnet association; `0.0.0.0/0` route to attached IGW |
| App-A SSH fails | App-A private IP; TCP 22 allowed from `10.10.1.10/32`; correct key, `ec2-user`, and running instance |
| App-B SSH fails | Public subnet route to `10.20.0.0/16` via peering; VPC B return route; App-B SSH source is bastion private IP |
| Ping fails after peering acceptance | Both private route tables; correct peering ID and Active state; destination Echo request rule; actual host IPs |
| Peering creation fails | Check all CIDRs associated with both VPCs for overlap, including secondary CIDRs |
| `Permission denied (publickey)` | Correct key pair, local `IdentityFile`, and `ec2-user`; reaching SSH authentication indicates the network path reached the SSH service |
| Failure after custom network ACLs | Both directions, ICMP rules, and SSH return ephemeral ports; this lab assumes default allow-all ACLs |

## Be ready to explain

1. **Why is a return route needed?** The response packet must have a route back to the originating VPC.
2. **Why is App-B's SSH source the bastion private IP?** ProxyJump makes the bastion open a separate connection to App-B.
3. **Why does Active peering not guarantee ping?** Routes, security groups, network ACLs, and host-level behavior still govern reachability.
4. **Can VPC B use VPC A's internet gateway over peering?** No. Peering does not provide transitive routing or gateway sharing.

VPC peering is one-to-one and non-transitive. An A-B peering plus an A-C peering does not create B-C connectivity.
