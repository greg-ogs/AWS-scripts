#!/bin/bash
set -e

# Configure AWS CLI credentials and default region
echo "Configuring AWS CLI credentials..."
aws configure set aws_access_key_id "${access_key_id}"
aws configure set aws_secret_access_key "${secret_access_key}"
aws configure set default.region "${aws_region}"

# Attach the AWS-managed policy for full EC2 access to the IAM group
echo "Attaching AmazonEC2FullAccess policy to IAM group: ${group_developers}"
aws iam attach-group-policy \
  --group-name "${group_developers}" \
  --policy-arn "arn:aws:iam::aws:policy/AmazonEC2FullAccess"

echo "Policy successfully attached to ${group_developers}."

echo "To confirm, the users in the group are: "
aws iam get-group --group-name "${group_developers}"

echo "And the policy of the group attached is: "
aws iam list-attached-group-policies --group-name "${group_developers}"