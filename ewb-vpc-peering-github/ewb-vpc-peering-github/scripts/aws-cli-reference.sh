#!/usr/bin/env bash
# AWS CLI command reference only. This file is intentionally non-executable
# as a deployment workflow: fill in IDs and review every command first.
#
# Prerequisites: AWS CLI configured for the intended account and Region.
# These commands can create or modify billable AWS resources.
#
# Example environment:
# export AWS_REGION=ap-south-1
# export STUDENT_NAME="Your Name"
#
# Create VPCs:
# aws ec2 create-vpc --cidr-block 10.10.0.0/16 --tag-specifications \
#   'ResourceType=vpc,Tags=[{Key=Name,Value=ewb-vpc-a},{Key=Project,Value=EWB-VPC-Peering}]'
# aws ec2 create-vpc --cidr-block 10.20.0.0/16 --tag-specifications \
#   'ResourceType=vpc,Tags=[{Key=Name,Value=ewb-vpc-b},{Key=Project,Value=EWB-VPC-Peering}]'
#
# After creation, set actual IDs:
# VPC_A=vpc-xxxxxxxx
# VPC_B=vpc-yyyyyyyy
#
# Create subnets (choose a valid AZ in your selected Region):
# aws ec2 create-subnet --vpc-id "$VPC_A" --cidr-block 10.10.1.0/24 --availability-zone ap-south-1a
# aws ec2 create-subnet --vpc-id "$VPC_A" --cidr-block 10.10.2.0/24 --availability-zone ap-south-1a
# aws ec2 create-subnet --vpc-id "$VPC_B" --cidr-block 10.20.1.0/24 --availability-zone ap-south-1a
#
# Continue in the AWS Console using docs/network-build.md, docs/security-groups.md,
# and docs/routing-and-validation.md. Record every returned ID before adding routes.
#
# Peering request (replace IDs):
# aws ec2 create-vpc-peering-connection --vpc-id "$VPC_A" --peer-vpc-id "$VPC_B"
#
# Accept (replace pcx ID):
# aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-xxxxxxxx
#
# Add routes only after peering is Active and the route table / peering IDs are verified:
# aws ec2 create-route --route-table-id rtb-xxxxxxxx --destination-cidr-block 10.20.0.0/16 --vpc-peering-connection-id pcx-xxxxxxxx
# aws ec2 create-route --route-table-id rtb-yyyyyyyy --destination-cidr-block 10.10.0.0/16 --vpc-peering-connection-id pcx-xxxxxxxx
# aws ec2 create-route --route-table-id rtb-zzzzzzzz --destination-cidr-block 10.20.0.0/16 --vpc-peering-connection-id pcx-xxxxxxxx
#
# This reference does not launch EC2 instances, create security-group rules,
# or perform cleanup. Follow the documented console workflow and verify IDs.
