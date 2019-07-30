provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_instance" "bharaths_ec2" {
  ami = "ami-2757f631"
  instance_type = "t2.micro"
  depends_on = [aws_s3_bucket.bharaths_s3bucket]  # S3 Bucket gets created before creting the bharath_ec2 instance
}

resource "aws_eip" "ip" {
  instance = aws_instance.bharaths_ec2.id # This is called implicit dependency bharath_ec2 instance gets launched before EIP gets assigned
}

# How to use explicit dependency using the depends_on keyword
resource "aws_s3_bucket" "bharaths_s3bucket" {
  bucket = "bharath-raju-terraform-bucket"
  acl = "private"
}


resource "aws_instance" "another_bharaths_ec2" {
  ami = "ami-b374d5a5"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.another_bharaths_ec2.public_ip} > ipaddress_anotherbharathec2.txt"
    on_failure = continue
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.bharaths_ec2.public_ip} >  ipaddress_bharathec2.txt"
    on_failure = continue
  }
}