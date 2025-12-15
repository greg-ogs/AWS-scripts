# Create and Configure a Custom Administrator User
## Lab Description
The goal of this task is to create and configure a custom IAM user with Administrator privileges, Multi-Factor Authentication (MFA), and programmatic access to AWS.

## Task Resources
In this task you will work with the following resource:

**IAM User:** <span style="color:red">cmtr-a8746d8c-user</span>
## Objectives
In four moves, you must:

Create a new IAM user with the username <span style="color:red">cmtr-a8746d8c-user</span>.
Attach the AWS-managed AdministratorAccess policy to the new user. Please, use the existing policy and do not create your own.
Configure MFA for the user. Use only the "Passkey or security key" or "Authenticator app" Device options.
Generate a pair of access keys for programmatic access via the AWS CLI.
One "move" is the creation, update, or deletion of an AWS resource. Some verification steps may pass without taking any action, but to complete the task you must ensure that all the steps are passed.

## Task Verification
To verify that everything has been done correctly, you can log in to the AWS Management Console as the newly created user <span style="color:red">cmtr-a8746d8c-user</span>. Next, execute any command that requires administrative access; it should be successful.

**Deployment Time:**
It should take about 2 minutes to deploy the task resources.

# Create an AWS Billing Alarm and Configure It to Send Email Notification via SNS Topic
## Lab Description
The goal of this task is to create a CloudWatch billing alarm that sends billing notifications through an SNS topic.

## Task Resources
Region-specific resources must be created in the us-east-1 region. For more details about regional services, see AWS Services by Region.

In this task, you will work with the following resources:

SNS Topic <span style="color:red">cmtr-a8746d8c-topic</span>: An SNS topic with an email subscription for billing notifications.
CloudWatch Alarm <span style="color:red">cmtr-a8746d8c-alarm</span>: A CloudWatch alarm that triggers based on billing thresholds.
Objectives
In this task, you need to:

Create an AWS SNS topic <span style="color:red">cmtr-a8746d8c-topic</span>.
Create an email subscription for the SNS topic.
Enable billing alerts for the AWS account. (this step is already completed because the task is running in a sandbox environment)
Create a CloudWatch billing alarm <span style="color:red">cmtr-a8746d8c-alarm</span> that monitors your billing metrics.
## Task Verification
To verify that you have successfully completed the task:

The SNS topic <span style="color:red">cmtr-a8746d8c-topic</span> exists and has the email subscription configured.
Billing alerts are enabled for your account. (this step is already completed because the task is running in a sandbox environment)
The CloudWatch alarm <span style="color:red">cmtr-a8746d8c-alarm</span> is correctly set up and monitoring billing metrics.
**Deployment Time**
It should take about 5 minutes to deploy the task resources.
