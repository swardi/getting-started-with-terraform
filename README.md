# getting-started-with-terraform
Getting started with Terraform


# What is Terraform

Terraform code is written in a declarative language called HCL (HashiCorp Configuration Language). The HCL code goes into files with extension .tf. So far terraform doesn't support arrangemnet of code into folders. So all your .ts files go directly in the root level folder. 

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


# Step 1: Create folder and main.tf file.
The first and easiest step is to create an empty folder and create a file with name main.tf. Setup your provider with the following lines.

provider "aws" {
  region = "us-east-1"
}

AWS has data centers divided into regions and zones. A region is a separate geographic area such as us-east-1 and eu-west-1 which represent North Virginia nd Ireland. Within each region there are multiple isolated data centers known as availability zones such as us-east-1a etc. You can add whatever region you like or whatever region you are in.

# Step 2: Create a new EC2 Instance 
