provider "aws" {
    region = "ap-south-1"
    profile = "default"
  
}
resource "aws_instance" "name" {
    ami = "ami-078264b8ba71bc45e"
    instance_type = "t2.micro"
    key_name = "New-Key"
    vpc_security_group_ids = ["sg-0cde5f587e0bdff1b"]
    tags = {
      Name = "Test-Instance"
    }
    

}
resource "aws_dynamodb_table" "dynamodb_table" {
  name = "state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  
}
terraform {
  backend "s3" {
    bucket = "terraform-s3-bucket2024"
    key = "testfile/state-locking/terraform.tfstate"
    encrypt = true
    region = "ap-south-1"
    dynamodb_table = "state-locking"
    

    
  }
}