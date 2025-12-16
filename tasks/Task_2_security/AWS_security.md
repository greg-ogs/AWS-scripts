# Configuring the IAM Group Permissions
## Lab Description
The goal of this task is to configure required permissions for a given user group and verify that users within this group 
have inherited these permissions.

See the following diagram for an overview of the lab:


## Task Resources
Region-specific resources are created in the us-east-1 region. For more details about regional services, see AWS Services by Region.

In this task, you should work with the following resources:

**IAM Group** <span style="color:red">cmtr-a8746d8c-iam-g-group-developers</span>: An IAM user group.

**IAM Users** <span style="color:red">cmtr-a8746d8c-iam-g-user-dev-0, cmtr-a8746d8c-iam-g-user-dev-1, and cmtr-a8746d8c-iam-g-user-dev-2</span>: 
These users are added to the <span style="color:red">cmtr-a8746d8c-iam-g-group-developers</span> group.

## Objectives
In one move, you must grant the correct permissions to the <span style="color:red">cmtr-a8746d8c-iam-g-group-developers</span> 
group so that each user in the group has full access to the EC2 service. Use an AWS-managed policy and follow the principle of least privilege. 
Do not create your own policy.

One "move" is the creation, updating, or deletion of an AWS resource. Some validation steps may pass without any action, 
but to complete the task, you must ensure that all steps are passed.

## Task Verification
To make sure everything has been done correctly, you can create a console password for one of the users, sign in as this
user, and verify that the <span style="color:red">cmtr-a8746d8c-iam-g-group-developers</span> group has full access to 
the EC2 service.

**Deployment Time:**
It should take about 2 minutes to deploy the task resources.

# Configuration of Role Chaining in AWS

**Focus Tool:** AWS IAM
## The Goal of the Task
The goal of this task is to configure role chaining using two roles, allowing one dedicated role to assume another role with read-only access.

## Task Resources
Region-specific resources are created in the **us-east-1** region. For more details about regional services, see AWS Services by Region.

The following roles have been created for you:

**Assume Role** <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-assume</span>: This role should be assumed by any user in your AWS account.

**Read-Only Role** <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-readonly</span>: This role should be assumed 
only by the <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-assume</span> role.
## Task Flow
### Your task is to:

Configure proper permissions for the <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-assume</span> role, allowing 
it to assume the <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-readonly</span> role. Do not grant full 
administrator access!

Grant full read-only access for the <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-readonly</span>. Please use an
existing AWS policy; do not create your own.

Configure the correct trust policy for the c<span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-readonly</span> role to
allow it to be assumed by the <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-assume</span> role.
One "move" is the creation, updating, or deletion of an AWS resource. Some verification steps may pass without any action, but to complete the task, you must ensure that all the steps are passed.

## Verification
To make sure everything is set up correctly, use the AWS policy simulator for the roles and check that:

The <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-assume</span> role can assume other roles.
The <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-readonly</span> role can perform read-only actions and is not 
allowed to perform write actions.
Optionally: Instead of using the AWS policy simulator, you can assume the <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-assume</span>
role and then assume the <span style="color:red">cmtr-a8746d8c-iam-ar-iam_role-readonly</span> role with this role. Next,
try to execute any command that requires read-only access; it should be successful. Then, try to execute a command that 
requires write access; it should return an error message.

**Deployment Time:**
It takes up to 2 minutes to deploy task resources.

