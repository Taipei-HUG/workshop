# Taipei HUG Terraform Workshop

## Terraform 是什麼？
使用公有雲已經是不可逆的趨勢，但隨著雲端服務越用越多，管理的成本也越來越高，除了需要耗費龐大的時間之外；人為失誤，交接困難都是手動操作的缺點

使用 Terraform 可讓本來手動操作的行為轉化為程式語言，也就是所謂的 Infrastructure as Code (IaC)，讓維運人員使用程式碼便能自動化管理整個雲端服務

## 為什麼有這個 Workshop?
此次 Taipei HashiCorp User Group 與 DevOpsDays Taipei 2018 舉辦工作坊系列活動，歡迎 **"厭惡手動操作 AWS, Azure, GCP Console， 想要一行指令建立/管理龐大雲端架構的人來參加"** ([**報名網址**](https://devopsdays.tw/workshop.html#workshop0915))！

P.S. 課程內容搭配 **AWS Elastic Kubernetes Service** 實際操練 ，一次學會兩大維運利器！


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

## CH02 Terraform Advanced
**目標**: 理解日常 Terraform 開發的生命週期，並學習利用第三方的 Provider，甚至是網路上現成的 Module 來加速開發，避免重造輪子

- Commands Overview
	- init, get, plan, apply, destroy...etc
- Other Providers
	- Ignition, Null, Template, Github, Random...etc
- Interpolation
- Modules

## CH03 Terraform Tips
**目標**: Terraform 因為本身的缺陷，導致有一些 Hack 的用法，將比較在大版本 0.12 更新後，有哪些事情需要注意

- Conditional Operator
- Count V.S. For and For-Each
- Splat Operator
- ...

## CH04 Terraform Practices
**目標**: 藉由開發 Module 以及第三方工具 [**Terragrount**]
(https://github.com/gruntwork-io/terragrunt) 達成軟體開發 [**SOLID**](https://en.wikipedia.org/wiki/SOLID) 準則

- Module Development
- Terragrunt Hands-On

## CH5 Terraform & EKS I
**目標**: 理解 AWS EKS 架構，並透過講師所開發的 Modlue 在幾分鐘內將 Production Ready 的 Kubernetse 叢集建構完成

- AWS EKS Infrastructure
- AWS EKS Module: [vishwakarma](https://github.com/getamis/vishwakarma)

## CH06 Terraform & EKS II
**目標**: 利用剛建立好的 Kubernetse Cluster 來理解時下最熱門 Kubernetes 內部資源操作方法，以及在生產環境維運 Kubernetes 的經驗分享

- Go Through Kubernetes 101/201 within AWS EKS
- Kubernetes Management Experience Sharing
