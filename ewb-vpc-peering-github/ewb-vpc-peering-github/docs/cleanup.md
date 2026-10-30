# Cleanup

Save all evidence before deleting resources. Remove only resources created for this lab.

1. **Terminate compute:** terminate `ewb-bastion`, `ewb-app-a`, and `ewb-app-b`. Confirm lab EBS volumes are deleted; remove leftover lab volumes or snapshots. Release any Elastic IP created. Remove the unused lab key pair and local lab key if no longer needed.
2. **Remove peering and network dependencies:** delete peer routes and `ewb-a-b-peer`. Delete lab security groups after instance network interfaces disappear. Remove subnet associations as required, then delete lab subnets and custom route tables. Detach and delete `ewb-igw-a`. Delete both lab VPCs.
3. **Verify:** filter by `Project=EWB-VPC-Peering` and check EC2, volumes, public IPv4 allocations, and VPC resources in the lab Region. Check Billing for remaining chargeable resources; usage reporting can lag.

Do not delete unrelated resources. Confirm the Region and resource names before each destructive action.
