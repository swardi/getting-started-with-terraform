
# Getting started with Terraform


# What is Terraform

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently using code written in configuration files. It creates an execution plan before actually executing it and also maintains a resource graph and versions the current state of the infrastructure and applies only the changes when you run it again after making changes in the configuration files.

Terraform code is written in a declarative language called HCL (HashiCorp Configuration Language). The HCL code goes into files with extension .tf. So far terraform doesn't support arrangemnet of code into folders. So all your .ts files go directly in the root level folder. The general syntax of terraform resource is:

resource "PROVIDER_TYPE" "NAME" {
  [CONFIG ...]
}

We will discuss later, what is a resource and what this syntax mean. Here I have added it to demonstrate that how declarative the language is.

# Which cloud
It supports multiple cloud providers like
- Amazon AWS
- Google Cloud
- Microsoft Azure
- OpenStack

# IDE support
Terraform syntax highlighting is supported in most the editors like Sublime, Atom, Visual Studio and IntelliJ. IntelliJ even supports refactoring, find usage and go to declaration etc. 

# Steps to get started

## 1) Setup your AWS account
Go to https://aws.amazon.com to create your new account. Your new account is the root user and have permissions to do absolutely anything with your account. It is always a good idea to create users with different permissions for you account.

## 2) Create new user with limited permissions. 
Login to use aws console and seach IAM (Identiy and access mangemnet). Click on users and click on "Addd User" button to add new user. Make sure that Programmatic access (Enables an access key ID and secret access key for the AWS API, CLI, SDK, and other development tools) checkbox is enabled. In the permissions area make sure to select following permissions

AmazonEC2FullAccess
AmazonS3FullAccess
AmazonRDSFullAccess
AmazonCloudWatchFullAccess
IAMFullAccess

Select a name for your permission group and finish the process. Note down the access key and secret, they will never appear in front of you again.


## 3) Download and install Terraform. 
Terraform is a single binary that you just need to download and add in your system path. 
https://www.terraform.io/downloads.html

To make sure that Terraform is running, open a terminal window and type command terraform --version. It should show you the version of installed terraform binary like the following.

Terraform v0.11.4

## 4) Setup AWS credentials in your machine.
In order for terraform to setup your infrastructure in your account it needs your security crendentials. You can setup your credentials as environment variable or in $HOME/.aws/credentials file. The content of credentials file should look like the following
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

For more information see the following link
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html


# Steps to Dedploy a Single Server
The first step to deploy a server is to configure a provider. Since we have planned to use AWS, we will have to configure AWS. We already have created our brand new account for AWS so next step is to use it in our config file.


# Step 1: Create folder and .tf file.
The first and easiest step is to create an empty folder and create a file with name create_ec2_instance.tf. Setup your provider with the following lines.

provider "aws" {
  region = "us-east-1"
}

AWS has data centers divided into regions and zones. A region is a separate geographic area such as us-east-1 and eu-west-1 which represent North Virginia nd Ireland. Within each region there are multiple isolated data centers known as availability zones such as us-east-1a etc. You can add whatever region you like or whatever region you are in.

# Step 2: Create a new EC2 Instance 
Each cloud provider supports different kinds of resources like databases, servers, load balancers etc. To deploy a single server in AWS which is known as EC2 instance (Amazon Elastic Compute Cloud Instance), you can add the aws_instance configuration. The general syntax of resource is

resource "PROVIDER_TYPE" "NAME" {
  [CONFIG ...]
}

Where PROVIDER is the name of provider like aws, azure etc. and TYPE is the type of resource that you want to create e.g instance. NAME is the identifier that you will use to reference this resource throughout the terraform code. CONFIG consists of one or more configuration parameters that are specific to that resource. These configuration can differe from provider to provider and also according to your needs. For example to add EC2 instance we can provide 6 different configurations but I will use only couple of them here i.e ami and instance_type.

Enough talking, now add code. Let's add following lines in our create_ec2_instance.tf file

resource "aws_instance" "example" {
  ami           = "ami-40d28157"
  instance_type = "t2.micro"
}

AMI (Amazon machine image) provides the information required to launch an EC2 instance. These AMIs are available free/paid in AWS marketplace. ami-40d28157 is the ID of an ubuntu 16.04 AMI.

Instance_type is the type of EC2 instance. Each type provides different CPU, memory and networking capacity. t2.micro has one virtual CPU, 1 GB memory and is part of the AWS free tier. 

# Step 3: Initialize terraform
Open command terminal and go to the folder where you have create_ec2_instance.tf and run following command
terraform init

# Step 4: Run terraform plan
Now run following command
terraform plan

This command tells you what terraform will actually do before making any changes. You can review them before actually executing the command. In the output the resources with a plus sign will be created, resources with a minus will be deleted and resources with ~ sign will get modified. The last line tells you the summary of all actions. For example the create_ec2_instance.tf that we have created in this example will output following as summary of actions.

Plan: 1 to add, 0 to change, 0 to destroy.

# Step 5: Let terraform actually create your instance
To let terraform actually create the instance, run the following command

terraform apply

# Step 6: Verify
You can now verify that your instance is really up by logging into your aws console account.
If you cannot find your instance on AWS, make sure you are in the correct region. By default aws console will take you to the region near to your country.

This getting started tutorial was only to demonstrate how it is to start using terraform. The next steps are more practicle and complete examples of using it.
