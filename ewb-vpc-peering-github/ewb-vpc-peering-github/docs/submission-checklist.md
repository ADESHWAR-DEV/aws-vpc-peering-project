# Submission and evidence checklist

Submit one report PDF named `YourName_EWB_VPC_Peering.pdf`.

- [ ] Cover page: name, batch, project title, Region, completion date.
- [ ] Architecture diagram and inventory with actual resource IDs and private IPs.
- [ ] Subnet CIDRs and all three route tables, including subnet associations.
- [ ] Active peering connection and inbound rules for each security group.
- [ ] Baseline ping failure.
- [ ] Forward and reverse ping success.
- [ ] App-B SSH proof through the bastion.
- [ ] Controlled ICMP failure and recovery, with explanation.
- [ ] Cleanup evidence and a short learning reflection.

Label every screenshot with the host, test, and result. Explain the forward and return paths. Do not include private keys, passwords, or access tokens.

## Evaluation rubric (100 marks)

| Assessment area | Marks |
|---|---:|
| Architecture, CIDRs, and resource inventory | 15 |
| Subnets, internet gateway, and route associations | 20 |
| Peering plus forward and return routes | 20 |
| Security rules and private SSH access | 20 |
| Positive and negative test evidence with explanations | 15 |
| Report clarity, viva, and cleanup evidence | 10 |

The workbook's expected outputs are acceptance criteria only. Include your own execution evidence.
