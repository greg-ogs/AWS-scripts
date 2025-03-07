#!/bin/bash
set -e

# Replace the following placeholders with your actual values
ROLE_ARN="$1"
EXTERNAL_ID="$2"
SERIAL_NUMBER="$3"
TOKEN_CODE="$4"  # Pass the token code as the first argument to the script
ROLE_SESSION_NAME="mainPc"
DURATION_SECONDS=3600
OUTPUT_FILE="credentials.txt"

if [ -z "$TOKEN_CODE" ]; then
     echo "Usage: $0 <TOKEN_CODE>"
     exit 1
 fi
# Execute the AWS STS Assume Role command and capture the JSON output
JSON_OUTPUT=$(aws sts assume-role \
    --role-arn "$ROLE_ARN" \
    --external-id "$EXTERNAL_ID" \
    --role-session-name "$ROLE_SESSION_NAME" \
    --serial-number "$SERIAL_NUMBER" \
    --duration-seconds "$DURATION_SECONDS" \
    --token-code "$TOKEN_CODE")

# Check if the AWS command was successful
if [ $? -ne 0 ]; then
    echo "Failed to assume role. Please check your credentials and try again."
    exit 1
fi

# Extract credentials using jq
ACCESS_KEY_ID=$(echo "$JSON_OUTPUT" | jq -r '.Credentials.AccessKeyId')
SECRET_ACCESS_KEY=$(echo "$JSON_OUTPUT" | jq -r '.Credentials.SecretAccessKey')
SESSION_TOKEN=$(echo "$JSON_OUTPUT" | jq -r '.Credentials.SessionToken')

# Save the extracted credentials to the output file
cat <<EOL > "$OUTPUT_FILE"
\$env:AWS_ACCESS_KEY_ID="${ACCESS_KEY_ID}"
\$env:AWS_SECRET_ACCESS_KEY="${SECRET_ACCESS_KEY}"
\$env:AWS_SESSION_TOKEN="${SESSION_TOKEN}"
\$env:AWS_REGION="us-west-1"
EOL

chmod 600 "$OUTPUT_FILE"

echo "Credentials have been saved to $OUTPUT_FILE"