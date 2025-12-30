#!/bin/bash

# --- Configuration ---
# Ensure these variables are replaced with your actual values
# or exported in your environment before running the script.

# AWS Credentials and Region Configuration
export AWS_ACCESS_KEY_ID="${access_key_id}"
export AWS_SECRET_ACCESS_KEY="${secret_access_key}"
export AWS_DEFAULT_REGION="us-east-1"

# Role Names
readonly_role="${iam_role_readonly}"
admin_role="${iam_role_administrator}"

# Grant Read-Only access to the Read-Only Role

echo "Attaching ReadOnlyAccess policy to $readonly_role..."
aws iam attach-role-policy \
    --role-name "$readonly_role" \
    --policy-arn "arn:aws:iam::aws:policy/ReadOnlyAccess"

# Grant Administrator access to the Administrator Role

echo "Attaching AdministratorAccess policy to $admin_role..."
aws iam attach-role-policy \
    --role-name "$admin_role" \
    --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess"

echo "Configuration complete."