<!--- $size 16:9 --->
# Terraform CH1 Basics

---
# Agenda
- AWS Introduce
  - VPC/EC2/Security Group/ELB/UserData/S3
- Spining up an instance with Terraform
  - Variables
  - Data
  - Output 
  - Remote State (S3)
  - init/apply

---
# Terraform Intro

---
# What is Terraform
- IaC (Infrastructure as Code) Tool	
- Terraform is a tool for building, changing, and versioning infrastructure
- Support Major Cloud Provider (AWS, GCP, Azure ...etc)
- Bunch of Provider (DNS, Database, Monitor System ...etc)

---
# Basic AWS Introduces

---
## AWS Component
- VPC
- Security Group
- EC2 with UserData
- S3

---
## First EC2 Instance
main.tf
```
provider "aws" {
  access_key = "FKIAI3X65USPFQAABBCC"
  secret_key = "iJT0R6a77884dwijqQ/rAuejNg3pfHqZIi5Aq04e"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
```

---
## Terraform init
`$ terraform init`
# ![](./images/init.png)

---
## Terraform apply
`$ terraform apply`
# ![](./images/apply.png)

---
## Terraform state file
`$ cat terraform.tfstate`
It's a JSON file, Terraform use it to map from real world resource to Terraform structures.

---
## Terraform destroy
`$ terraform destroy`
# ![](./images/destroy.png)

---
## Terraform Remote State
backend.tf
```
terraform {
  backend "s3" {
    access_key = "FKIAI3X65USPFQAABBCC"
    secret_key = "iJT0R6a77884dwijqQ/rAuejNg3pfHqZIi5Aq04e"
    bucket = "a-long-name-to-s3-bucket-include-date"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}
```

---
## Terraform Remote State
main.tf
```
provider "aws" {
  access_key = "FKIAI3X65USPFQAABBCC"
  secret_key = "iJT0R6a77884dwijqQ/rAuejNg3pfHqZIi5Aq04e"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
```

---
## Terraform Input Variables
variables.tf
```
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
```
main.tf
```
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
```

---
## Terraform Input Variables
prod.tfvar
```
access_key="FKIAI3X65USPFQAABBCC"
secret_key="iJT0R6a77884dwijqQ/rAuejNg3pfHqZIi5Aq04e"
region="us-east-1"
```
Execute command:
```
$ terraform init
$ terraform apply -var-file=./prod.tfvar
```
---
# Terraform Output

Output public IP for user can be connect.
Important concept when write module.

---
## Terraform Output
output.tf
```
output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}
```
# ![](./images/output.png)

---
