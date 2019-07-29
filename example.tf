provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_instance" "bharaths_ec2" {
  ami = "ami-2757f631"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "bharath-terraform-state-storage-playground" {
  bucket = "bharath-terraform-state-playground"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "dynamo-db-terraform-state-lock-playground" {
  hash_key = "LockID"
  name = "bharath-terraform-state-playground"
  read_capacity = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
}