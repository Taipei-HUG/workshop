# CH00 Environment Setup

## Welcom to Join HashiCorp Terraform Workshop ^^

---

# Outline

## - AWS Registeration
## - AWS Cloud9 Setup
## - Tools Installation
## - IAM Role Setup

---

# AWS Registeration

## What is the First Thing Before Starting to Explore Terraform? 

## A: Of course, A Cloud Provider Account!! And This Workshop Choose AWS Plaform


---

# Registration Flow

## Visit [**Here**](https://portal.aws.amazon.com/billing/signup#/start) Through Browser,Filling in...

### - Email Addres
### - Password (Confirm Password)
### - AWS Account Name
### - Phone Number (Don't to add +886)
### - Address
### - Credit Card Information
### - ...etc

---

# Congratulations !! 

## - The AWS Account Has been Created.

## - There Are Several Region Within AWS

## - This Workshop will Use Region Oregon (Change from Upper Right corner, Beside Account)

---

# AWS Cloud9

## - In order to Save Time, Let Everyone's Workshop Environment is The Same

## - Visit [Here](https://us-west-2.console.aws.amazon.com/cloud9/home/product?region=us-west-2) Through Browser to Open Cloud9 Console

---

# What is Cloud9?

## - Cloud9 is a Cloud IDE for Writing, Running, and Debugging Code

## - In Fact, It will Boot A EC2 VM for Development

---

# Creating Environment (1/3)

## - Click The Creating Environment Button

## - Input Name, Description

## - Click `Next Step` Button

---

# Creating Environment (2/3)

## - Environment Type: Create a New Instance Environment

## - Instance Type: t2.micro

## - Cost-Saving Setting: After 30 minutes (default)

## - Click `Next Step` Button

---

# Creating Environment (3/3)

## - Review Environment Name and Settings

## - Click `Create Environment` Button

## - Then Just Waiting Few Minutes

---

# - Seeing the IDE Show Up ! 

## - Left Side is file Panel

## - There are two Items in Right Side

## - Above is File Panel

## - Below is Terminal Panel

---

# Tools Installation

## - There are Several Tools Need to be installed

## - HashiCorp Terraform

## - kubectl

## - heptio-authenticator-aws

---

# HashiCorp Terraform

Follow Below Command to Install Terraform

```
name:~/environment $ curl -o terraform_0.11.8_linux_amd64.zip https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip

name:~/environment $ unzip terraform_0.11.8_linux_amd64.zip

name:~/environment $ sudo mv terraform /usr/local/bin/

name:~/environment $ rm terraform_0.11.8_linux_amd64.zip

name:~/environment $ terraform version

Terraform v0.11.8
```
---

# kubectl

Follow Below Command to Install kubectl

```
name:~/environment $  curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/kubectl

name:~/environment $ chmod +x ./kubectl

name:~/environment $ sudo mv kubectl /usr/local/bin/

name:~/environment $ kubectl version

Client Version: version.Info{Major:"1", Minor:"10", GitVersion:"v1.10.3", GitCommit:"2bba0127d85d5a46ab4b778548be28623b32d0b0", GitTreeState:"clean", BuildDate:"2018-07-26T20:40:11Z", GoVersion:"go1.9.3", Compiler:"gc", Platform:"linux/amd64"}
The connection to the server localhost:8080 was refused - did you specify the right host or port?

```
---

# heptio-authenticator-aws

Follow Below Command to Install heptio-authenticator-aws

```
name:~/environment $ curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator

name:~/environment $ chmod +x ./aws-iam-authenticator

name:~/environment $ sudo mv aws-iam-authenticator /usr/local/bin/heptio-authenticator-aws

name:~/environment $ heptio-authenticator-aws help

A tool to authenticate to Kubernetes using AWS IAM credentials

Usage:
  heptio-authenticator-aws [command]
...


```
---

# IAM Role Setup

## - Cloud9 Default Permission is Not Allow to Create Other AWS Resource

## - Hence, Need to Create a Role then attach to the EC2 Instance Which Links to Cloud9 Environment

---

# Create Policy (1/2)

## - Visit [Here](https://console.aws.amazon.com/iam/home?region=us-east-1#/policies) and Click "Create policy" Button and Choose "JSON", Paste Below Content

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:*",
                "s3:*",
                "ec2:*",
                "autoscaling:*",
                "eks:*"
            ],
            "Resource": "*"
        }
    ]
}
```
---

# Create Policy (2/2)


## - Click "Preview Policy" Button, Name the Policy and Click "Create policy" Button Finally

---

# Create Role (1/2)

## - Visit [Here](https://console.aws.amazon.com/iam/home?region=us-east-1#/roles) and Click "Create Role" Button

## - type of trusted entity: "AWS Service"

## - the service that will use this role: "EC2"

## - Click "Next: Permission" Button

## - Choose the Policy Created Just Now, then Click "Next: Preview" Button

---

# Create Role (2/2)

## - Name the Role, Click "Create role" Button

## - Visit The EC2 Panel, Attach the Role Created Just Now to The Cloud9 EC2 Instance (Name: aws-cloud9-*)

---

# Congratulations !! 

## You Have Completed the Workshop Environment Setup

## Looking Forward to Seeing You at 9/15
