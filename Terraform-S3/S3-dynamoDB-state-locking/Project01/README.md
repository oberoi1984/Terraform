This project manages the creation of an AWS EC2 instance using Terraform with state management stored in an S3 bucket and state locking implemented via DynamoDB. The configuration ensures that infrastructure changes are tracked and protected against simultaneous updates.

main.tf: Defines the AWS provider, backend configuration, and the resources to create.

Configure AWS Credentials Ensure your AWS credentials are configured using the AWS CLI.

aws configure

Backend Configuration
-----------------------

State management is handled using an S3 bucket with DynamoDB for state locking to prevent simultaneous updates. Here's the backend configuration in main.tf:

terraform {
  backend "s3" {
    bucket = "terraform-s3-bucket2024"
    key = "testfile/state-locking/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "state-locking"

    
  }
}

Explanation
------------

bucket: The name of the S3 bucket where the state file is stored.
-------
key: The path within the S3 bucket to store the state file.
----
region: The AWS region where the S3 bucket and DynamoDB table are located.
-------
dynamodb_table: The DynamoDB table used for state locking.
---------------

State Management
-----------------

The state file is stored in the specified S3 bucket, and DynamoDB is used for state locking. This setup ensures that:

Changes are tracked and persisted.

Multiple users or processes cannot apply changes simultaneously.

Verify that the DynamoDB table is correctly configured with a LockID attribute of type String.
-----------------------------------------------------------------------------------------------