#!/bin/bash
set -e

# Set variables
OUTPUT_FILE="sns_topic_info.json"

echo "Configuring AWS CLI credentials..."
aws configure set aws_access_key_id "${access_key_id}"
aws configure set aws_secret_access_key "${secret_access_key}"

# Create the SNS topic and save the output to a JSON file
echo "Creating SNS topic: ${sns_topic}"
aws sns create-topic --name "${sns_topic}" --region "${aws_region}" > "${OUTPUT_FILE}"
SNS_ARN=$(jq -r '.TopicArn' "${OUTPUT_FILE}")

# Suscribe to the topic.
aws sns subscribe --topic-arn "${SNS_ARN}" --protocol email --notification-endpoint "a@a.com" --region ${aws_region}

aws cloudwatch put-metric-alarm \
    --alarm-name ${alarm_name} \
    --metric-name EstimatedCharges \
    --namespace AWS/Billing \
    --statistic Sum \
    --period 300 \
    --evaluation-periods 1 \
    --threshold 10 \
    --comparison-operator GreaterThanThreshold \
    --alarm-actions "${SNS_ARN}" \
    --region ${aws_region}