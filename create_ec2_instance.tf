provider "aws" {  
	region = "us-east-1"
	profile = "developer_shamaila"
}


resource "aws_instance" "Ubuntu1604" {
  ami           = "ami-40d28157"
  instance_type = "t2.micro"
}
