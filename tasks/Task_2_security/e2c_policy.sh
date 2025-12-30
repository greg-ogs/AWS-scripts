#!/bin/bash

# --- Configuration ---
export AWS_ACCESS_KEY_ID="${access_key_id}"
export AWS_SECRET_ACCESS_KEY="${secret_access_key}"
export AWS_DEFAULT_REGION="us-east-1"

# Resource Identifiers
ROLE_NAME="${iam_role}"
INSTANCE_NAME="${instance}"
S3_POLICY_NAME="${deny_s3_policy}"
EC2_POLICY_NAME="${deny_ec2_policy}"

# Fetch the Public IP of the EC2 instance to use in the condition.
# Get the Instance ID from the provided Name

INSTANCE_ID=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$INSTANCE_NAME" \
    --query "Reservations[0].Instances[0].InstanceId" \
    --output text)

echo "Fetching Public IP for Instance ID: $INSTANCE_ID..."

PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --query "Reservations[0].Instances[0].PublicIpAddress" \
    --output text)

echo "Detected Instance Public IP: $PUBLIC_IP"

# Create the S3 Deny Policy (Inline)
# Denies Get and List actions if the request comes from the instance's Public IP.
echo "Creating inline policy: $S3_POLICY_NAME..."
aws iam put-role-policy \
    --role-name "$ROLE_NAME" \
    --policy-name "$S3_POLICY_NAME" \
    --policy-document '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Deny",
                "Action": [
                    "s3:Get*",
                    "s3:List*"
                ],
                "Resource": "*",
                "Condition": {
                    "IpAddress": {
                        "aws:SourceIp": "'"$PUBLIC_IP"'/32"
                    }
                }
            }
        ]
    }'

# Denies Describe actions if the request targets the eu-west-1 region.

echo "Creating inline policy: $EC2_POLICY_NAME..."
aws iam put-role-policy \
    --role-name "$ROLE_NAME" \
    --policy-name "$EC2_POLICY_NAME" \
    --policy-document '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Deny",
                "Action": "ec2:Describe*",
                "Resource": "*",
                "Condition": {
                    "StringEquals": {
                        "aws:RequestedRegion": "eu-west-1"
                    }
                }
            }
        ]
    }'

echo "Configuration complete."