#!/bin/bash
set -e

# Configure AWS CLI credentials and default region
echo "Configuring AWS CLI credentials..."
aws configure set aws_access_key_id "${access_key_id}"
aws configure set aws_secret_access_key "${secret_access_key}"
aws configure set default.region "${aws_region}"

assume_role_name="cmtr-a8746d8c-iam-ar-iam_role-assume"
readonly_role_name="cmtr-a8746d8c-iam-ar-iam_role-readonly"

# Create a policy document that allows assuming the readonly role
assume_policy_document=$(cat <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::$(aws sts get-caller-identity --output text --query Account):role/${readonly_role_name}"
        }
    ]
}
EOF
)

# Create a temporary policy name (can be any unique name)
assume_policy_name="AssumeReadOnlyRolePolicy-${assume_role_name}"

# Create the IAM policy
# Get the ARN of the created policy from the json output
assume_policy_arn=$(aws iam create-policy \
    --policy-name "${assume_policy_name}" \
    --policy-document "$assume_policy_document" \
    --region "${aws_region}" | jq -r '.Policy.Arn')

# Attach the policy to the assume role
aws iam attach-role-policy \
    --role-name "${assume_role_name}" \
    --policy-arn "${assume_policy_arn}" \
    --region "${aws_region}"

echo "Permissions configured for the assume role."

# --- Step 2: Grant full read-only access for the readonly role ---

echo "Granting full read-only access to the readonly role: ${readonly_role_name}"

# Attach the ReadOnlyAccess managed policy to the readonly role
aws iam attach-role-policy \
    --role-name "${readonly_role_name}" \
    --policy-arn "arn:aws:iam::aws:policy/ReadOnlyAccess" \
    --region "${aws_region}"

echo "Full read-only access granted to the readonly role."

# --- Step 3: Configure the correct trust policy for the readonly role ---

echo "Configuring the trust policy for the readonly role: ${readonly_role_name}"

# Get the ARN of the assume role
assume_role_arn=$(aws iam get-role --role-name "${assume_role_name}" --region "${aws_region}" --output text --query 'Role.Arn')

# Create the trust policy document
trust_policy_document=$(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${assume_role_arn}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
)

# Update the assume role policy for the readonly role
aws iam update-assume-role-policy \
    --role-name "${readonly_role_name}" \
    --policy-document "$trust_policy_document" \
    --region "${aws_region}"

echo "Trust policy configured for the readonly role."

echo "Role chaining configuration complete."
