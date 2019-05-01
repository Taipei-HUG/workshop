# Taipei HUG Terraform Workshop

## Terraform 是什麼？
開一台 AWS Ubuntu 14.04 最新版本的機器，並且新增一個 Tag 為 "HelloWorld" 可以用下面的程式碼辦到，或許第一次寫沒有手點來得快，但是...隨著雲端服務越用越多，管理的成本也越來越高，除了需要耗費龐大的時間之外；人為失誤，交接困難都是手動操作的缺點

使用 Terraform 可讓本來手動操作的行為轉化為程式語言，也就是所謂的 Infrastructure as Code (IaC)，而且他還跨各家公有雲服務平台，讓維運人員使用程式碼便能自動化管理整個雲端服務

```
provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags {
    Name = "HelloWorld"
  }
}
```

## 為什麼有這個 Workshop?
此次 Taipei HashiCorp User Group 與 DevOpsDays Taipei 2018 舉辦工作坊系列活動，歡迎 **"厭惡手動操作 AWS, Azure, GCP Console， 想要一行指令建立/管理龐大雲端架構的人來參加"** ([**報名網址**](https://devopsdays.tw/workshop.html#workshop0915))！


- P.S. 課程內容搭配 **AWS Elastic Kubernetes Service** 實際操練 ，一次學會兩大維運利器！
- P.S. AWS 台灣特別贊助 **"US$50 AWS Credit！"**


## CH00 Environment Setup
**目標**：確保參加者來上課之前設定好下列工具，不要在工作坊進行當中還需要花時間設定環境

- AWS Account Registration
- SSH Key Pair for EC2
- Git
- Terraform v0.11.7
- kubectl
- heptio-authenticator-aws

## CH01 Terraform Basics
**目標**：理解 Terraform 基本觀念，藉由開啟 AWS EC2 Instance 的過程中，理解變數，資料，結果輸出

- Provider Setup: AWS
- Spinning up an instance
	- Variables
	- Data
	- Output
	- Remote State (AWS S3)

## CH02 Terraform Tips
**目標**: Terraform 基礎/常用語法介紹，並順帶提到 Terraform 目前版本的缺陷，將比較在大版本 0.12 更新後，有哪些事情需要注意

- Interpolations
- Changes after v0.12
  - Conditional
  - Count V.S. For and For-Each
  - Rich value types
  - ...

## CH03 Terraform Advanced
**目標**: 理解日常 Terraform 開發的生命週期，並學習利用第三方的 Provider，甚至是網路上現成的 Module 來加速開發，避免重造輪子

- Commands Overview
	- init, get, plan, apply, destroy...etc
- Other Providers
	- Ignition, Null, Template, Github, Random...etc
- Modules

## CH04 Terraform Practices
**目標**: 藉由開發 Module 以及第三方工具 [**Terragrunt**](https://github.com/gruntwork-io/terragrunt) 達成軟體開發 [**SOLID**](https://en.wikipedia.org/wiki/SOLID) 準則

- Module Development
- Terragrunt Hands-On

## CH5 Terraform & EKS I
**目標**: 理解 AWS EKS 架構，並透過講師所開發的 Module 在幾分鐘內將 Production Ready 的 Kubernetes 叢集建構完成

- AWS EKS Infrastructure
- AWS EKS Module: [vishwakarma](https://github.com/getamis/vishwakarma)

## CH06 Terraform & EKS II
**目標**: 進一步檢驗剛建立好的 Kubernetes Cluster 是否可正常運作

- Go Through Kubernetes 101/201 (reduced version) within AWS EKS
