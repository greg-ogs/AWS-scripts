# AWS Automation Scripts
This project provides a set of shell scripts to automate common AWS tasks. The scripts included in this project help you:
- **Assume an AWS IAM role** with multi-factor authentication (MFA) support.
- **Create an IAM user** with an attached policy and set up a virtual MFA device.
- **Create an SNS topic and a CloudWatch billing alarm.**

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Scripts](#scripts)
    - [Assume Role Script](#assume-role-script)
    - [IAM User Creation and MFA Setup](#iam-user-creation-and-mfa-setup)
    - [SNS Topic and CloudWatch Alarm Creation](#sns-topic-and-cloudwatch-alarm-creation)
- [Usage](#usage)
- [Notes](#notes)
- [License](#license)

## Overview
These scripts are designed to simplify AWS management tasks:
1. **Assume Role Script**: Uses AWS Security Token Service (STS) to assume a role. It retrieves temporary security credentials and writes them to a file for subsequent use with the AWS CLI or SDK.
2. **IAM User Creation and MFA Setup**: Automates the creation of a new IAM user, attaches an AdministratorAccess policy, creates a virtual MFA device, and enables MFA for added security. It also generates a pair of access keys for the new user.
3. **SNS Topic and CloudWatch Alarm Creation**: Automates the creation of an SNS topic, subscribes an email address to it, and sets up a CloudWatch alarm to monitor billing metrics.

## Prerequisites
Before running these scripts, ensure that you have the following installed on your system:
- [AWS CLI](https://aws.amazon.com/cli/) configured with the necessary permissions.
- [jq](https://stedolan.github.io/jq/) for parsing JSON output.
- Bash (a Unix-like environment such as Git Bash or Windows Subsystem for Linux if you're on Windows).

## Installation
1. **Clone the repository:**
``` bash
   git clone <repository-url>
   cd <repository-directory>
```
2. **Make the scripts executable:**
``` bash
   chmod +x AssumeRoleScript.sh IAMUserCreationAndMFASetup.sh CreateSnsTopicCommand.sh
```
3. **Ensure that AWS CLI and jq are installed and accessible from your environment.**

## Scripts
### Assume Role Script
**AssumeRoleScript.sh**
- **Purpose**: This script assumes an AWS IAM role by using the AWS STS command. It requires input such as the role ARN, external ID, MFA serial number, and MFA token code.
- **Output**: The script writes the temporary credentials to a file (`credentials.txt`) including your AWS region and proper permission settings.

**Usage Example:**
``` bash
./AssumeRoleScript.sh <ROLE_ARN> <EXTERNAL_ID> <SERIAL_NUMBER> <TOKEN_CODE>
```
Make sure to replace placeholders (e.g., `<ROLE_ARN>`, `<EXTERNAL_ID>`, etc.) with your actual values.
### IAM User Creation and MFA Setup
**IAMUserCreationAndMFASetup.sh**
- **Purpose**: This script automates the process of creating an IAM user with AdministratorAccess, generating a virtual MFA device, and enabling MFA on the account. It also generates access keys for the newly created user.
- **Output**: The script saves MFA device details, prompts you for MFA codes, and creates a JSON file (`access_key.json`) containing the access key information.

**Usage Instructions:**
1. Configure your AWS CLI credentials if not done already.
2. Set the necessary variables within the script:
    - AWS IAM user name
    - Any other placeholder values

3. Run the script:
``` bash
   ./IAMUserCreationAndMFASetup.sh
```
Follow the interactive prompts for MFA code verification as requested.

### SNS Topic and CloudWatch Alarm Creation
**CreateSnsTopicCommand.sh**
- **Purpose**: This script creates an SNS topic, subscribes an email address to the topic, and creates a CloudWatch alarm that triggers based on billing thresholds.
- **Output**: The script creates an SNS topic, configures an email subscription, and sets up a CloudWatch billing alarm. The SNS topic ARN is saved in `sns_topic_info.json`.

**Usage Instructions:**
1.  Configure your AWS CLI credentials if not done already.
2.  Set the necessary variables within the script:
    -   `sns_topic`: The name of the SNS topic.
    -   `aws_region`: The AWS region.
    -   `alarm_name`: The name of the CloudWatch alarm.
3.  Run the script:

```bash
./CreateSnsTopicCommand.sh
```

Make sure to replace placeholders with your actual values. You will also need to confirm the email subscription by clicking the link sent to the specified email address.

## Usage
1. **Assume a role with MFA:**
   Make sure your environment is set up with the required AWS CLI credentials. Then, run the Assume Role script with proper parameters:
``` bash
   ./AssumeRoleScript.sh <ROLE_ARN> <EXTERNAL_ID> <SERIAL_NUMBER> <TOKEN_CODE>
```
2. **Create a new IAM user with MFA:**
   Update any default variables in the `IAMUserCreationAndMFASetup.sh` script as needed. Then, run the script and follow the prompts:
``` bash
   ./IAMUserCreationAndMFASetup.sh
```
3. **Create an SNS Topic and CloudWatch Alarm:**
   Update the variables in the `CreateSnsTopicCommand.sh` script. Then, run the script:
```bash
    ./CreateSnsTopicCommand.sh
```

## Notes
- **Security**: Ensure you follow best practices when managing AWS credentials. Avoid hard-coding sensitive information in your scripts.
- **Customization**: You can modify the scripts to better suit your workflow or add further automation steps as required.
- **Error Handling**: Both scripts are designed to stop on errors.