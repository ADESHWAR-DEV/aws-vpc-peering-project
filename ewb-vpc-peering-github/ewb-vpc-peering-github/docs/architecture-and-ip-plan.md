# Architecture and IP plan

## Topology

- VPC A: `10.10.0.0/16`
  - Public subnet: `10.10.1.0/24` — bastion `10.10.1.10`
  - Private subnet: `10.10.2.0/24` — App-A `10.10.2.10`
  - Internet gateway attached to VPC A
- VPC B: `10.20.0.0/16`
  - Private subnet: `10.20.1.0/24` — App-B `10.20.1.10`
  - No internet gateway
- VPC peering: `ewb-a-b-peer`, requester VPC A, accepter VPC B.

## Address inventory

| Name | CIDR / address |
|---|---|
| `ewb-vpc-a` | `10.10.0.0/16` |
| `ewb-a-public` | `10.10.1.0/24` |
| `ewb-a-private` | `10.10.2.0/24` |
| `ewb-vpc-b` | `10.20.0.0/16` |
| `ewb-b-private` | `10.20.1.0/24` |
| `ewb-bastion` | `10.10.1.10` + public IPv4 |
| `ewb-app-a` | `10.10.2.10`, no public IPv4 |
| `ewb-app-b` | `10.20.1.10`, no public IPv4 |

VPC CIDRs are non-overlapping. Every subnet range is contained within its parent VPC range.

## Instance placement

| Instance | VPC | Subnet | Public IPv4 |
|---|---|---|---|
| `ewb-bastion` | A | public | Yes |
| `ewb-app-a` | A | private | No |
| `ewb-app-b` | B | private | No |

Use the same Availability Zone where available for the lab's subnets, as described in the workbook. Use Amazon Linux 2023 and an instructor-approved small x86 instance type (the workbook gives `t3.micro` as an example). Check pricing before launch.
