# EC2 compute and SSH administration

## Key pair

1. In EC2, create an RSA key pair named `ewb-lab`.
2. Download the `.pem` file and store it on your own laptop.
3. Never upload or paste the private key onto an EC2 instance.

## Instance configuration

Use Amazon Linux 2023 and an instructor-approved small x86 instance type (the workbook suggests `t3.micro` as an example). Check displayed pricing and account credits. Keep the root disk small and enable delete-on-termination for the lab volume.

| Instance | VPC / subnet | Private IPv4 | Public IPv4 |
|---|---|---:|---|
| `ewb-bastion` | VPC A / `ewb-a-public` | `10.10.1.10` | Enable |
| `ewb-app-a` | VPC A / `ewb-a-private` | `10.10.2.10` | Disable |
| `ewb-app-b` | VPC B / `ewb-b-private` | `10.20.1.10` | Disable |

During launch, select the correct VPC and subnet, set the primary private IPv4 address, and select the security group belonging to that VPC. Wait for each instance to run and pass status checks.

## Local SSH setup

Move the key to `~/.ssh/ewb-lab.pem`, then run:

```bash
chmod 400 ~/.ssh/ewb-lab.pem
```

Add to `~/.ssh/config` (replace the bastion placeholder):

```sshconfig
Host ewb-bastion
    HostName BASTION_PUBLIC_IP
    User ec2-user
    IdentityFile ~/.ssh/ewb-lab.pem
    IdentitiesOnly yes

Host ewb-app-a
    HostName 10.10.2.10
    User ec2-user
    IdentityFile ~/.ssh/ewb-lab.pem
    IdentitiesOnly yes
    ProxyJump ewb-bastion

Host ewb-app-b
    HostName 10.20.1.10
    User ec2-user
    IdentityFile ~/.ssh/ewb-lab.pem
    IdentitiesOnly yes
    ProxyJump ewb-bastion
```

Test:

```bash
ssh ewb-bastion
ssh ewb-app-a
ssh ewb-app-b
```

Run all commands from your laptop. Verify the destination host before accepting a first-time host-key prompt.

## Baseline test

Before creating peering or peer routes, connect to App-A and run:

```bash
ping -c 4 10.20.1.10
```

The expected baseline is no replies. Save the actual output. App-B SSH is expected to work only after peering and routes are configured.
