#!/bin/bash
set -e

# Configure AWS CLI credentials
echo "Configuring AWS CLI credentials..."
aws configure set aws_access_key_id "${access_key_id}"
aws configure set aws_secret_access_key "${secret_access_key}"

# Set variables (replace the placeholder with the actual IAM user name if needed)
NEW_IAM_USER="${aws_iam_user}"
MFA_DEVICE_NAME="${NEW_IAM_USER}-virtual-mfa"

echo "Creating IAM user: ${NEW_IAM_USER}"
aws iam create-user --user-name "${NEW_IAM_USER}"

echo "Attaching AdministratorAccess policy to ${NEW_IAM_USER}"
aws iam attach-user-policy --user-name "${NEW_IAM_USER}" --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

echo "Creating a virtual MFA device for ${NEW_IAM_USER}"
# Create the virtual MFA device; the output is stored in a temporary JSON file.
aws iam create-virtual-mfa-device --virtual-mfa-device-name "${MFA_DEVICE_NAME}" --bootstrap-method Base32StringSeed --outfile mfa_device.json > mfa_device-serial.json

# Extract the serial number of the MFA device from the JSON output
SERIAL_NUMBER=$(jq -r '.VirtualMFADevice.SerialNumber' mfa_device-serial.json)
SEED=$(cat mfa_device.json)

echo "The MFA device created has the following Serial Number: ${SERIAL_NUMBER}"
echo "For registering the MFA device, use the Base32 seed value (if needed): ${SEED}"
echo "Scan the QR code generated from the MFA device details (if applicable) using your authenticator app."

# Prompt the user for two consecutive MFA codes from the authenticator app.
read -p "Enter the first MFA code: " MFA_CODE1
read -p "Enter the second MFA code: " MFA_CODE2

echo "Enabling MFA device for user ${NEW_IAM_USER}"
aws iam enable-mfa-device --user-name "${NEW_IAM_USER}" \
    --serial-number "${SERIAL_NUMBER}" \
    --authentication-code1 "${MFA_CODE1}" \
    --authentication-code2 "${MFA_CODE2}"

echo "Generating a pair of access keys for ${NEW_IAM_USER}"
aws iam create-access-key --user-name "${NEW_IAM_USER}" > access_key.json

echo "User creation completed."
echo "Access key details are stored in access_key.json."