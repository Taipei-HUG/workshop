# CH04 Terraform Practices

## - Believe Everyone Have Learned How to Leverage Terraform to Manage AWS Resource

## - Now We Will Introduce How Develop Module and Make Your Terraform More Professional
---

# Outline

## - What is Terragrunt?

## - Modulize Everything

## - Exercise, Exercise, Exercise

---
# What You Need In A Terraform Folder At Least Before?

```
Frontend/
├── Makefile           (Terraform Related Tasks)
├── env                (Variable from environment variable)
├── asg.tf             (Define Cloud Provider Resources)
├── lb.tf              (Define Cloud Provider Resources)
├── operations         (Some Helper Shell Script for Makefile)
├── terraform.tfvars   (Some Predefined Variable Value)
└── variables.tf       (Variable Definition)
```
---

# After Using Terraform a Long Time...

## - Have Multiple AWS Accounts

## - Deploy Service Within Multiple Regions

## - Trust Me, The Terraform Repository Will Become Mess 

## - And Need to Takes Time to Maintain Makefile and Helper Scripts

---

# What is Terragrunt?

## - Terragrunt is a Thin Wrapper for Terraform

## - Provides Extra Tools for Keeping Your Terraform Configurations DRY

## - Working with Multiple Terraform Modules, and Managing Remote State

---

# What is Terragrunt?

## It's A Tool to Save Your Time, Force You to Produce Clean Code


---

# What It Looks Like After Using Terragrunt

```
examples/
├── account_a
│   ├── ap-northeast-1
│   │   └── dev
│   │       ├── env.tfvars
│   │       ├── frontend
│   │       │   └── terraform.tfvars
│   │       └── terraform.tfvars
│   └── us-west-2
│       └── dev
│           ├── env.tfvars
│           ├── frontend
│           │   └── terraform.tfvars
│           └── terraform.tfvars
└── modules
    └── frontend
```

---

# Exercise I

## Try to Create A Fountend Server Group in Tokyo...

```
~$ cd ch04/examples/account_a/ap-northeast-1/dev/frontend

~$ terragrunt init

~$ terragrunt apply

```
---

# Exercise II

## If I Want to Achieve The Same Thing in Oregon...

```
~$ cd ch04/examples/account_a/us-west-2/dev/frontend

~$ terragrunt init

~$ terragrunt apply

```
---

# What You Have Done Just Now?

## - Create Two Frontend Server Group in Two Different Region

## - And Without Write Any New Code

## - Let Us Go Through What Terragrunt Do! 

```
~$ cd ch04/examples/account_a/us-west-2/dev
```

---

# *.tfvars

## - Only Two tfvars File Create Everything

## - In Folder dev Define Remote State Backend, Enviornment Variable

## - In Folder frontend Define Module Source, and The Variable Pass to Module frontend
---

# Hence

---

# Not Finish Yet...

## We Have Not Understood Module Frontend Yet...

```
modules/
└── frontend
    ├── asg.tf
    ├── lb.tf
    ├── main.tf
    ├── outputs.tf
    └── variables.tf
```

---

# If You Want to Create Something Afterward, Just ...

## 1. Develope Module

## 2. Create Folder and *.tfvars Files

## 3. Execute terragrunt !