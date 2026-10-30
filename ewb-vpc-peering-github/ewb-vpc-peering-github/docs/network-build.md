# Network build (AWS Console)

This guide captures the workbook's build sequence. Create resources in one AWS account and one Region.

## VPC A

1. In **VPC → Your VPCs → Create VPC**, choose **VPC only**.
2. Name: `ewb-vpc-a`; IPv4 CIDR: `10.10.0.0/16`; no IPv6 CIDR; tenancy Default.
3. Create two subnets in VPC A:
   - `ewb-a-public`: `10.10.1.0/24`
   - `ewb-a-private`: `10.10.2.0/24`
4. Create internet gateway `ewb-igw-a` and attach it to VPC A.
5. Create route table `ewb-rt-a-public`; explicitly associate `ewb-a-public`; add `0.0.0.0/0` targeting `ewb-igw-a`. Retain the local route.
6. Create route table `ewb-rt-a-private`; explicitly associate `ewb-a-private`; retain only its local route for now.
7. Keep auto-assign public IPv4 disabled on the private subnet.

## VPC B

1. Create `ewb-vpc-b` with IPv4 CIDR `10.20.0.0/16`.
2. Create `ewb-b-private` with `10.20.1.0/24`.
3. Create `ewb-rt-b-private` and explicitly associate `ewb-b-private`.
4. Retain its local route. VPC B has no internet gateway and no public subnet.

## Naming and tagging

Use the resource names from the main README. Add these tags to resources you create:

- `Project = EWB-VPC-Peering`
- `Student = <your-name>`

Record actual VPC, subnet, route table, instance, security group, and peering IDs in your own project report.

## Checkpoint

Before launching EC2, verify:
- The public subnet is associated with `ewb-rt-a-public`.
- The private subnet in VPC A is associated with `ewb-rt-a-private`.
- The private subnet in VPC B is associated with `ewb-rt-b-private`.
- Only the public route table has the internet default route.
