# VPC peering, routes, and validation

## Create and accept peering

1. Open **VPC → Peering connections → Create peering connection**.
2. Name: `ewb-a-b-peer`.
3. Requester: VPC A (`ewb-vpc-a`).
4. Account: My account; Region: This Region.
5. Accepter: VPC B (`ewb-vpc-b`).
6. Select the new request, choose **Actions → Accept request**, and confirm.
7. Wait for **Active** status. Record the actual `pcx-...` ID and both VPC IDs.

Peering alone does not create routes or guarantee that traffic is allowed by security groups.

## Add routes

Replace `pcx-ID` with the actual peering connection ID. Retain AWS-created local routes.

| Route table | Destination | Target |
|---|---|---|
| `ewb-rt-a-private` | `10.20.0.0/16` | `pcx-ID` |
| `ewb-rt-b-private` | `10.10.0.0/16` | `pcx-ID` |
| `ewb-rt-a-public` | `10.20.0.0/16` | `pcx-ID` |

The public route table also retains `0.0.0.0/0 → ewb-igw-a`. The public peering route is required because the bastion initiates a separate SSH connection to App-B. The private route tables need reciprocal routes for return traffic.

## Acceptance tests

| Test | Run from | Command / action | Expected result |
|---|---|---|---|
| Baseline | App-A, before peering | `ping -c 4 10.20.1.10` | No replies |
| Forward path | App-A, after routes | `ping -c 4 10.20.1.10` | 4 replies; 0% loss |
| Reverse path | App-B, after routes | `ping -c 4 10.10.2.10` | 4 replies; 0% loss |
| Private SSH | Laptop | `ssh ewb-app-b` | Shell on App-B through bastion |
| Isolation | EC2 console | Inspect App-A and App-B | No public IPv4 on either |

Run these on each private host to identify it and inspect its addresses:

```bash
hostname
hostname -I
ping -c 4 PEER_PRIVATE_IP
```

Replace `PEER_PRIVATE_IP` with the other application host's private address.

## Controlled failure and recovery

1. In `ewb-sg-app-b`, temporarily remove only the inbound ICMPv4 Echo request rule whose source is `10.10.2.10/32`.
2. From App-A, repeat `ping -c 4 10.20.1.10`; replies should stop.
3. Restore the exact rule.
4. Repeat the ping; replies should resume.
5. Keep the SSH rule in place throughout.

Capture the failure and recovery. Do not leave the test rule removed.
